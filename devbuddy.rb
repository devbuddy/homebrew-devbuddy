class Devbuddy < Formula
  desc "Setup your projects in a consistent way. Help other devs onboard!"
  homepage "https://github.com/devbuddy/devbuddy"
  license "MIT"

  url "https://github.com/devbuddy/devbuddy.git",
      tag:      "v0.12.6",
      revision: "27ed0a2ce5da989362b2450af15e743e9685a4a4"
  head "https://github.com/devbuddy/devbuddy.git", branch: "master"

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
