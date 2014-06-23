require "formula"

class Cmplayer < Formula
  homepage "http://cmplayer.github.io"
  version "0.8.16"
  url "https://github.com/xylosper/cmplayer/releases/download/v#{version}/cmplayer-#{version}-source.tar.gz"
  sha1 "21978df13095f4e8b201238dc0ebeee464063dd2"

  depends_on :xcode => :build
  depends_on 'pkg-config' => :build
  depends_on 'mpv-player/mpv/libass-ct'
  depends_on 'xylosper/cmplayer/libchardet'
  depends_on "libdvdread"
  depends_on "libdvdnav"
  depends_on "libbluray"
  depends_on "libquvi"
  depends_on "mpg123"
  depends_on "icu4c"
  depends_on "ffmpeg"
  depends_on "qt5"

  def install
    system "./configure", "--enable-quvi4", "--qmake=qmake", "--macdeployqt=macdeployqt"
    system "make"
    cp_r "./build/CMPlayer.app", prefix
  end

  def caveats; <<-EOS.undent
    To install CMPlayer into /Applications folder, run nex:

      ln -s #{prefix}/CMPlayer.app /Applications

    When uninstall CMPlayer, delete the link manually.
    EOS
  end
end
