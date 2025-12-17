# **Memory**

---
## **Physical**
<!-- - [framesBitmap](#framesBitmap)
- [allocFrame](#allocFrame)
- [freeFrame](#freeFrame)
- [getFrameAddr](#getFrameAddr) -->
---

### **framesBitmap**

**>> Syntax:**
```c
uint8_t	framesBitmap[THEORICAL_FRAMES_NUMBER / UINT8_SIZE]; 
```

**>> Description:**

`framesBitmap` is an array of bits that tracks physical memory where:

- **bit == 0** → frame is free
- **bit == 1** → frame is allocated

```

				framesBitmap[0]                  framesBitmap[1] {8 bits == 8 frames}
		┌───────────────┼───────────────┐┌───────────────┼───────────────┐
		+---+---+---+---+---+---+---+---++---+---+---+---+---+---+---+---+
		| 1 | 0 | 0 | 1 | 1 | 0 | 0 | 1 || 1 | 0 | 0 | 1 | 1 | 0 | 0 | 1 |
		+---+---+---+---+---+---+---+---++---+---+---+---+---+---+---+---+
		└───────────────┼───────────────┘
				8 physical frames
		┌───────────────┼───────────────────────────────────────┐
		+------+------+------+------+------+------+------+------+
		| PF 0 | PF 1 | PF 2 | PF 3 | PF 4 | PF 5 | PF 6 | PF 7 |
		+------+------+------+------+------+------+------+------+
					PHYSICAL MEMORY (frames - 4kb per frame)
	
```

- **THEORICAL_FRAMES_NUMBER**: total number of physical memory frames, assuming an entire 4 GB of physical memory is available for use.

### **allocFrame**

**>> Syntax:**
```c
uint32_t	allocFrame(uint32_t end);
```

**>> Description:**

Searches the physical memory bitmap for a free frame, starting from the last search position to avoid rescanning from the beginning. If the end of the bitmap is reached, the search restarts from 0. 
Once a free frame is found, its physical address is computed, the corresponding bitmap bit is set to 1 to mark it as allocated, and the address is returned.

**>> Parameters:**

- **end:** always give it 0. #used to restart search from 0 in case the end of bitmap is reached 

### **freeFrame**

**>> Syntax:**
```c
void	freeFrame(uint32_t ptr);
```

**>> Description:**

Frees a previously allocated physical frame `ptr` by unsetting its corresponding bit in the physical memory bitmap, marking the frame as available again.

### **getFrameAddr**

**>> Syntax:**
```c
uint32_t	getFrameAddr(uint32_t vAddr);
```

**>> Description:**

Translates a virtual address `vAddr` to its corresponding physical address using the page tables.

---

## Virtual
<!-- - [allocPages](#allocFrame)
- [freePages](#freePages) -->
---


### **pagesBitmap**

**>> Syntax:**
```c
uint32_t	pagesBitmap[PAGES_BITMAP_SIZE]; 
```

**>> Description:**

Each 2 bits in the array `pagesBitmap` corresponds to a virtual page, and its value describes how that virtual address range is allocated:

- **bits == 00** → page is free (== 4 kb address range unused)
- **bits == 01** → first page of an allocated block
- **bits == 10** → allocated page followed by another allocated page
- **bits == 11** → last page of an allocated block

```

		                           pagesBitmap[0] {32 bits == 16 page}                                    
┌───────────────────────────────────────┼───────────────────────────────────────┐
+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
|   00   |   00   |   00   |   00   |   01   |   10   |   10   |   10   |   10   |   11   |   00   |   00   |   00   |   11   |   00   |   00   |
+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
|        |                          └──────────────────────────┼──────────────────────────┘                          └────┼───┘
|		 |			                                  allocated block                                                allocated
|        |											used address range										used address range [4kb]
|        |                         ┌──────────────────────────┼──────────────────────────┐                           ┌───┼───┐
0x1000   0x2000   0x3000   0x4000  [0x5000   0x6000   0x7000   0x8000   0x9000   0xA000  [0xB000   0xC000   0xD000  [0xE000  [0xF000   0x10000  0x11000

	
```

**>> Syntax:**
```c
uint32_t	allocPages(uint32_t numberOfPages, uint32_t heapStart, uint32_t end);
```

**>> Syntax:**
```c
size_t	freePages(uint32_t ptr, uint32_t heapStart);
```

---

## Memory mapping
---


- [mapPage](#mapPage)
- [unmapPage](#unmapPage)
- [kmmap](#kmmap)
- [kunmap](#kunmap)


**>> Syntax:**
```c
void	*kmmap(size_t size);
```

**>> Syntax:**
```c
void	kunmap(uint32_t vaddr);
```

**>> Syntax:**
```c
void mapPage(uint32_t virtAddr, uint32_t physAddr, uint32_t flags);
```

**>> Syntax:**
```c
void unmapPage(uint32_t virtAddr);
```
