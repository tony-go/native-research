#include "application.h"
#include "window.h"

int main() {
  Application app = Application();
  Window window = Window(800, 600);

  app.setWindow(window); // TODO: use reference
  app.run();

  return 0;
}
