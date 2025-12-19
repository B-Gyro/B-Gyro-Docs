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

### **allocPages**

**>> Syntax:**
```c
uint32_t	allocPages(uint32_t numberOfPages, uint32_t heapStart, uint32_t end);
```

**>> Description:**

Allocates **numberOfPages** contiguous virtual memory pages.

It finds **numberOfPages** consecutive free pages, sets the corresponding bits to **allocated** in the **`pagesBitmap`**, and returns the virtual address of the first page.

The total allocated virtual address range is: **`numberOfPages × PAGE_SIZE bytes`**

**>> Parameters:**

- **numberOfPages**: number of pages to allocate
- **heapStart**: the first address of the heap
	- **KERNEL_HEAP_START**: 0xC1000000
	- **USER_HEAP_START**: 0x00001000

```text
		            Virtual Address Space (32-bit, 3 G / 1 G split)
		┌───────────────────────────────────────────────────────────────┐
		│ USER SPACE  (per-process)							  		    │
		│                                                               │
		│ 0x00000000 ───────────────────────────────────────────────────┤
		│ |  NULL                                                       │
		│                                                               │
		│ 0x00001000 ───────────────────────────────────────────────────┤
		│ |  User code / data / heap / stack / mmap / libraries         │
		│ |  (managed by each process’s page directory)                 │
		│ |  Typically up to 3 GB total                                 │
		│                                                               │
		│ 0xBFFFFFFF ───────────────────────────────────────────────────┤
		│ Transition to kernel-only virtual addresses                   │
		├───────────────────────────────────────────────────────────────┤
		│ KERNEL SPACE  (global, same in all processes)                 │
		│                                                               │
		│ 0xC0000000 ───────────────────────────────────────────────────┤
		│ |  Direct-mapped physical memory (“lowmem”)                   │
		│ |  Virtual = physical + 0xC0000000                            │
		│ |  Contains:                                                  │
		│ |   • kernel text/data/BSS                                    │
		│ |   • page tables                                             │
		│ |   • per-task kernel stacks (each 4–8 KB)                    │
		│ |   • slab caches, low-mem pages                              │
		│ |  [This region extends for size of physical lowmem]          │
		│                                                               │
		│                                                               │
		│ 0xC1000000 ───────────────────────────────────────────────────┤
		│ |  Gap / alignment buffer (≈16 MB by convention)              │
		│ |  Prevents accidental overlap                                │
		│                                                               │
		│ 0xC1000000 ───────────────────────────────────────────────────┤
		│ |  Kernel “heap” / vmalloc area                               │
		│ |  Used by:                                                   │
		│ |   • vmalloc(), vmap()                                       │
		│ |   • ioremap() mappings below Fixmap                         │
		│ |  Virtually contiguous, physically discontiguous pages       │
		│ |  (≈0xC0800000–0xF7FFFFFF)                                   │
		│                                                               │
		│ 0xF8000000 ───────────────────────────────────────────────────┤
		│ |  High-mem temporary mappings (kmap, pkmap)                  │
		│ |  IO-remap region                                            │
		│ |  Architecture-specific mappings                             │
		│                                                               │
		│ 0xFFF00000 ───────────────────────────────────────────────────┤
		│ |  Fixmap region                                              │
		│ |   • APIC, BIOS, CPU local data                              │
		│ |   • Kernel vsyscall page                                    │
		│ |  Computed downward from 0xFFFFF000                          │
		│                                                               │
		│ 0xFFFFFFFF ───────────────────────────────────────────────────┘
```
- **end**: always give it 0. #used to restart search from 0 in case the end of numberOfPages is reached

### **freePages**

**>> Syntax:**
```c
size_t	freePages(uint32_t ptr, uint32_t heapStart);
```

**>> Description:**

Frees a previously allocated contiguous virtual memory region.

Using the ptr, it locates the allocation, frees all associated virtual pages by clearing the corresponding bits in the pagesBitmap, and returns the number of pages that were freed.

**>> Parameters:**

- **ptr**: address to free
- **heapStart**: the first address of the heap
	- **KERNEL_HEAP_START**: 0xC1000000
	- **USER_HEAP_START**: 0x00001000

**>> Return:**

The number of pages that were freed.

---

## Memory mapping

<!-- - [mapPage](#mapPage)
- [unmapPage](#unmapPage)
- [kmmap](#kmmap)
- [kunmap](#kunmap) -->

---

### **kmmap**

**>> Syntax:**

```c
void	*kmmap(size_t size);
```

**>> Description:**

Maps a memory region of the given size in bytes.

It calculates the required number of pages, allocates that many contiguous virtual pages, then allocates the same number of physical frames (which may be contiguous or non-contiguous, depending on availability). Then call [mapPage](#mapPage).

**>> Return:**

The virtual address of the first page.

### **mapPage**

**>> Syntax:**
```c
void	mapPage(uint32_t virtAddr, uint32_t physAddr, uint32_t flags);
```

**>> Description:**

Maps a virtual page to a frame in the page directory 


### **kunmap**

**>> Syntax:**

```c
void	kunmap(uint32_t vaddr);
```

**>> Description:**

Unmaps a previously mapped virtual memory region.

Starting from vaddr, it frees the virtual pages and its corresponding physical frames. Than calls [unmapPage](#unmapPage)


### **unmapPage**

**>> Syntax:**
```c
void	unmapPage(uint32_t virtAddr);
```

**>> Description:**

Removes the corresponding entry of virtAddr from the page table (page directory)
