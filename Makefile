CPUS        := $(nproc)
SHELL       := /bin/bash
EDK2_URL    := https://github.com/johnazoidberg/edk2
EDK2_BRANCH := ovmf-16mb-linuxboot-in-edk2

all: linuxboot.rom

linuxboot.rom: \
	image-files.txt \
	linux.ffs \
	edk2/Build/OvmfX64/DEBUG_GCC5/FV/OVMF.fd
	utk \
		edk2/Build/OvmfX64/DEBUG_GCC5/FV/OVMF.fd \
		remove_dxes_except image-files.txt \
		insert_dxe linux.ffs \
		save $@

	$(MAKE) -C $(dir $@)

# We unfortunately need the Perl version of create-ffs until the utk version
# gets merged in:
# https://github.com/linuxboot/fiano/pull/239
linux.ffs: linux
	./bin/create-ffs \
		-o $@ \
		--name Linux \
		--type APPLICATION \
		--version 1.0 \
		--guid DECAFBAD-6548-6461-732D-2F2D4E455246 \
		$<

edk2/Build/OvmfX64/DEBUG_GCC5/FV/OVMF.fd: edk2/.git
	cd edk2 \
		&& $(MAKE) -C BaseTools \
		&& source edksetup.sh \
		&& build -D FD_SIZE_16MB

edk2/.git:
	git clone --depth 1 --branch $(EDK2_BRANCH) $(EDK2_URL)
	cd $(dir $@) \
		&& git submodule update --init

run: linuxboot.rom
	qemu-system-x86_64 \
		-L . \
		-net none \
		-nographic \
		-bios linuxboot.rom

clean:
	rm -f *.{ffs,rom}
	$(MAKE) -C linuxboot clean

distclean: clean
	rm -rf edk2
