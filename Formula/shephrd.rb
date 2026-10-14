class Shephrd < Formula
  desc "Adversarial LLM reviewer for Claude Code permission requests"
  homepage "https://github.com/BlaiseMoses01/shephrd"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.1/shephrd-aarch64-apple-darwin.tar.xz"
      sha256 "4cd811212b879c41248412504d3a0d9134c34e231a8ffc6fc3365e512a4e01c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.1/shephrd-x86_64-apple-darwin.tar.xz"
      sha256 "d1448deb99ec8d0353cb99c619e8aac6457e6d0949eb42478f076a09741d6d6c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.1/shephrd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "839a5d0eee7ec27ee6c29f09f63572737b3053f5d1cd62e27e3e860ca74539c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.1/shephrd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93019d08da76744c3765ce7a9a29c56efcfd31346bfa6c6cf69590182387bc92"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "shephrd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shephrd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shephrd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shephrd"
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
