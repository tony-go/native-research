.PHONY: all setup build clean

# Default target executed
all: build

# Setup build directory and run CMake
setup:
	@mkdir -p build
	@cd build && cmake -G 'Ninja' ../

# Build the project using Ninja
build: setup
	@cd build && ninja

open:
	open ./build/my_app.app

# Clean the build directory
clean:
	@rm -rf build

