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

This function configures the COM1 port with the following settings:  
- Baud rate: 9600  
- Data bits: 8  
- Stop bits: 1  
- Parity: None  
- Flow control: None (relies on THR status)

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