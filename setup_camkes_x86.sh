#!/usr/bin/env bash
# Simple helper script to fetch the CAmkES sources and build seL4 for x86_64.
# Requires: repo, git, python3, cmake, ninja-build, etc.
set -e

# Directory where the manifest will be checked out
PROJECT_DIR="seL4-project"

if [ ! -d "$PROJECT_DIR" ]; then
    mkdir "$PROJECT_DIR"
fi
cd "$PROJECT_DIR"

# Initialize the CAmkES manifest if not already done
if [ ! -d ".repo" ]; then
    repo init -u https://github.com/seL4/camkes-manifest.git
fi

repo sync

# Set up build directory
BUILD_DIR="build"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure for x86_64
../init-build.sh -DPLATFORM=x86_64 "$@"

# Build the image
ninja
