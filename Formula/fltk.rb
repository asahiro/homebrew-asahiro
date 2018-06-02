class FltkDevel < Formula
  desc "Cross-platform C++ GUI toolkit (devel)"
  homepage "http://www.fltk.org/"
  url "http://fltk.org/pub/fltk/snapshots/fltk-1.4.x-r12938.tar.gz"
  version "1.4.x-r12938"
  sha256 "380010e391ed71c64248a076f2c9cc6b5e0d6d36f7367ddd3c41017e712a05eb"

  depends_on "libpng"
  depends_on "jpeg"

  conflicts_with "fltk", :because => "just a development version"

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
