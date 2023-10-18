# asdf-ffmpeg [![Build](https://github.com/acj/asdf-ffmpeg/actions/workflows/build.yml/badge.svg)](https://github.com/acj/asdf-ffmpeg/actions/workflows/build.yml) [![Lint](https://github.com/acj/asdf-ffmpeg/actions/workflows/lint.yml/badge.svg)](https://github.com/acj/asdf-ffmpeg/actions/workflows/lint.yml)


[ffmpeg](https://ffmpeg.org) plugin for the [asdf version manager](https://asdf-vm.com).

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

To build FFmpeg, you will need to install a few libraries. You can try the commands below. If they don't work for you, please have a look at the [FFmpeg documentation](https://trac.ffmpeg.org/wiki/CompilationGuide).

Depending on the install options you choose, FFmpeg may require more libraries to be installed. See the [Libraries and add-ons](#libraries-and-add-ons) section below.

## macOS with Homebrew

```sh
brew install automake fdk-aac git lame libass libtool libvorbis libvpx \
  opus sdl2 shtool texi2html theora wget x264 x265 xvid nasm zimg
```

You might also need to set `CFLAGS` and `LDFLAGS` so that the compiler/linker toolchain can find headers and libraries from your Homebrew packages:

```sh
export CFLAGS="$CFLAGS -I$(brew --prefix)/include"
export LDFLAGS="$LDFLAGS -L$(brew --prefix)/lib"
```

## Ubuntu

```sh
sudo apt-get update -qq && sudo apt-get -y install \
  autoconf automake build-essential cmake git-core libass-dev \
  libfreetype6-dev libgnutls28-dev libmp3lame-dev libsdl2-dev libtool \
  libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
  libxcb-xfixes0-dev meson ninja-build pkg-config texinfo wget yasm \
  zlib1g-dev
```

# Install

First, install this plugin:

```shell
asdf plugin add ffmpeg
# or
asdf plugin add ffmpeg https://github.com/acj/asdf-ffmpeg.git
```

Then, select a version of ffmpeg and install it:

```shell
# Show all installable versions
asdf list-all ffmpeg

# Install specific version
asdf install ffmpeg latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ffmpeg latest

# Now ffmpeg commands are available
ffmpeg -version
```

## Libraries and add-ons

You can configure FFmpeg to support [more features and media formats](https://ffmpeg.org/general.html#External-libraries) by enabling options.

### Toggling options

This plugin looks for an environment variable named `ASDF_FFMPEG_ENABLE` to determine which options to enable. The value of the variable should be a space-separated list of options. For example, to enable the `libx264` and `libvpx` options, you would set the environment variable like this:

```sh
export ASDF_FFMPEG_ENABLE="libx264 libvpx"
```

It can also be done inline during the install:

```sh
ASDF_FFMPEG_ENABLE="libass libvpx" asdf install ffmpeg latest
```

If you want to enable all supported options, you can set `ASDF_FFMPEG_ENABLE` to `all`:

```sh
export ASDF_FFMPEG_ENABLE="all"
```

If you want to pass arbitrary options to ffmpeg's `configure` script, you can use `ASDF_FFMPEG_OPTIONS_EXTRA`:

```sh
export ASDF_FFMPEG_OPTIONS_EXTRA="--extra-version=my-ffmpeg-build"
```

### Supported options

See the [FFmpeg documentation](https://ffmpeg.org/general.html#External-libraries) for more information about what these options mean.

|  Option | Description |
|---------|-------------|
|  avisynth       |  enable reading of AviSynth script files |
|  chromaprint    | enable audio fingerprinting with chromaprint |
|  cross-compile  | assume a cross-compiler is used
|  cuda-nvcc      | enable Nvidia CUDA compiler |
|  decklink       | enable Blackmagic DeckLink I/O support |
|  extra-warnings | enable more compiler warnings |
|  frei0r         | enable frei0r video filtering |
|  ftrapv         | Trap arithmetic overflows |
|  gcrypt         | enable gcrypt, needed for rtmp(t)e support |
|  gmp            | enable gmp, needed for rtmp(t)e support |
|  gnutls         | enable gnutls, needed for https support |
|  gpl            | allow use of GPL code, the resulting libs |
|  gray           | enable full grayscale support (slower color) |
|  hardcoded-tables | use hardcoded tables instead of runtime generation |
|  jni            | enable JNI support |
|  ladspa         | enable LADSPA audio filtering |
|  lcms2          | enable ICC profile support via LittleCMS 2 |
|  libaom         | enable AV1 video encoding/decoding via libaom |
|  libaribb24     | enable ARIB text and caption decoding via libaribb24 |
|  libass         | enable libass subtitles rende |
|  libbluray      | enable BluRay reading using libbluray |
|  libbs2b        | enable bs2b DSP library |
|  libcaca        | enable textual display using libcaca |
|  libcdio        | enable audio CD grabbing with libcdio |
|  libcelt        | enable CELT decoding via libcelt |
|  libcodec2      | enable codec2 en/decoding using libcodec2 |
|  libdav1d       | enable AV1 decoding via libdav1d |
|  libdavs2       | enable AVS2 decoding via libdavs2 |
|  libdc1394      | enable IIDC-1394 grabbing using libd |
|  libdrm         | enable DRM code (Linux) |
|  libfdk-aac     | enable AAC de/encoding via libfdk-aac |
|  libflite       | enable flite (voice synthesis) support via libflite |
|  libfontconfig  | enable libfontconfig, useful for drawtext filter |
|  libfreetype    | enable libfreetype, needed for drawtext filter |
|  libfribidi     | enable libfribidi, improves drawtext filter |
|  libglslang     | enable GLSL->SPIRV compilation via libglslang |
|  libgme         | enable Game Music Emu via libgme |
|  libgsm         | enable GSM de/encoding via libgsm |
|  libiec61883    | enable iec61883 via libiec61883 |
|  libilbc        | enable iLBC de/encoding via libilbc |
|  libjack        | enable JACK audio sound server |
|  libjxl         | enable JPEG XL de/encoding via libjxl |
|  libklvanc      | enable Kernel Labs VANC processing |
|  libkvazaar     | enable HEVC encoding via libkvazaar |
|  liblensfun     | enable lensfun lens correction |
|  libmfx         | enable Intel MediaSDK (AKA Quick Sync Video) code via libmfx |
|  libmodplug     | enable ModPlug via libmodplug |
|  libmp3lame     | enable MP3 encoding via libmp3lame |
|  libmysofa      | enable libmysofa, needed for sofalizer filter |
|  libnpp         | enable Nvidia Performance Primitives-based code |
|  libopencore-amrnb | enable AMR-NB de/encoding via libopencore-amrnb |
|  libopencore-amrwb | enable AMR-WB decoding via libopencore-amrwb |
|  libopencv      | enable video filtering via libopencv |
|  libopenh264    | enable H.264 encoding via OpenH264 |
|  libopenjpeg    | enable JPEG 2000 de/encoding via OpenJPEG |
|  libopenmpt     | enable decoding tracked files via libopenmpt |
|  libopenvino    | enable OpenVINO as a DNN module ba |
|  libopus        | enable Opus de/encoding via libopus |
|  libplacebo     | enable libplacebo library |
|  libpulse       | enable Pulseaudio input via libpulse |
|  librabbitmq    | enable RabbitMQ library |
|  librav1e       | enable AV1 encoding via rav1e |
|  librist        | enable RIST via librist |
|  librsvg        | enable SVG rasterization via librsvg |
|  librtmp        | enable RTMP[E] support via librtmp |
|  librubberband  | enable rubberband needed for rubberband filter |
|  libshaderc     | enable GLSL->SPIRV compilation via libshaderc |
|  libshine       | enable fixed-point MP3 encoding via libshine |
|  libsmbclient   | enable Samba protocol via libsmbclient |
|  libsnappy      | enable Snappy compression, needed for hap encoding |
|  libsoxr        | enable Include libsoxr resampling |
|  libspeex       | enable Speex de/encoding via libspeex |
|  libsrt         | enable Haivision SRT protocol via libsrt |
|  libssh         | enable SFTP protocol via libssh |
|  libsvtav1      | enable AV1 encoding via SVT |
|  libtensorflow  | enable TensorFlow as a DNN module backend |
|  libtesseract   | enable Tesseract, needed for ocr filter |
|  libtheora      | enable Theora encoding via libtheora |
|  libtls         | enable LibreSSL (via libtls), needed for https support |
|  libtwolame     | enable MP2 encoding via libtwolame |
|  libuavs3d      | enable AVS3 decoding via libuavs3d |
|  libv4l2        | enable libv4l2/v4l-utils |
|  libvidstab     | enable video stabilization using vid.stab  |
|  libvmaf        | enable vmaf filter via libvmaf  |
|  libvo-amrwbenc | enable AMR-WB encoding via libvo-amrwbenc  |
|  libvorbis      | enable Vorbis en/decoding via libvorbis |
|  libvpx         | enable VP8 and VP9 de/encoding via libvpx  |
|  libwebp        | enable WebP encoding via libwebp  |
|  libx264        | enable H.264 encoding via x264  |
|  libx265        | enable HEVC encoding via x265  |
|  libxavs        | enable AVS encoding via xavs  |
|  libxavs2       | enable AVS2 encoding via xavs2  |
|  libxcb         | enable X11 grabbing using XCB |
|  libxcb-shape   | enable X11 grabbing shape rendering |
|  libxcb-shm     | enable X11 grabbing shm communication |
|  libxcb-xfixes  | enable X11 grabbing mouse rendering |
|  libxml2        | enable XML parsing using the C library libxml2 |
|  libxvid        | enable Xvid encoding via xvidc |
|  libzimg        | enable z.lib, needed for zscale filter  |
|  libzmq         | enable message passing via libzmq  |
|  libzvbi        | enable teletext support via libzvbi  |
|  linux-perf     | enable Linux Performance Monitor |
|  lto            | use link-time optimization |
|  lv2            | enable LV2 audio filtering  |
|  macos-kperf    | enable macOS kperf (private) |
|  mbedtls        | enable mbedTLS, needed for https support |
|  mediacodec     | enable Android MediaCodec support  |
|  mediafoundation  | enable encoding via MediaFoundation |
|  memory-poisoning | fill heap uninitialized allocated space with arbitrary  |
|  mmal           | enable Broadcom Multi-Media Abstraction Layer (Raspberry Pi) via MMAL |
|  neon-clobber-test | check NEON registers for clobbering (should be used for debugging purposes only |
|  nonfree        | allow use of nonfree code, the resulting libs and binaries will be unredistributable |
|  omx            | enable OpenMAX IL code |
|  omx-rpi        | enable OpenMAX IL code for Raspberry Pi |
|  openal         | enable OpenAL 1.1 capture support |
|  opencl         | enable OpenCL processing |
|  opengl         | enable OpenGL rendering |
|  openssl        | enable openssl, needed for https su |
|  ossfuzz        | Enable building fuzzer |
|  pic            | build position-independent |
|  pocketsphinx   | enable PocketSphinx, needed for asr filter |
|  random         | randomly enable/disable components |
|  rkmpp          | enable Rockchip Media Process Platform code |
|  rpath          | use rpath to allow installing libraries in paths |
|  shared         | build shared libraries |
|  small          | optimize for size instead of  |
|  thumb          | compile for Thumb instructio |
|  vapoursynth    | enable VapourSynth demuxer |
|  version3       | upgrade (L)GPL to version 3 |
|  xmm-clobber-test | check XMM registers for clobbering |


# Contributing

Contributions are welcome! See the [contributing guide](contributing.md).

# License

MIT. See [LICENSE](LICENSE) for details.
