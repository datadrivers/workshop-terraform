# Terraform Workshop

This repository includes the documentation and the code examples for a terraform workshop.

## Development

### Run website locally

```bash
cd docs
bundle install
bundle exec jekyll serve
```

or if you do not have faith in your local ruby installation

```bash
docker run --rm -ti -p 4000:4000 -v "$(pwd)":/repo ruby:3.2.8-bookworm /repo/run.sh
```
