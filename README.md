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

Second, choose which options you want to enable. Here is a reasonable starting point with broad support for modern codecs:

```sh
# Tip: put this in your ~/.bashrc or ~/.zshrc so that it's available for future installs
export ASDF_FFMPEG_ENABLE="libaom fontconfig freetype frei0r lame libass libvorbis libvpx opus rtmpdump sdl2 snappy theora x264 x265 xz"
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

If there are errors during the build, you might need to install additional libraries.

## Libraries and add-ons

You can configure FFmpeg to support more features and media formats by enabling options. See the [FFmpeg documentation](https://ffmpeg.org/general.html) for a list of options that are supported by the version you're using.

### Toggling options

This plugin looks for an environment variable named `ASDF_FFMPEG_ENABLE` to determine which options to enable. The value of the variable should be a space-separated list of options. For example, to enable the `libx264` and `libvpx` options, you would set the environment variable like this:

```sh
export ASDF_FFMPEG_ENABLE="libx264 libvpx"
```

It can also be done inline during the install:

```sh
ASDF_FFMPEG_ENABLE="libass libvpx" asdf install ffmpeg latest
```

If you want to pass arbitrary options to ffmpeg's `configure` script, you can use `ASDF_FFMPEG_OPTIONS_EXTRA`:

```sh
export ASDF_FFMPEG_OPTIONS_EXTRA="--extra-version=my-ffmpeg-build"
```

## Tools and utilities

FFmpeg includes a handful of often-overlooked tools that are useful for troubleshooting and other advanced work. These tools are not installed by default, but you can enable them by setting `ASDF_FFMPEG_ENABLE_TOOLS`. For example, to enable `ffescape` and `graph2dot`, use the following:

```sh
export ASDF_FFMPEG_ENABLE_TOOLS="ffescape graph2dot"
```

A full list of tools can be found in the [FFmpeg source tree](https://github.com/FFmpeg/FFmpeg/tree/master/tools).

# Contributing

Contributions are welcome! See the [contributing guide](contributing.md).

# License

MIT. See [LICENSE](LICENSE) for details.
