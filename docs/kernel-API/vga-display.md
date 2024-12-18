# vga display

## Functions

- [putCellOnVga](#putcellonvga)
- [setVgaColor](#setvgacolor)


---

### **putCellOnVga**

**>> Syntax:**
```c
void putCellOnVga(_vgaCell cell, uint8_t x, uint8_t y);
```

**>> Description:**

Takes a **[_vgaCell](/kernel-API/_typedefs/#_vgacell)**, which contains a **character** and **its associated color**, and prints it at the specified **position (x, y)** on the **VGA** screen.  
*Uses the color information stored in the data struct to display the character with the correct color.*

**>> Parameters:**

- **cell:** A **[_vgaCell](/kernel-API/_typedefs/#_vgacell)** to be displayed.
- **x:** The X-coordinate on the VGA screen where the cell will be displayed.
- **y:** The Y-coordinate on the VGA screen where the cell will be displayed.

---
### **setVgaColor**

**>> Syntax:**
```c
void setVgaColor(uint8_t ansiNbr);
```

**>> Description:**

Sets the current **text** or **background** **color** based on the provided `ansiNbr`.   
*It converts the ANSI color code into a corresponding VGA color and stores it as the current color for subsequent text or background rendering.*

**>> Supported Color Codes:**

| Color Name	|	VGA	|	Text Color	|	Background Color	|	VGA	|	Bright Text Color	|	Bright Background Color	|
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Black	|	0	|	30	|	40	|	8	|	90	|	100	|
| Blue	|	1	|	34	|	44	|	9	|	94	|	104	|
| Green	|	2	|	32	|	42	|	10	|	92	|	102	|
| Cyan	|	3	|	36	|	46	|	11	|	96	|	106	|
| Red	|	4	|	31	|	41	|	12	|	91	|	101	|
| Magenta	|	5	|	35	|	45	|	13	|	95	|	105	|
| Yellow	|	6	|	33	|	43	|	14	|	93	|	103	|
| White	|	7	|	37	|	47	|	15	|	97	|	107	|
| Default	|	-	|	39	|	49	|	-	|	-	|	-	|
| Reset	|	-	|	0	|	0	|	-	|	-	|	-	|

