cask "meiro" do
  version "0.5.2"
  sha256 "0bc0873753cc87524e051205b73329f26255d790f1abd1285ca8fb400b75516b"

  url "https://github.com/elianiva/meiro/releases/download/desktop-v#{version}/Meiro-#{version}-macos-universal.dmg",
      verified: "github.com/elianiva/meiro/"
  name "Meiro"
  desc "Lightweight YouTube Music client"
  homepage "https://github.com/elianiva/meiro"

  livecheck do
    url :url
    regex(/^desktop-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        release["tag_name"]&.match(regex)&.[](1)
      end
    end
  end

  # Meiro updates itself through its own signed feed, so a brew upgrade only
  # reinstalls the same release the app already moved past.
  auto_updates true
  depends_on macos: ">= :monterey"

  app "Meiro.app"

  # Meiro is signed ad hoc, without an Apple Developer ID, so Gatekeeper
  # refuses a copy that still carries the download flag. Clearing it here lets
  # the app open on first launch instead of sending the user to System
  # Settings to allow it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Meiro.app"]
  end

  uninstall quit: "com.elianiva.meiro"

  zap trash: [
    "~/Library/Application Support/Meiro",
    "~/Library/Caches/Meiro",
    "~/Library/Logs/Meiro",
    "~/Library/Preferences/com.elianiva.meiro.plist",
    "~/Library/Saved Application State/com.elianiva.meiro.savedState",
  ]
end
