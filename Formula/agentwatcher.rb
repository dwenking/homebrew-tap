class Agentwatcher < Formula
  desc "Menu bar health monitor for AI coding sessions"
  homepage "https://github.com/dwenking/agentwatcher"
  url "https://github.com/dwenking/agentwatcher/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f27f04ffbd0916410320290170db4a2f2059b01c6d579c435391cc075a237813"
  license "MIT"

  depends_on :macos
  depends_on "python@3.13"

  def install
    venv = libexec/"venv"
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", venv
    system venv/"bin/pip", "install", buildpath.to_s
    bin.install_symlink venv/"bin/agentwatcher"
  end

  service do
    run [opt_bin/"agentwatcher"]
    keep_alive true
    error_log_path var/"log/agentwatcher.err"
  end

  test do
    system libexec/"venv/bin/python", "-c", "import agentwatcher.core"
  end
end
