#!/usr/bin/env bash
# Helper script to fetch the CAmkES sources and build seL4 for x86_64.
# It attempts to install missing dependencies (repo, git, cmake, ninja-build)
# when run as root on Debian/Ubuntu systems.
set -e

PROJECT_DIR="seL4-project"
BUILD_DIR="build"

need_pkgs=()
for cmd in repo git cmake ninja; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        need_pkgs+=("$cmd")
    fi
done

if [ "${#need_pkgs[@]}" -ne 0 ]; then
    echo "Missing tools: ${need_pkgs[*]}"
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please install the missing packages or rerun as root." >&2
        exit 1
    fi
    if command -v apt-get >/dev/null 2>&1; then
        echo "Installing prerequisites..."
        apt-get update
        apt-get install -y "${need_pkgs[@]}"
    else
        echo "apt-get not found. Install packages manually." >&2
        exit 1
    fi
fi

mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

if [ ! -d .repo ]; then
    repo init -u https://github.com/seL4/camkes-manifest.git
fi

repo sync

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

../init-build.sh -DPLATFORM=x86_64 "$@"

ninja