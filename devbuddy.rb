class Devbuddy < Formula
  desc "Setup your projects in a consistent way. Help other devs onboard!"
  homepage "https://github.com/devbuddy/devbuddy"
  license "MIT"

  url "https://github.com/devbuddy/devbuddy.git",
      tag:      "v0.12.5",
      revision: "5f1fa743265fea38f5e559fb56cfa85519f3fde1"
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
