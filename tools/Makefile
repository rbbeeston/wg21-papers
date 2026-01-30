# Makefile for converting Markdown to PDF/HTML/LaTeX using Pandoc
# Supports Windows, macOS, and Linux
# Requires: pandoc, mermaid-filter (npm package)
# For PDF output: also requires a LaTeX distribution (texlive, miktex, etc.)

# Detect OS
ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
    SHELL := cmd.exe
    .SHELLFLAGS := /c
    NPM := npm
    WHICH := where
    NULL := nul
    MKDIR := mkdir
    RM := del /q
    CP := copy
else
    DETECTED_OS := $(shell uname -s)
    NPM := npm
    WHICH := which
    NULL := /dev/null
    MKDIR := mkdir -p
    RM := rm -f
    CP := cp
endif

# Output and source directories (can be overridden by subdirectory Makefiles)
OUTDIR ?= .
SRCDIR ?= .
TOOLDIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Pandoc options (common)
PANDOC := pandoc
PANDOC_COMMON := --standalone --filter mermaid-filter

# PDF-specific options
PDF_OPTS := $(PANDOC_COMMON) --pdf-engine=xelatex --lua-filter=$(TOOLDIR)/linebreak.lua
PDF_OPTS += -V geometry:a4paper
PDF_OPTS += -V geometry:margin=1.5cm
PDF_OPTS += -V mainfont="Arial"
PDF_OPTS += -V sansfont="Arial"
PDF_OPTS += -V monofont="Menlo"
PDF_OPTS += -V linestretch=1.25
PDF_OPTS += -V fontsize=11pt

# HTML-specific options
HTML_OPTS := $(PANDOC_COMMON) --embed-resources --metadata title="" --css=$(TOOLDIR)/style.css

# LaTeX-specific options
LATEX_OPTS := $(PANDOC_OPTS)

# Default target
.PHONY: help
help:
	@echo "Usage: make <filename>.<format>"
	@echo ""
	@echo "Formats:"
	@echo "  make file.pdf    - Convert file.md to PDF (A4)"
	@echo "  make file.html   - Convert file.md to HTML"
	@echo "  make file.htm    - Convert file.md to HTML"
	@echo "  make file.latex  - Convert file.md to LaTeX"
	@echo ""
	@echo "Other targets:"
	@echo "  make check       - Check if required tools are installed"
	@echo "  make install     - Install missing dependencies (with confirmation)"
	@echo "  make clean       - Remove generated files"
	@echo ""
	@echo "Requirements:"
	@echo "  - pandoc"
	@echo "  - mermaid-filter (npm install -g mermaid-filter)"
	@echo "  - For PDF: LaTeX distribution (texlive/miktex) with xelatex"

# Copy mermaid config to current directory (mermaid-filter requires it here)
# Remove empty mermaid-filter.err after successful conversion
ifeq ($(DETECTED_OS),Windows)
define setup_mermaid_pdf
	@$(CP) $(TOOLDIR)\mermaid-config-pdf.json .mermaid-config.json >$(NULL) 2>&1
endef
define setup_mermaid_html
	@$(CP) $(TOOLDIR)\mermaid-config-html.json .mermaid-config.json >$(NULL) 2>&1
endef
define cleanup_mermaid_err
	@if exist mermaid-filter.err for %%F in (mermaid-filter.err) do @if %%~zF==0 del mermaid-filter.err >$(NULL) 2>&1
endef
else
define setup_mermaid_pdf
	@$(CP) $(TOOLDIR)/mermaid-config-pdf.json .mermaid-config.json 2>/dev/null || true
endef
define setup_mermaid_html
	@$(CP) $(TOOLDIR)/mermaid-config-html.json .mermaid-config.json 2>/dev/null || true
endef
define cleanup_mermaid_err
	@[ ! -s mermaid-filter.err ] && rm -f mermaid-filter.err 2>/dev/null || true
endef
endif

# Pattern rules for conversion
%.pdf: $(SRCDIR)/%.md check-deps-pdf
	$(setup_mermaid_pdf)
	MERMAID_FILTER_FORMAT=png $(PANDOC) $(PDF_OPTS) -o $(OUTDIR)/$@ $<
	$(cleanup_mermaid_err)
	@$(RM) .mermaid-config.json 2>$(NULL) || true
	@echo "Created $(OUTDIR)/$@"

%.html: $(SRCDIR)/%.md check-deps
	$(setup_mermaid_html)
	MERMAID_FILTER_FORMAT=svg $(PANDOC) $(HTML_OPTS) -o $(OUTDIR)/$@ $<
	$(cleanup_mermaid_err)
	@$(RM) .mermaid-config.json 2>$(NULL) || true
	@echo "Created $(OUTDIR)/$@"

%.htm: $(SRCDIR)/%.md check-deps
	$(setup_mermaid_html)
	MERMAID_FILTER_FORMAT=svg $(PANDOC) $(HTML_OPTS) -o $(OUTDIR)/$@ $<
	$(cleanup_mermaid_err)
	@$(RM) .mermaid-config.json 2>$(NULL) || true
	@echo "Created $(OUTDIR)/$@"

%.latex: $(SRCDIR)/%.md check-deps
	$(setup_mermaid_pdf)
	$(PANDOC) $(LATEX_OPTS) -o $(OUTDIR)/$@ $<
	$(cleanup_mermaid_err)
	@$(RM) .mermaid-config.json 2>$(NULL) || true
	@echo "Created $(OUTDIR)/$@"

# Check dependencies
.PHONY: check check-deps check-deps-pdf
check:
	@echo "Checking dependencies..."
	@$(MAKE) --no-print-directory check-pandoc
	@$(MAKE) --no-print-directory check-mermaid
	@$(MAKE) --no-print-directory check-latex
	@echo ""
	@echo "All checks complete."

check-deps:
	@$(MAKE) --no-print-directory check-pandoc
	@$(MAKE) --no-print-directory check-mermaid

check-deps-pdf: check-deps
	@$(MAKE) --no-print-directory check-latex

.PHONY: check-pandoc
check-pandoc:
ifeq ($(DETECTED_OS),Windows)
	@where pandoc >$(NULL) 2>&1 || (echo ERROR: pandoc is not installed. && echo Install from: https://pandoc.org/installing.html && echo Or run: make install && exit 1)
else
	@which pandoc > $(NULL) 2>&1 || (echo "ERROR: pandoc is not installed." && echo "Install from: https://pandoc.org/installing.html" && echo "Or run: make install" && exit 1)
endif
	@echo "[OK] pandoc found"

.PHONY: check-mermaid
check-mermaid:
ifeq ($(DETECTED_OS),Windows)
	@where mermaid-filter >$(NULL) 2>&1 || (echo ERROR: mermaid-filter is not installed. && echo Install with: npm install -g mermaid-filter && echo Or run: make install && exit 1)
else
	@which mermaid-filter > $(NULL) 2>&1 || (echo "ERROR: mermaid-filter is not installed." && echo "Install with: npm install -g mermaid-filter" && echo "Or run: make install" && exit 1)
endif
	@echo "[OK] mermaid-filter found"

.PHONY: check-latex
check-latex:
ifeq ($(DETECTED_OS),Windows)
	@where xelatex >$(NULL) 2>&1 || (echo WARNING: xelatex is not installed. PDF generation will not work. && echo Install a LaTeX distribution like MiKTeX or TeX Live.)
else
	@which xelatex > $(NULL) 2>&1 || (echo "WARNING: xelatex is not installed. PDF generation will not work." && echo "Install a LaTeX distribution like TeX Live or MacTeX.")
endif
	@echo "[OK] xelatex found (PDF generation available)"

# Install dependencies (only missing ones)
.PHONY: install
install:
	@echo "Checking for missing dependencies..."
	@echo ""
ifeq ($(DETECTED_OS),Windows)
	@where pandoc >$(NULL) 2>&1 && echo "[OK] pandoc already installed" || ( \
		echo "[MISSING] pandoc" && \
		echo "  Install from: https://pandoc.org/installing.html" \
	)
	@where mermaid-filter >$(NULL) 2>&1 && echo "[OK] mermaid-filter already installed" || ( \
		echo "[MISSING] mermaid-filter" && \
		echo "  Install Node.js from: https://nodejs.org/" && \
		echo "  Then run: npm install -g mermaid-filter" \
	)
	@where xelatex >$(NULL) 2>&1 && echo "[OK] xelatex already installed" || ( \
		echo "[MISSING] xelatex (needed for PDF)" && \
		echo "  Install MiKTeX from: https://miktex.org/" \
	)
else ifeq ($(DETECTED_OS),Darwin)
	@echo "Detected: macOS"
	@echo ""
	@if which pandoc > $(NULL) 2>&1; then \
		echo "[OK] pandoc already installed"; \
	else \
		echo "[MISSING] pandoc"; \
		read -p "Install pandoc via Homebrew? [y/N] " confirm; \
		if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
			which brew > $(NULL) 2>&1 || (echo "Homebrew not found. Install from https://brew.sh" && exit 1); \
			brew install pandoc; \
		fi; \
	fi
	@echo ""
	@if which mermaid-filter > $(NULL) 2>&1; then \
		echo "[OK] mermaid-filter already installed"; \
	else \
		echo "[MISSING] mermaid-filter"; \
		read -p "Install mermaid-filter via npm (requires sudo)? [y/N] " confirm; \
		if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
			which npm > $(NULL) 2>&1 || (echo "npm not found. Install Node.js from https://nodejs.org" && exit 1); \
			sudo npm install -g mermaid-filter; \
		fi; \
	fi
	@echo ""
	@if which xelatex > $(NULL) 2>&1; then \
		echo "[OK] xelatex already installed (PDF generation available)"; \
	else \
		echo "[MISSING] xelatex (needed for PDF generation)"; \
		echo "  Install MacTeX: https://www.tug.org/mactex/"; \
		echo "  Or via Homebrew: brew install --cask mactex"; \
	fi
else
	@echo "Detected: Linux"
	@echo ""
	@if which pandoc > $(NULL) 2>&1; then \
		echo "[OK] pandoc already installed"; \
	else \
		echo "[MISSING] pandoc"; \
		read -p "Install pandoc via package manager? [y/N] " confirm; \
		if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
			if which apt-get > $(NULL) 2>&1; then \
				sudo apt-get update && sudo apt-get install -y pandoc; \
			elif which dnf > $(NULL) 2>&1; then \
				sudo dnf install -y pandoc; \
			elif which pacman > $(NULL) 2>&1; then \
				sudo pacman -S pandoc; \
			else \
				echo "Unknown package manager. Install pandoc manually from https://pandoc.org/installing.html"; \
			fi; \
		fi; \
	fi
	@echo ""
	@if which mermaid-filter > $(NULL) 2>&1; then \
		echo "[OK] mermaid-filter already installed"; \
	else \
		echo "[MISSING] mermaid-filter"; \
		read -p "Install mermaid-filter via npm (may require sudo)? [y/N] " confirm; \
		if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
			which npm > $(NULL) 2>&1 || (echo "npm not found. Install Node.js first." && exit 1); \
			npm install -g mermaid-filter || sudo npm install -g mermaid-filter; \
		fi; \
	fi
	@echo ""
	@if which xelatex > $(NULL) 2>&1; then \
		echo "[OK] xelatex already installed (PDF generation available)"; \
	else \
		echo "[MISSING] xelatex (needed for PDF generation)"; \
		echo "  Debian/Ubuntu: sudo apt-get install texlive-xetex"; \
		echo "  Fedora: sudo dnf install texlive-xetex"; \
		echo "  Arch: sudo pacman -S texlive-xetex"; \
	fi
endif
	@echo ""
	@echo "Dependency check complete."

# Clean generated files
.PHONY: clean
clean:
	$(RM) *.pdf *.html *.htm *.latex mermaid-filter.err .mermaid-config.json 2>$(NULL) || true
	@echo "Cleaned generated files."

# List available markdown files
.PHONY: list
list:
	@echo "Available markdown files:"
ifeq ($(DETECTED_OS),Windows)
	@dir /b *.md 2>$(NULL) || echo "  No .md files found"
else
	@ls -1 *.md 2>$(NULL) || echo "  No .md files found"
endif
