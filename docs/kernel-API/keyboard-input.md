# Keyboard Input

## Functions
### initialization functions
- [keyboardInit](#keyboardInit)
- [keyboardSetLayout](#keyboardSetLayout)
- [keyboardSetBuffer](#keyboardSetBuffer)
- [keyboardClearBuffer](#keyboardClearBuffer)
### promting
- [prompt](#prompt)
- [interruptPrompting](#interruptPrompting)
### key press/release handlers
- [keyboardSetKeyPressHandler](#keyboardSetKeyPressHandler)
- [keyboardSetKeyReleaseHandler](#keyboardSetKeyReleaseHandler)
- [keyboardResetKeyPressHandler](#keyboardResetKeyPressHandler)
- [keyboardResetKeyReleaseHandler](#keyboardResetKeyReleaseHandler)
### convert scancode <=> letter
- [keyboardGetScancode](#keyboardGetScancode)
- [keyboardGetLetter](#keyboardGetLetter)
### shortcuts handling functions
- [shortcutsReset](#shortcutsReset)
- [setShortcut](#setShortcut)

## type defs

- [_kbdBuffer](#_kbdBuffer)
- [onKeyPressHanlder](#onKeyPressHanlder)
- [onKeyReleaseHanlder](#onKeyReleaseHanlder)
- [_shortcut](#_shortcut)
- [onShortcutHandler](#onShortcutHandler)
- [_kbdLayout](#_kbdLayout)

## Initialization functions
---
### **keyboardInit**

**>> Syntax:**
```c
void	keyboardInit(void);
```

**>> Description:**

initializes the keyboard driver by setting the keyboard buffer the current tty keyboard buffer, and default to the US keyboard layout.

---

### **keyboardSetLayout**

**>> Syntax:**
```c
void keyboardSetLayout(_kbdLayout layout);
```

**>> Description:**

Sets the keyboard layout to the provided layout ([_kbdLayout](#_kbdLayout)).

---

### **keyboardSetBuffer**

**>> Syntax:**
```c
void keyboardSetBuffer(_kbdBuffer buffer);
```

**>> Description:**

Sets the keyboard buffer to the provided buffer ([_kbdBuffer](#_kbdBuffer)).

---

### **keyboardClearBuffer**

**>> Syntax:**
```c
void keyboardClearBuffer(void);
```

**>> Description:**

Clears the keyboard buffer.

---

## Promting

---

### **prompt**

**>> Syntax:**
```c
char	*prompt(char *promtMessage, char *buffer);
```

**>> Description:**

Prompts the user with the provided message and waits for the user to enter a string of characters, which will be stored in the provided buffer.

**>> Parameters:**

- **promtMessage:** The message to be displayed to the user.
- **buffer:** The buffer to store the user input.

**>> Returns:**

The buffer containing the user input.

**>> Note:**

- can be interrupted with ([interruptPrompting](#interruptPrompting)).
- buffer overflow ?!

---

### **interruptPrompting**

**>> Syntax:**
```c
void interruptPrompting(void);
```

**>> Description:**

Interrupts the current prompting operation.

---

## Key press/release handlers

---

### **keyboardSetKeyPressHandler**

**>> Syntax:**
```c
void keyboardSetKeyPressHandler(onKeyPressHanlder handler);
```

**>> Description:**

Sets the key press handler to the provided handler ([onKeyPressHanlder](#onKeyPressHanlder)).

---

### **keyboardSetKeyReleaseHandler**

**>> Syntax:**
```c
void keyboardSetKeyReleaseHandler(onKeyReleaseHanlder handler);
```

**>> Description:**

Sets the key release handler to the provided handler ([onKeyReleaseHanlder](#onKeyReleaseHanlder)).

---

### **keyboardResetKeyPressHandler**

**>> Syntax:**
```c
void keyboardResetKeyPressHandler(void);
```

**>> Description:**

Resets the key press handler to the default handler (tty compatible).

---

### **keyboardResetKeyReleaseHandler**

**>> Syntax:**
```c
void keyboardResetKeyReleaseHandler(void);
```

**>> Description:**

Resets the key release handler to the default handler (tty compatible).

---

## Convert scancode <=> letter

---

### **keyboardGetScancode**

**>> Syntax:**
```c
uint8_t	keyboardGetScancode(uint8_t letter);
```

**>> Description:**

Returns the scancode of the provided letter.

---

### **keyboardGetLetter**

**>> Syntax:**
```c
uint8_t	keyboardGetLetter(uint8_t scancode);
```

**>> Description:**

Returns the letter of the provided scancode.

---

## Shortcuts handling functions

---

### **shortcutsReset**

**>> Syntax:**
```c
void shortcutsReset(void);
```

**>> Description:**

Resets all the shortcuts.

---

### **setShortcut**

**>> Syntax:**
```c
void setShortcut(_shortcut shortcut, onShortcutHandler handler);
```

**>> Description:**

Sets the provided shortcut ([_shortcut](#_shortcut)) to the provided handler ([onShortcutHandler](#onShortcutHandler)).

---

## type defs

---

### **_kbdBuffer**

```c
typedef struct kbdBuffer {
    uint8_t     buffer[MAX_KEYBOARD_BUFFER];
    uint32_t    index;
	uint32_t    size;
} _kbdBuffer;
```

**>> Description:**

The **_kbdBuffer** struct represents a keyboard buffer.

**>> Fields:**

- **uint8_t buffer[MAX_KEYBOARD_BUFFER]:** the buffer to store the keyboard input.
- **uint32_t index:** the current index in the buffer.
- **uint32_t size:** the size of the buffer.

---

### **onKeyPressHanlder**

```c
typedef void (*onKeyPressHanlder)(uint8_t);
```

**>> Description:**

The **onKeyPressHanlder** is a function pointer type that represents a key press handler.

**>> Parameters:**

- **uint8_t:** pressed letter. (!= scancode)

---

### **onKeyReleaseHanlder**

```c
typedef void (*onKeyReleaseHanlder)(uint8_t);
```

**>> Description:**

The **onKeyReleaseHanlder** is a function pointer type that represents a key release handler.

**>> Parameters:**

- **uint8_t:** the scancode of the released key.

---

### **_shortcut**

```c
typedef struct shortcut {
	char				key;
	uint8_t				flagedModifiers;
	onShortcutHandler	handler;
} _shortcut;
```

**>> Description:**

The **_shortcut** struct represents a keyboard shortcut.

**>> Fields:**

- **char key:** the key of the shortcut.
- **uint8_t flagedModifiers:** the modifiers of the shortcut. (ctrl | alt | shift)
- **onShortcutHandler handler:** the handler of the shortcut.

---

### **onShortcutHandler**

```c

typedef void (*onShortcutHandler)(void);
```

**>> Description:**

The **onShortcutHandler** is a function pointer type that represents a shortcut handler.

---

### **_kbdLayout**

```c
typedef union kbdLayout {
	struct keyboardViews kbdV;
	uint8_t *views[2];
} _kbdLayout;
```

**>> Description:**

- The **_kbdLayout** union represents a keyboard layout.
- the keyboard layout can be accessed as a struct ([keyboardViews](#keyboardViews)) or as an array of uint8_t pointers.
- keyboard layouts are declared in the keyboardDriver.c file.

---
