class Goimapnotify < Formula
  desc "Execute scripts on IMAP mailbox changes using IDLE, golang version"
  homepage "https://gitlab.com/shackra/goimapnotify"
  url "https://gitlab.com/shackra/goimapnotify/-/archive/2.3.7/goimapnotify-2.3.7.tar.bz2"
  sha256 "f927732ac4307d0671f3015af6f69cab5e5c82e57fe1374201947f0187214c1c"
  license "GPL-3.0-only"
  head "https://gitlab.com/shackra/goimapnotify.git", branch: "master"

  bottle do
    root_url "https://github.com/bfolkens/homebrew-tap/releases/download/goimapnotify-2.3.7"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "1d60524f3e9fec2567749983d4b06e4a24a67c7521a73c5df86bde7beb0bc35e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "004d05708f187c81fcd760fb34630de40485ceb5d77ee03b0d0b7c615662e7f0"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/shackra/goimapnotify"
    bin_path.install Dir["*"]

    cd bin_path do
      system "go", "build", "-o", bin/"goimapnotify", "."
    end
  end

  test do
    assert_match(/^Usage of .*?goimapnotify/, shell_output("#{bin}/goimapnotify -h 2>&1"))
  end
end
