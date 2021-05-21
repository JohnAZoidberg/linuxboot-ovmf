all: linuxboot.rom

linuxboot.rom: image-files.txt linux.ffs linuxboot/linuxboot.ffs
	utk \
		OVMF.fd \
		remove_dxes_except image-files.txt \
		insert_dxe linuxboot/linuxboot.ffs \
		insert_dxe linux.ffs \
		save $@

linuxboot/linuxboot.ffs:
	$(MAKE) -C $(dir $@)

linux.ffs: linux
	./bin/create-ffs \
		-o $@ \
		--name Linux \
		--type APPLICATION \
		--version 1.0 \
		--guid DECAFBAD-6548-6461-732D-2F2D4E455246 \
		$<

run: linuxboot.rom
	qemu-system-x86_64 \
		-L . \
		-net none \
		-nographic \
		-bios linuxboot.rom

clean:
	rm -f *.{ffs,rom}
	$(MAKE) -C linuxboot clean
