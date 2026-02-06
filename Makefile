.PHONY: all deps pdf

all: deps pdf

deps:
	@echo "Checking dependencies..."
	@command -v pandoc >/dev/null 2>&1 || { \
		echo "Pandoc not found. Installing..."; \
		if command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y pandoc; \
		elif command -v dnf >/dev/null; then sudo dnf install -y pandoc; \
		elif command -v pacman >/dev/null; then sudo pacman -S --noconfirm pandoc; \
		elif command -v brew >/dev/null; then brew install pandoc; \
		else echo "Error: No supported package manager found. Please install pandoc manually."; exit 1; \
		fi; \
	}
	@command -v wkhtmltopdf >/dev/null 2>&1 || { \
		echo "wkhtmltopdf not found. Installing..."; \
		if command -v apt-get >/dev/null; then sudo apt-get install -y wkhtmltopdf; \
		elif command -v dnf >/dev/null; then sudo dnf install -y wkhtmltopdf; \
		elif command -v pacman >/dev/null; then sudo pacman -S --noconfirm wkhtmltopdf; \
		elif command -v brew >/dev/null; then brew install wkhtmltopdf; \
		else echo "Error: No supported package manager found. Please install wkhtmltopdf manually."; exit 1; \
		fi; \
	}

pdf:
	pandoc README.md -o cv.pdf \
		--css=style.css \
		--pdf-engine=wkhtmltopdf \
		--pdf-engine-opt=--enable-local-file-access \
		--metadata title="" \
		--variable geometry:margin=1in
	@echo "Success! cv.pdf generated."