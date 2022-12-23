# asdf-ffmpeg [![Build](https://github.com/acj/asdf-ffmpeg/actions/workflows/build.yml/badge.svg)](https://github.com/acj/asdf-ffmpeg/actions/workflows/build.yml) [![Lint](https://github.com/acj/asdf-ffmpeg/actions/workflows/lint.yml/badge.svg)](https://github.com/acj/asdf-ffmpeg/actions/workflows/lint.yml)


[ffmpeg](https://ffmpeg.org) plugin for the [asdf version manager](https://asdf-vm.com).

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add ffmpeg
# or
asdf plugin add ffmpeg https://github.com/acj/asdf-ffmpeg.git
```

ffmpeg:

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

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions are welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/acj/asdf-ffmpeg/graphs/contributors)!

# License

MIT. See [LICENSE](LICENSE) for details.
