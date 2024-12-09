# Welcome to B-Gyro

this document is a guide to help you get started with B-Gyro. If you have any questions or need help, feel free to reach out to us at [b.gyro.os@gmail.com](mailto:b.gyro.os@gmail.com)

## Table of Contents

- [Prerequisites](#prerequisites)
- [Play-Test](#play-test)
- [kernel API](#kernel-api)

## Prerequisites

Before you begin, ensure you have met the following requirements:
- docker and docker-compose installed on your machine.
- qemu-system-x86_64 installed on your machine.

## play-test:

To play-test B-Gyro, follow these steps:

1. just clone the repository and run the following command:
```bash
make
```
2. To run the operating system, run the following command:
```bash
make run
```

## kernel API

- [Ports IO](kernel-API/ports-io.md)
- [Serial Communication](kernel-API/serial-communication.md)
- [VGA Display](kernel-API/vga-display.md)
- [Keyboard Input](kernel-API/keyboard-input.md)
- [Memory Management](kernel-API/memory-management.md)
