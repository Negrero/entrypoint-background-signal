#!/usr/bin/env bash
set -ex

# gracefully stop the app
docker kill --signal="SIGTERM" test

# or
# docker stop signal-fg-app