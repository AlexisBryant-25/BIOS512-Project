# BIOS 512 Final Project Makefile
# Author: Alexis Bryant

# Variables
PROJECT_NAME = BIOS512-Project
REPORT = report/BIOS512-Project.Rmd
OUTPUT = report/BIOS512-Project.pdf
CONTAINER_NAME = BIOS512-Project
IMAGE_NAME = bios512-wine
R_FILES = $(shell find . -name "*.R" -o -name "*.Rmd")

# Default target
all: $(OUTPUT)

# Rule: Knit RMarkdown file
$(OUTPUT): $(REPORT) $(R_FILES)
	Rscript -e "rmarkdown::render('$(REPORT)', output_file = '$(OUTPUT)')"
	@echo "Report successfully generated: $(OUTPUT)"

# Rule: Build the container
build:
	podman build -t $(IMAGE_NAME) .

# Rule: Run RStudio container
run:
	podman run -d -p 8787:8787 -e PASSWORD=rstudio \
		-v $(PWD):/home/rstudio/project:Z $(IMAGE_NAME)
	@echo "RStudio running at http://localhost:8787 (username: rstudio, password: rstudio)"

# Rule: Install required R packages inside the container (optional)
install:
	Rscript -e "install.packages(c('tidyverse','cluster','factoextra','caret','glmnet','GGally','nnet','rmarkdown'))"

# Rule: Clean generated files
clean:
	rm -f $(OUTPUT)
	@echo " Cleaned up generated files."

# Help message
help:
	@echo "Available commands:"
	@echo "  make all        - Knit the RMarkdown report"
	@echo "  make build      - Build the Podman container"
	@echo "  make run        - Run RStudio in the container"
	@echo "  make install    - Install R package dependencies"
	@echo "  make clean      - Remove generated files"
