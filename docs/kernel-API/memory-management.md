# **Memory**

---
## **Physical**
---

- [allocFrame](#allocFrame)
- [freeFrame](#freeFrame)
- [getFrameAddr](#getFrameAddr)

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


**>> Syntax:**
```c
void	freeFrame(uint32_t ptr);
```

**>> Description:**

Frees a previously allocated physical frame `ptr` by unsetting its corresponding bit in the physical memory bitmap, marking the frame as available again.


**>> Syntax:**
```c
uint32_t	getFrameAddr(uint32_t vAddr);
```

**>> Description:**

Translates a virtual address `vAddr` to its corresponding physical address using the page tables.

---

## Virtual
---

- [allocPages](#allocFrame)
- [freePages](#freePages)

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
