# BIOS 512 Final Project Makefile
# Author: Alexis Bryant

PROJECT_NAME = BIOS512-Project
REPORT_DIR = Report
REPORT = $(REPORT_DIR)/BIOS512-Project.Rmd
OUTPUT = $(REPORT_DIR)/BIOS512-Project.html
IMAGE_NAME = bios512-wine
R_FILES = $(shell find . -name "*.R" -o -name "*.Rmd")

.PHONY: all build run install clean help

all: $(OUTPUT)

$(OUTPUT): $(REPORT) $(R_FILES)
Rscript SRC/render_report.R
@echo "Report successfully generated: $(OUTPUT)"

build:
	podman build -t $(IMAGE_NAME) .

run:
	podman run -d -p 8787:8787 -e PASSWORD=rstudio \
	        -v $(PWD):/home/rstudio/project:Z $(IMAGE_NAME)
	@echo "RStudio running at http://localhost:8787 (username: rstudio, password: rstudio)"

install:
	Rscript -e "install.packages(c('tidyverse','cluster','factoextra','GGally','mclustcomp','rmarkdown'))"

clean:
	rm -f $(OUTPUT)
	@echo "Cleaned up generated files."

help:
	@echo "Available commands:"
	@echo "  make all        - Knit the RMarkdown report"
	@echo "  make build      - Build the Podman container"
	@echo "  make run        - Run RStudio in the container"
	@echo "  make install    - Install R package dependencies"
	@echo "  make clean      - Remove generated files"
