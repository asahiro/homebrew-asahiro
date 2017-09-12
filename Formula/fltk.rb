class Fltk < Formula


  desc "Cross-platform C++ GUI toolkit"
	revision 2
  homepage "http://www.fltk.org/"

	stable do
		url "http://fltk.org/pub/fltk/1.3.4/fltk-1.3.4-source.tar.gz"
		mirror "https://ftp.osuosl.org/pub/blfs/conglomeration/fltk/fltk-1.3.4-source.tar.gz"
		mirror "https://fossies.org/linux/misc/fltk-1.3.4-source.tar.gz"
		sha256 "c8ab01c4e860d53e11d40dc28f98d2fe9c85aaf6dbb5af50fd6e66afec3dc58f"
	end

	devel do
    url "http://www.fltk.org/software.php?VERSION=1.4.x-r12411&FILE=fltk/snapshots/fltk-1.4.x-r12431.tar.bz2"
    sha256 "e3a63d323a4989f87114086e8db80f2e3fc5b319a0c324a8893a0a93c1bf1e9b"
	end

	depends_on "libpng"
	depends_on "jpeg"

  def install
    system "./configure", "--prefix=#{prefix}",
		                      "--enable-threads",
							            "--enable-shared"
	  system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
	    #include <FL/Fl.H>
			#include <FL/Fl_Window.H>
			#include <FL/Fl_Box.H>
			int main(int argc, char **argv) {
			  Fl_Window *window = new Fl_Window(340,180);
			  Fl_Box *box = new Fl_Box(20,40,300,100,"Hello, World!");
			  box->box(FL_UP_BOX);
			  box->labelfont(FL_BOLD+FL_ITALIC);
			  box->labelsize(36);
			  box->labeltype(FL_SHADOW_LABEL);
			  window->end();
			  return 0;
			}
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lfltk", "-o", "test"
    system "./test"
  end
end
