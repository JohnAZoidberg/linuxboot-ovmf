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