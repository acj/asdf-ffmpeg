#!/usr/bin/env bash

set -euo pipefail

RELEASE_URL="https://ffmpeg.org/releases/"
GH_REPO="https://github.com/FFmpeg/FFmpeg"
TOOL_NAME="ffmpeg"
TOOL_TEST="ffmpeg -version"

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

configure_addon_options() {
  local enabled_options supported_options

  # To regenerate this list, download a copy of the ffmpeg source, and then run:
  # ./configure --help | grep -oE "^\s*\-\-enable-[A-Za-z0-9_-]+\s+" | cut -d ' ' -f 1 | sed -e 's/--enable-//g' | sort
  supported_options=(
    avisynth
    chromaprint
    cross-compile
    cuda-nvcc
    decklink
    extra-warnings
    frei0r
    ftrapv
    gcrypt
    gmp
    gnutls
    gpl
    gray
    hardcoded-tables
    jni
    ladspa
    lcms2
    libaom
    libaribb24
    libass
    libbluray
    libbs2b
    libcaca
    libcdio
    libcelt
    libcodec2
    libdav1d
    libdavs2
    libdc1394
    libdrm
    libfdk-aac
    libflite
    libfontconfig
    libfreetype
    libfribidi
    libglslang
    libgme
    libgsm
    libiec61883
    libilbc
    libjack
    libjxl
    libklvanc
    libkvazaar
    liblensfun
    libmfx
    libmodplug
    libmp3lame
    libmysofa
    libnpp
    libopencore-amrnb
    libopencore-amrwb
    libopencv
    libopenh264
    libopenjpeg
    libopenmpt
    libopenvino
    libopus
    libopus
    libplacebo
    libpulse
    librabbitmq
    librav1e
    librist
    librsvg
    librtmp
    librubberband
    libshaderc
    libshine
    libsmbclient
    libsnappy
    libsoxr
    libspeex
    libsrt
    libssh
    libsvtav1
    libtensorflow
    libtesseract
    libtheora
    libtls
    libtwolame
    libuavs3d
    libv4l2
    libvidstab
    libvmaf
    libvo-amrwbenc
    libvorbis
    libvpx
    libwebp
    libx264
    libx265
    libxavs
    libxavs2
    libxcb
    libxcb-shape
    libxcb-shm
    libxcb-xfixes
    libxml2
    libxvid
    libzimg
    libzmq
    libzvbi
    linux-perf
    lto
    lv2
    macos-kperf
    mbedtls
    mediacodec
    mediafoundation
    memory-poisoning
    mmal
    neon-clobber-test
    nonfree
    omx
    omx-rpi
    openal
    opencl
    opengl
    openssl
    ossfuzz
    pic
    pocketsphinx
    random
    rkmpp
    rpath
    shared
    small
    thumb
    vapoursynth
    version3
    xmm-clobber-test
    # If you're adding to this list, please keep it in alphabetical order. Thanks!
  )
  enabled_options=()

  if [[ "${ASDF_FFMPEG_ENABLE:-}" == "all" ]]; then
    for lib in "${supported_options[@]}"; do
      enabled_options+=("--enable-${lib}")
    done
  else
    for lib in $(echo ${ASDF_FFMPEG_ENABLE:-}); do
      if [[ " ${supported_options[*]} " =~ " ${lib} " ]]; then
        enabled_options+=("--enable-${lib}")
      else
        echo "Warning: unsupported library \"${lib}\"" >&2
      fi
    done
  fi

  echo "${enabled_options[@]:-}"
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
    echo "* Configuring ffmpeg with options: $(configure_addon_options)"
    ./configure --prefix="${install_path%/bin}" $(configure_addon_options) || exit 1
    MAKEFLAGS="-j$ASDF_CONCURRENCY" make install || exit 1

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
