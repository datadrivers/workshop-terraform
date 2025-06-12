#!/usr/bin/env bash

cd /repo/docs
bundle install
bundle exec jekyll serve --host 0.0.0.0

