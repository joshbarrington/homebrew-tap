class Jumar < Formula
  desc "Manage git worktrees by editing them as a text buffer."
  homepage "https://github.com/joshbarrington/jumar"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.2.0/jumar-aarch64-apple-darwin.tar.xz"
      sha256 "dc80a073da4c4cad70bd439ad62bb35a23b4ec5c92c94f25b267982dbcead72c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.2.0/jumar-x86_64-apple-darwin.tar.xz"
      sha256 "1b4ac2fd66c8dc5ca7f236922c84024fe3476cbf256f9a964ab50c9f591ad1be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.2.0/jumar-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6ebda816b2d93f70f3871e2c39629dff617ff9351e829e230c4d9fabea618bab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshbarrington/jumar/releases/download/v0.2.0/jumar-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7f761a737d6fa59c27d32e934db67122503ae50c1aa8795f59d7427aff0c9388"
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
