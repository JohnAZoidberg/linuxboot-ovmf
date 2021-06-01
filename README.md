# LinuxBoot OVMF

Build an OVMF image with an embedded Linux kernel.

# Building

Simply provide a Linux kernel (bzImage) in the root directory of this project named `linux`, then:

```
make
```

The provided kernel must have `CONFIG_EFI_STUB` enabled. Also, make sure `CONFIG_TTY` and `CONFIG_PRINTK` are enabled in order to see kernel messages during testing.

# Testing

To run the generated `linuxboot.rom` in QEMU:

```
make run
```

# Requirements

- Go 1.14+ (container uses 1.16)
- [UTK](https://github.com/linuxboot/fiano) v5.0.0
- Perl (for `bin/create-ffs`, waiting on [UTK functionality](https://github.com/linuxboot/fiano/pull/239))
# Docker Container

Build the container image using the provided Dockerfile using:

```
./docker_build
```

Then, run the container with:

```
./docker_run
```

The repository source will be mounted at `/linuxboot-ovmf`. From here, you can run the `make` commands specified above.


## Minimal config

```
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y

CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y

CONFIG_EMBEDDED=y

CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0"

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="/tmp/initramfs.linux_amd64.cpio"
CONFIG_INITRAMFS_ROOT_UID=0
CONFIG_INITRAMFS_ROOT_GID=0
CONFIG_RD_GZIP=y
CONFIG_INITRAMFS_COMPRESSION_GZIP=y
```
