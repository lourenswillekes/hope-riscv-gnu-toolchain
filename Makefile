.PHONY: all
.PHONY: toolchain

all: toolchain

toolchain: build/Makefile
	$(MAKE) -C build | tee -a build/build.log
	$(MAKE) -C build install | tee -a build/build.log

build/Makefile:
	rm -rf build
	mkdir -p build
	cd build && RISCV=$(DOVER) ../configure \
		--prefix=$(DOVER) \
		--disable-atomic --disable-float --enable-multilib | \
		tee -a build.log

clean:
	rm -rf build
