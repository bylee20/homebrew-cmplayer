require "formula"

class Libchardet < Formula
  homepage "http://my.oops.org"
  url "http://ftp.oops.org/pub/oops/libchardet/libchardet-1.0.2.tar.bz2"
  sha1 "49b6435961e8dbc347bb0b539e48ac19e36ea08b"

  def install
     patch = <<-EOS
diff -bruN libchardet-1.0.2-orig/Makefile.in libchardet-1.0.2/Makefile.in
--- libchardet-1.0.2-orig/Makefile.in	2014-02-09 15:19:49.000000000 +0900
+++ libchardet-1.0.2/Makefile.in	2014-02-09 15:20:16.000000000 +0900
@@ -28,6 +28,8 @@
 	$(MAKE) -C src
 
 install: install-man
+	$(MKDIR) $(DESTDIR)@libdir@/pkgconfig
+	$(INSTALL) -m644 libchardet.pc $(DESTDIR)@libdir@/pkgconfig
 	$(MAKE) -C src install
 
 install-man:
diff -bruN libchardet-1.0.2-orig/configure libchardet-1.0.2/configure
--- libchardet-1.0.2-orig/configure	2014-02-09 15:19:49.000000000 +0900
+++ libchardet-1.0.2/configure	2014-02-09 15:20:16.000000000 +0900
@@ -8831,7 +8831,7 @@
 fi
 
 
-                    ac_config_files="$ac_config_files Makefile src/Makefile"
+                    ac_config_files="$ac_config_files Makefile src/Makefile libchardet.pc"
 
 cat >confcache <<\_ACEOF
 # This file is a shell script that caches the results of configure
diff -bruN libchardet-1.0.2-orig/libchardet.pc.in libchardet-1.0.2/libchardet.pc.in
--- libchardet-1.0.2-orig/libchardet.pc.in	1970-01-01 09:00:00.000000000 +0900
+++ libchardet-1.0.2/libchardet.pc.in	2014-02-09 15:20:16.000000000 +0900
@@ -0,0 +1,10 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+libdir=@libdir@
+includedir=@includedir@
+
+Name: libchardet
+Description: Mozilla's Universal Charset Detector C/C++ API
+Version: @PACKAGE_VERSION@
+Libs: -L${libdir} -lchardet
+Cflags: -I${includedir}
EOS
    File.open("libchardet-pkgconfig.patch", 'w') { |file| file.write(patch) }
	system "patch -p1 < libchardet-pkgconfig.patch"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
