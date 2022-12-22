# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test ffmpeg https://github.com/acj/asdf-ffmpeg.git "ffmpeg --version"
```

Tests are automatically run in GitHub Actions on push and PR.
