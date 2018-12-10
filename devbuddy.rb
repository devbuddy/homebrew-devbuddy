class Devbuddy < Formula
  desc "Setup your projects in a consistent way. Help other devs onboard!"
  homepage "https://github.com/devbuddy/devbuddy"
  url "https://github.com/devbuddy/devbuddy.git", :tag => "v0.7.0"
  sha256 "7222ac7fcf08e8f877bc6a56e903a9b46aa6c639dd20efbdb47d2b4abca0d9b5"
  head "https://github.com/devbuddy/devbuddy.git"

  depends_on "go" => :build
  depends_on "dep" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/devbuddy/devbuddy").install buildpath.children

    cd "src/github.com/devbuddy/devbuddy" do
      system "dep", "ensure", "-v", "-vendor-only"

      ENV["DEVBUDDY_PLATFORMS"] = "darwin"
      system "script/buildall"

      bin.install "dist/bud-darwin-amd64" => "bud"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"bud", "--version"
  end
end
