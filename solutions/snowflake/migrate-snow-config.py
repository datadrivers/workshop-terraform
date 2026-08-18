#!/usr/bin/env python3
"""Convert a Snow CLI connection TOML file to Terraform provider format."""

import argparse
import os
import stat
import sys
import tempfile
import tomllib
from pathlib import Path


def parse_args() -> argparse.Namespace:
    default_source = Path.home() / "Library/Application Support/snowflake/config.toml"
    default_destination = Path.home() / ".snowflake/config"

    parser = argparse.ArgumentParser(
        description="Migrate a Snow CLI connection to the Terraform provider TOML format."
    )
    parser.add_argument("source", nargs="?", type=Path, default=default_source)
    parser.add_argument("--profile", help="Connection name; defaults to the Snow CLI default.")
    parser.add_argument("--output", type=Path, default=default_destination)
    return parser.parse_args()


def toml_string(value: str) -> str:
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


def main() -> int:
    args = parse_args()
    source = args.source.expanduser()
    destination = args.output.expanduser()

    if not source.is_file():
        print(f"Snow CLI config not found: {source}", file=sys.stderr)
        return 1

    with source.open("rb") as config_file:
        config = tomllib.load(config_file)

    profile = args.profile or config.get("default_connection_name")
    connection = config.get("connections", {}).get(profile)
    if not profile or connection is None:
        print(f"Snow CLI connection not found: {profile or '<default>'}", file=sys.stderr)
        return 1

    fields = ("account", "user", "password", "database", "schema", "warehouse", "role")
    lines = [f"[{profile}]"]
    for field in fields:
        if field in connection:
            lines.append(f"{field} = {toml_string(str(connection[field]))}")
    content = "\n".join(lines) + "\n"

    destination.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
    destination.parent.chmod(stat.S_IRWXU)
    with tempfile.NamedTemporaryFile(
        mode="w", encoding="utf-8", dir=destination.parent, delete=False
    ) as temporary_file:
        temporary_path = Path(temporary_file.name)
        temporary_file.write(content)
        temporary_file.flush()
        os.fchmod(temporary_file.fileno(), stat.S_IRUSR | stat.S_IWUSR)

    temporary_path.replace(destination)
    destination.chmod(stat.S_IRUSR | stat.S_IWUSR)
    print(f"Migrated connection {profile} to {destination}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
