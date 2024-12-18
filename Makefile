MAKEFLAGS += --silent --ignore-errors

PORT			= 8000
MAX_PORT		= 8011
DEFAULT_PATH	= .

PIP		= $(shell if command -v pip3 > /dev/null 2>&1; then echo pip3; elif command -v pip > /dev/null 2>&1; then echo pip; else echo ; fi)
PYTHON	= $(shell if command -v python3 > /dev/null 2>&1; then echo python3; elif command -v python > /dev/null 2>&1; then echo python; else echo NOT_FOUND ; fi)

REQUIREMENTS = mkdocs mkdocs-material emoji

ifndef PROJECT_PATH
	PROJECT_PATH := $(DEFAULT_PATH)
endif

all:
	@echo -n "\033[1m> Looking for available port.";
	@make check-port;

check-port:
	@echo -n ".";
	@if lsof -i :$(PORT) > /dev/null 2> /dev/null ; then \
		PORT=$$(($(PORT) + 1)); \
		if [ $(PORT) -gt $(MAX_PORT) ]; then \
			echo "\033[91;1m\n> Reached maximum port limit. No available ports.\033[0m"; \
			exit 1; \
		fi && \
		make check-port PORT=$$PORT; \
	else \
		echo "\033[0m"; \
		make start PORT=$$PORT; \
	fi 


start: check-requirements venv
	@. $(PROJECT_PATH)/venv/bin/activate && \
	nohup mkdocs serve -a 0.0.0.0:$(PORT) > $(PROJECT_PATH)/mkdocs.log 2>&1 &
	@echo "\033[1m> Waiting for MkDocs to start...";
	@sleep 2;
	@echo "\033[36;1m >>> MkDocs is being served at \`http://127.0.0.1:$(PORT)\`\033[0m"

venv:
	@if [ ! -d "$(PROJECT_PATH)/venv" ]; then \
		echo "\033[91;1m> venv not found, creating...\033[0m"; \
		$(PYTHON) -m venv venv && \
		echo "\033[92;1m> venv created succesfully\033[0m"; \
	fi

check-requirements:
	@if [ "$(PYTHON)" = "NOT_FOUND" ]; then \
		echo "\033[91;1m> Error: Make sure Python is installed and available in your PATH!\033[0m"; \
		exit 1; \
	fi

	@for package in $(REQUIREMENTS); do \
		if ! $(PIP) show $$package > /dev/null 2>&1; then \
			echo "\033[91;1m> $$package is not installed. Installing...\033[0m"; \
			$(PIP) install $$package > /dev/null 2>&1 && \
			echo "\033[92;1m> $$package installed succesfully.\033[0m"; \
		fi \
	done

clean:
	@echo "\033[1m- Removing log and venv...\033[0m";
	@rm -f mkdocs.log
	@rm -rf venv
	@echo "\033[92;1;1mDONE.\033[0m";
	@echo "\033[1m- Killing mkdocs serve...\033[0m";
	@-pkill -f "mkdocs serve" > /dev/null 2>&1;
	@echo "\033[92;1;1mDONE.\033[0m";

fclean: clean
	@echo "\033[1m- Uninstalling requirements...\033[0m";
	@$(PIP) uninstall -y $(REQUIREMENTS) 1>/dev/null 2> /dev/null
	@echo "\033[92;1;1mDONE.\033[0m";

.PHONY: all venv mkdocs check-port check-requirements