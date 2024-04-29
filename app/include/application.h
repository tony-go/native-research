#ifndef NATIVE_APPLICATION_H
#define NATIVE_APPLICATION_H

#include "app-swift.h"

class Application {
public:
  Application() : internal(Native::Application::create()) {}
  void run();

private:
  Native::Application internal;
};

#endif // NATIVE_APPLICATION_H
