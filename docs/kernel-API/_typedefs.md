# **Type Definitions**

## Structs

- [_vgaCell](#_vgacell)
- [_node](#_node)
- [_list](#_list)
- [_tty](#_tty)
- [_terminal](#_terminal)

---
### **_vgaCell**

```c
typedef struct vgaCell
{
	char character;
	char color;
} _vgaCell;
```

**>> Description:**

The **_vgaCell** is used to represent a character along with its associated color for rendering on the VGA screen. It stores the character and its color information, which can then be used to display the character with the correct color.

**>> Fields:**

- **char `character`:**  
	Where the actual character data is stored.

- **uint8_t `color`:**  
	The color associated with the character, represented as an **[integer](/kernel-API/vga-display/#setvgacolor)**. This integer is divided into two parts:  
	- **The first 4 bits (higher nibble)** represent the background color.
	- **The second 4 bits (lower nibble)** represent the foreground color (text).
---
### **_node**

```c
typedef struct node
{
	_vgaCell	*buffer;
	struct node *previous;
	struct node *next;
} _node;
```

**>> Description:**
The node struct represents a single element in a doubly linked list. Each node contains a buffer (**[_vgaCell](#_vgacell)***) that holds data, as well as pointers to the previous and next nodes in the list.

**>> Fields:**

- **_vgaCell* buffer:**  
A pointer to a **[_vgaCell](#_vgacell)** array (buffer) that stores the data for this node.

- **struct node* prev:**  
A pointer to the previous node in the doubly linked list.

- **struct node* next:**  
A pointer to the next node in the doubly linked list.

---
### **_list**

```c
typedef struct list
{
	_node *first;
	_node *last;
	uint32_t size;
} _list;
```

**>> Description:**  
The list struct represents a doubly linked list of node elements. This list stores multiple nodes, each containing a buffer (**[_vgaCell](#_vgacell)***).

**>> Fields:**  

- **_node* first:**  
A pointer to the first node in the doubly linked list. This allows access to the start of the list.

- **_node* last:**  
A pointer to the last node in the doubly linked list. This allows access to the end of the list.

- **uint8_t size:**  
The size of the list. This value keeps track of how many nodes have been added to the list.

---

### **_tty**

```c
typedef struct tty
{
	_list	*buffer;
	_list	*history;

	uint8_t index;

	uint32_t posX;
	uint32_t posY;

	uint8_t textColor;
	uint8_t backgroundColor;

	_vgaCell status[MAX_COLUMNS];
} _tty;
```

**>> Description:**  
The **_tty** stores the TTY's data;

  
**>> Fields:**

- **_list *buffer:**  
A pointer to a **circular doubly linked list ([_list]())** that stores the VGA data. This is where characters and their color information are saved before being rendered on the screen.

- **_list2 *history:**  
A pointer to a **circular doubly linked list ([_list]())** that stores the history of previous commands.

- **uint8_t index:**  
TTY index.

- **uint8_t posX:**  
The X-coordinate of the cursor position on the screen. This indicates the horizontal position where the next character will be printed.

- **uint8_t posY:**  
The Y-coordinate of the cursor position on the screen. This indicates the vertical position where the next character will be printed.

- **uint8_t textColor:**  
The current text color (foreground color) for characters that will be printed on the screen, specific to `tty[index]`.

- **uint8_t backgroundColor:**  
The current background color for characters that will be printed on the screen, specific to `tty[index]`.
> Note:  
> We use global variables to store and get current colors; **textColor** and **backgroundColor** on this struct are only used when we need to switch TTYs.

- **_vgaCell status[MAX_COLUMNS]:**  
An array of [_vgaCell](#_vgacell) (up to MAX_COLUMNS entries), each containing a character and its associated color. This array is used to store the current status of tty[index].
> _vgaCell status[MAX_COLUMNS] is always printed on the last row on the screen

---

### **_terminal**

```c
typedef struct terminal
{
	_tty ttys[MAX_TTYS];
	_tty *currentTTY;
} _terminal;
```

**>> Description:**  
The **_terminal** stores the terminal's data;

  
**>> Fields:**

- **_tty ttys[MAX_TTYS]:**  
An array of all available tty instances. MAX_TTYS represents the total number of terminals available.

- **_tty *currentTTY:**  
A pointer to the currently displayed tty.

---

