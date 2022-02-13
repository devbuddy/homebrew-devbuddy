class Devbuddy < Formula
  desc "Setup your projects in a consistent way. Help other devs onboard!"
  homepage "https://github.com/devbuddy/devbuddy"
  license "MIT"

  url "https://github.com/devbuddy/devbuddy.git",
      tag:      "v0.12.1",
      revision: "d1bafc92bdcf22877d1d3f085fbea66cf81ac820"
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
