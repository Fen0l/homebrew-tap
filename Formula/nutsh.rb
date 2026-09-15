class Nutsh < Formula
  desc "A Nutanix TUI that tells you why it's broken"
  homepage "https://nutsh.dev"
  version "0.0.2-beta3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta3/nutsh-aarch64-apple-darwin.tar.xz"
      sha256 "9e6cb30e8e99063f50526131ab6f375fa188ee06006e2797f7929bb11ff80a3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta3/nutsh-x86_64-apple-darwin.tar.xz"
      sha256 "98641afcd9311bf6e2faa4f4aefbbedae5e24edda36681478a3e8083dd2ce581"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta3/nutsh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07f6d8d4e552f829193b1d4cb83a060d32405ddda569cb6a6bb397b017734dab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta3/nutsh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5a2bfe48ba3b46bb5dc6d795dbaa0a8032f3d0c91a3abcb60f967f43c5ef84d1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "nutsh"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nutsh"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "nutsh"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nutsh"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
