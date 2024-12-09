# Serial Communication

## Functions

- [initSerial](#initserial)
- [isTransmitEmpty](#istransmitempty)
- [serialPutChar](#serialputchar)

---
### **initSerial**

**> Syntax:**
```c
int initSerial(void);
```

**> Description:**

Initializes the serial communication using the UART protocol.

This function configures the serial port with the following settings:  
- Disables all serial interrupts.  
- Enables DLAB to set the baud rate divisor.  
- Sets the baud rate to 38400.  
- Configures the port for 8 bits, no parity, and one stop bit.  
- Enables and clears the FIFO with a 14-byte threshold.  
- Enables IRQs and sets RTS/DSR.  
- Tests the serial chip in loopback mode.  
- Verifies the serial chip functionality.  
- Sets the serial port to normal operation mode if the chip is functional.  

Returns `0` on success, `1` if the serial chip is faulty.  

---
### **isTransmitEmpty**

**> Syntax:**
```c
int isTransmitEmpty(void);
```

**> Description:**

Checks if the transmit buffer is empty.

This function returns `1` if the transmit buffer is empty, otherwise it returns `0`.

---
### **serialPutChar**

**> Syntax:**
```c
uint8_t serialPutChar(char c);
```

**> Description:**

Sends a character over the serial port.

This function places the character `c` into the transmit buffer and returns `1`. If the buffer is full, it waits until the buffer is empty and then places the character in the buffer.

---
## **Note**

All these functions use the COM1 port for serial communication.

---