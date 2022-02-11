class Devbuddy < Formula
  desc "Setup your projects in a consistent way. Help other devs onboard!"
  homepage "https://github.com/devbuddy/devbuddy"
  url "https://github.com/devbuddy/devbuddy.git", :tag => "v0.12.0"
  sha256 "7222ac7fcf08e8f877bc6a56e903a9b46aa6c639dd20efbdb47d2b4abca0d9b5"
  license "MIT"
  head "https://github.com/devbuddy/devbuddy.git"

  depends_on "go" => :build

  def install
    versionString = Utils.popen_read("git describe --tags --dirty --always").chomp + "-homebrew"
    ldflags = "-s -w -X main.Version=#{versionString}"
    system "go", "build", *std_go_args(ldflags: ldflags), "-o", "bud", "./cmd/bud"

    bin.install "bud"
    prefix.install_metafiles
  end

  test do
    system bin/"bud", "--version"
  end
end
