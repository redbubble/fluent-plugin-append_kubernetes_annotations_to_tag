#!/bin/sh
mkdir -p ~/.gem/
echo "--- \n:rubygems_api_key: ${GEM_HOST_API_KEY}" > ~/.gem/credentials
chmod 600 ~/.gem/credentials
gem push fluent-plugin-append-kubernetes-annotations-to-tag-${VERSION}.gem