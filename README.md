<div align="center">

# asdf-ffmpeg [![Build](https://github.com/acj/asdf-ffmpeg/actions/workflows/build.yml/badge.svg)](https://github.com/acj/asdf-ffmpeg/actions/workflows/build.yml) [![Lint](https://github.com/acj/asdf-ffmpeg/actions/workflows/lint.yml/badge.svg)](https://github.com/acj/asdf-ffmpeg/actions/workflows/lint.yml)


[ffmpeg](https://github.com/acj/asdf-ffmpeg) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

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
ffmpeg --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/acj/asdf-ffmpeg/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Adam Jensen](https://github.com/acj/)
