# Meiro tap

```sh
brew install --cask elianiva/tap/meiro
```

The cask installs the universal build, which runs on Apple silicon and Intel
Macs. Meiro then updates itself, so `brew upgrade` is not needed.

## Not notarized

Meiro is signed ad hoc, without an Apple Developer ID, so macOS cannot check
it. The cask removes the download quarantine flag from Meiro after install, so
the app opens without a security prompt. Do the same for a disk image you
install by hand:

```sh
xattr -dr com.apple.quarantine /Applications/Meiro.app
```

`brew uninstall --cask --zap meiro` also removes Meiro's settings, cache and
logs.

## Updating the cask

`.github/workflows/bump.yml` reads the newest `desktop-v` release of
[elianiva/meiro](https://github.com/elianiva/meiro) every day and commits the
version and checksum to `Casks/meiro.rb`.
