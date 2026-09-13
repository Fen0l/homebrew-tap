class Nutsh < Formula
  desc "A Nutanix TUI that tells you why it's broken"
  homepage "https://nutsh.dev"
  version "0.0.2-beta1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta1/nutsh-aarch64-apple-darwin.tar.xz"
      sha256 "12ef45cdca3746f4b63b94dcbb3ddb7ba47bab0a04290165e056e66aedd14e76"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta1/nutsh-x86_64-apple-darwin.tar.xz"
      sha256 "aa2ecd0556d5df995d521991f2556329108099bff44f725dee6220bd49fae146"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta1/nutsh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ec8dd37f9c49900f182cfb1a9d5a0c759cd3c4feecd4ee9d73c7afe777990475"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fen0l/nutsh/releases/download/v0.0.2-beta1/nutsh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "615d757c6e8967eb37bd1eed828291709809a8dd1d82cea051cfdcc1a74fd357"
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
