#ifndef NATIVE_WINDOW_H
#define NATIVE_WINDOW_H

#include "window-swift.h"

class Window {
public:
  Window(int width, int height) : internal(Ui::Window::create(width, height)) {}
  void show();

private:
  Ui::Window internal;
};

#endif // NATIVE_WINDOW_H
