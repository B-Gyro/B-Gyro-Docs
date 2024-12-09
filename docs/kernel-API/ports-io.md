# Ports IO

## Functions:

- [portByteIn](#portbytein)
- [portByteOut](#portbyteout)
- [portWordIn](#portwordin)
- [portWordOut](#portwordout)
- [ioWait](#iowait)

### portByteIn

Reads a byte from the specified port.
```c
uint8_t portByteIn(uint16_t port);
```

### portByteOut

Writes a byte to the specified port.
```c
void portByteOut(uint16_t port, uint8_t data);
```

### portWordIn

Reads a word (16 bit) from the specified port.
```c
uint16_t portWordIn(uint16_t port);
```

### portWordOut

Writes a word (16 bit) to the specified port.
```c
void portWordOut(uint16_t port, uint16_t data);
```

### ioWait
Wait a very small amount of time (1 to 4 microseconds, generally). Useful for implementing a small delay for PIC remapping on old hardware.

```c
void ioWait(void);
```





