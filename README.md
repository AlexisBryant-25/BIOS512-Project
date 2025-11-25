# BIOS 512 Final Project: Uncorking Quality – A Data-Driven Exploration of Wine Chemistry

## Overview
This project analyzes a Kaggle dataset containing 178 laboratory measurements of wines from the same Italian region.
Each record includes 13 chemical attributes and a cultivar label (three classes).
The analysis combines exploratory data analysis, **PCA**, **k-means clustering**, and **multinomial classification** (with and without LASSO regularization) to understand which chemical features distinguish cultivars and how accurately they can be predicted.

## Repository Structure
- `Report/` – Main analysis report (`BIOS512-Project.Rmd`) and the raw dataset (`wine_dataset.csv`).
- `Data/` – (optional) placeholder for additional datasets.
- `SRC/` – Source scripts or helpers.
- `Makefile` – Automates environment setup and report rendering.
- `Containerfile` – Podman container for reproducibility.
- `README.md` – Project overview and usage instructions.

## Getting Started

### Build the Container
```bash
podman build -t bios512-wine .
podman run -d -p 8787:8787 -e PASSWORD=rstudio -v $(pwd):/home/rstudio/project:Z bios512-wine
```

### Install Dependencies Locally (without container)
```bash
Rscript -e "install.packages(c('tidyverse','cluster','factoextra','caret','glmnet','GGally','nnet','rmarkdown'))"
```

### Generate the Report
Run the following from the project root:
```bash
make
```

Or render manually inside R or RStudio:
```r
rmarkdown::render("Report/BIOS512-Project.Rmd", output_format = "html_document")
```

## Methods Highlight
- **Exploratory Data Analysis:** Faceted histograms and a correlation heatmap describe the 13 chemical attributes.
- **Dimensionality Reduction:** Principal component analysis with variance-explained plot and biplot colored by cultivar.
- **Clustering:** K-means (k=3) with visualization and silhouette-based separation check.
- **Classification:** Multinomial logistic regression and LASSO-regularized multinomial regression with held-out accuracy.

## Dataset Source
**Wine Dataset – Kaggle.**
Laboratory analyses of wines from three cultivars in the same Italian region, featuring chemical measurements such as alcohol, phenolic compounds, acidity metrics, and color intensity.
