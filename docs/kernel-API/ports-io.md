# Ports IO

## Functions:

- [portByteIn](#portbytein)
- [portByteOut](#portbyteout)
- [portWordIn](#portwordin)
- [portWordOut](#portwordout)
- [ioWait](#iowait)

---
### **portByteIn**

**> Syntax:**
```c
uint8_t portByteIn(uint16_t port);
```

**> Description:**  
Reads a byte from the specified port.

---
### **portByteOut**

**> Syntax:**
```c
void portByteOut(uint16_t port, uint8_t data);
```

**> Description:**  
Writes a byte to the specified port.

---
### **portWordIn**

**> Syntax:**
```c
uint16_t portWordIn(uint16_t port);
```

**> Description:**  
Reads a word (16 bit) from the specified port.

---
### **portWordOut**

**> Syntax:**   
```c
void portWordOut(uint16_t port, uint16_t data);
```
**> Description:**  
Writes a word (16 bit) to the specified port.

---
### **ioWait**

**> Syntax:**  
```c
void ioWait(void);
```

**> Description:**  
Wait a very small amount of time (1 to 4 microseconds, generally). Useful for implementing a small delay for PIC remapping on old hardware.

---