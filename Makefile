.PHONY: all
.PHONY: toolchain

all: toolchain

toolchain: build/Makefile
	$(MAKE) -C build
	$(MAKE) -C build install

build/Makefile:
	rm -rf build
	mkdir -p build
	cd build && RISCV=$(DOVER) ../configure \
		--prefix=$(DOVER) \
		--disable-atomic --disable-float --enable-multilib

clean:
	rm -rf build
