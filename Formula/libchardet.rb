require "formula"

class Libchardet < Formula
  homepage "http://my.oops.org"
  url "http://ftp.oops.org/pub/oops/libchardet/libchardet-1.0.4.tar.bz2"
  sha1 "6da19234b71e063a38f808bb56115b88762774c0"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
