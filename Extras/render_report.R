#!/usr/bin/env Rscript

# Render the BIOS512 project report with reproducible defaults.

required_packages <- c(
  "tidyverse",
  "cluster",
  "factoextra",
  "GGally",
  "mclustcomp",
  "rmarkdown"
)

missing <- required_packages[!(required_packages %in% rownames(installed.packages()))]
if (length(missing) > 0) {
  stop(
    "Missing required packages: ",
    paste(missing, collapse = ", "),
    "\nInstall them via Makefile target 'install' or inside the container."
  )
}

set.seed(512)

rmarkdown::render(
  input = "Report/BIOS512-Project.Rmd",
  output_format = "html_document",
  output_file = "Report/BIOS512-Project.html",
  envir = new.env()
)
