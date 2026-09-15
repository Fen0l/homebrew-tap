class Nutsh < Formula
  desc "A Nutanix TUI that tells you why it's broken"
  homepage "https://nutsh.dev"
  version "0.0.2-beta2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta2/nutsh-aarch64-apple-darwin.tar.xz"
      sha256 "00fa70a29f9eaade740d4a365fbdf34502c6ff071639121777a55a4fc1939437"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta2/nutsh-x86_64-apple-darwin.tar.xz"
      sha256 "ea8acd16203e0125ae0b2a9e96597f1cc001bfea65acc3bb5ef00e45091479e7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta2/nutsh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93dcb3bee099579eab0c65ae7e54f4a0938f407f53a4bab38e4489fdfafa692b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta2/nutsh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "80fc722e5700bc63c343282e6f4f356b8ae3afa000c0f89ac38ec27ef2482f4b"
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
