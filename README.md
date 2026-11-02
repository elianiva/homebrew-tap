# Meiro tap

```sh
brew install --cask elianiva/tap/meiro
```

The cask installs the universal build, which runs on Apple silicon and Intel
Macs. Meiro then updates itself, so `brew upgrade` is not needed.

Homebrew may say `Trusted cask elianiva/tap/meiro` and add it to
`~/.homebrew/trust.json`. That is expected for a tap outside `homebrew/*`.

## Not notarized

Meiro is signed ad hoc, without an Apple Developer ID, so macOS cannot check
it. Homebrew sets the download quarantine flag on the disk image, and
Gatekeeper refuses an app that still has it. The cask clears the flag after
install, so Meiro opens on the first launch.

Remove it yourself after installing a disk image by hand:

```sh
xattr -dr com.apple.quarantine /Applications/Meiro.app
```

`brew uninstall --cask --zap meiro` also removes Meiro's settings, cache and
logs.

## Updating the cask

`.github/workflows/bump.yml` reads the newest `desktop-v` release of
[elianiva/meiro](https://github.com/elianiva/meiro) every day and commits its
version and checksum to `Casks/meiro.rb`.
