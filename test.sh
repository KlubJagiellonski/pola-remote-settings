#!/usr/bin/env bash
set -e

echo "Running tests for configuration files"

npm install
npm test
