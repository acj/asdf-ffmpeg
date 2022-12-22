#!/usr/bin/env bash

set -euo pipefail

RELEASE_URL="https://ffmpeg.org/releases/"
GH_REPO="https://github.com/FFmpeg/FFmpeg"
TOOL_NAME="ffmpeg"
TOOL_TEST="ffmpeg --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  curl "${curl_opts[@]}" https://ffmpeg.org/releases/ | sed -rn 's/^.*ffmpeg-([[:digit:]]+\.[[:digit:]]+(\.[[:digit:]]+))\.tar\.gz[^\.].*$/\1/p'
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  url="$RELEASE_URL/ffmpeg-${version}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"

    cd "$ASDF_DOWNLOAD_PATH"
    ./configure --prefix="${install_path%/bin}"
    MAKEFLAGS="-j$ASDF_CONCURRENCY" make
    make install

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
