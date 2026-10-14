class Shephrd < Formula
  desc "Adversarial LLM reviewer for Claude Code permission requests"
  homepage "https://github.com/BlaiseMoses01/shephrd"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.0/shephrd-aarch64-apple-darwin.tar.xz"
      sha256 "9cdc28667435c2fb145fdcccdcb442af5a888bab9eb31177168a4c6d48f65570"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.0/shephrd-x86_64-apple-darwin.tar.xz"
      sha256 "ca1d81891b368ad3e135e5a82271756874561177b7d343b73ca00ea2bcffb5d0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.0/shephrd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1abccf5578a9098fb8e758e0af5e50fc4398751fef439310df486b02594f6afb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BlaiseMoses01/shephrd/releases/download/v0.1.0/shephrd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10a15e37e76d2c3a71af60742b7664bd99cdef4b7433ba42ec9d15c4f846738c"
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
