class Jumar < Formula
  desc "Manage git worktrees by editing them as a text buffer."
  homepage "https://github.com/joshbarrington/jumar"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.1.0/jumar-aarch64-apple-darwin.tar.xz"
      sha256 "b0c7fea18e81702f92d9afe5ec983691d2865557a81376e3df4284468d599475"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.1.0/jumar-x86_64-apple-darwin.tar.xz"
      sha256 "71b0d2620966c0f8fbfc99a0020749b9ecbecd54b25ff1e4a4ad6cf3320f0571"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.1.0/jumar-aarch64-unknown-linux-musl.tar.xz"
      sha256 "09961d3aa5478f5e758defc6668f09f86d2d389da1b55caecadacf515b61a2f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.1.0/jumar-x86_64-unknown-linux-musl.tar.xz"
      sha256 "243b824a9c7373ca7172facefbefe3c8e1c0727ff832366bfa261130e47dc375"
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
      bin.install "jumar"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jumar"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jumar"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jumar"
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
