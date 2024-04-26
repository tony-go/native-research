#include "application.h"

#include "swift-lib.h" // TODO: hide it

int main() {
  Application app = Native::App();
  app.run();

  return 0;
}
