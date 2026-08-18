#!/usr/bin/env bash

# expected to be run within docker container

cd /repo/docs
bundle check || bundle install
bundle exec jekyll serve \
	--host 0.0.0.0 \
	--destination /tmp/jekyll-site
