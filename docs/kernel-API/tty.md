# TTY

## Functions

- [putChar](#putchar)


---
### **putChar**

**>> Syntax:**
```c
uint8_t putChar(char c);
```

**>> Description:**

Displays the character `c` on the VGA screen at the current cursor position and adds it to the tty buffer.

**>>> Functionality:**

- Displays the character `c` on the VGA screen at the current cursor position.   
- Adds the character and its associated color to the tty buffer.  
- Updates cursor position (X, Y) after printing the character.  
- Scrolls the screen when the cursor reaches (MAX_COLUMNS, MAX_ROWS).  
- Handles special characters:

<!-- <div style="text-align: center;"> -->
|	character	|	Represenation	|	Terminal action	|
| :---: | :---: | --- |
|	**\n**			|	**newline**			|	Moves the printing position to the beginning of the next line.	|
|	**\r**		|	**carriage return**		|	Moves the cursor to the beginning of the current line.	|
|	**\t**		|	**tab**					|	Advances the cursor by a tab space.	|
|	**\b**		|	**backspace**			|	Moves the printing position to the previous character position, unless the current position is the start of a line.	|
|	**\033xx;..;xxm**	|	**colors**		|	Applies text color and formatting, using ansi sequences.	|
  
<!-- </div> -->

**>> Return Value:**

- Returns 1 if the character was successfully printed.  
- Returns 0 if the character couldn't be printed.