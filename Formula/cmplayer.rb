require "formula"

class Cmplayer < Formula
  homepage "http://cmplayer.github.io"
  version "0.8.10"
  url "https://github.com/xylosper/cmplayer/releases/download/v#{version}/cmplayer-#{version}-source.tar.gz"
  sha1 "42b8f2883f155f6b9d0259aba97c2c67001f6041"

  depends_on :xcode => :build
  depends_on 'pkg-config' => :build
  depends_on 'mpv-player/mpv/libass-ct'
  depends_on 'xylosper/cmplayer/libchardet'
  depends_on "libdvdread"
  depends_on "libdvdnav"
  depends_on "libquvi"
  depends_on "mpg123"
  depends_on "icu4c"
  depends_on "ffmpeg"
  depends_on "qt5"

  def install
    system "sed -i '' 's/icu-uc$/icu-uc libchardet/' src/cmplayer/cmplayer.pro"
    system "./build-mpv"
    system "make", "cmplayer"
    cp_r "./build/CMPlayer.app", prefix
  end

  def caveats; <<-EOS.undent
    To install CMPlayer into /Applications folder, run nex:

      ln -s #{prefix}/CMPlayer.app /Applications

    When uninstall CMPlayer, delete the link manually.
    EOS
  end
end
