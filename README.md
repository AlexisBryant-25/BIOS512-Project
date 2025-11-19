
# BIOS 512 Final Project: Uncorking Quality – A Data-Driven Exploration of Wine Chemistry

## Overview
This project analyzes a Kaggle dataset containing results of chemical analyses of wines from the same region of Italy.  
Each record represents one wine sample with 13 measured chemical attributes and a cultivar label (three classes).  
The project applies **dimensionality reduction (PCA)**, **clustering (K-means)**, and **classification (logistic and LASSO regression)** to uncover the factors that distinguish wine types.


## Repository Structure

data/ – Contains the dataset (wine_dataset.csv)
src/ – Analysis and preprocessing scripts 
report/ – Main analysis report (BIOS512-Project.Rmd, outputs)
Makefile – Automates environment setup and report rendering
Containerfile – Podman container for reproducibility
README.md – Project overview and documentation


## Getting Started

### Build the Container
```{bash}
podman build -t bios512-wine .
podman run -d -p 8787:8787 -e PASSWORD=rstudio -v $(pwd):/home/rstudio/project:Z bios512-wine
```
### Generate the Report
Inside Rstudio or the container terminal:
```{bash}
make
```
OR manually in RStudio:
```{r}
rmarkdown::render("report/BIOS512-Project.Rmd", output_format = "html_document")
```


## Methods Used

Exploratory Data Analysis (EDA)
Histograms, correlation exploration.

Dimensionality Reduction
PCA with scree plot and biplot.

Clustering
K-means with visualization of 3 clusters.

Classification / Regression
Logistic regression and LASSO regularization.

## Dataset Source

Wine Dataset – Kaggle

This dataset contains the results of a chemical analysis of wines grown in the same region of Italy.
The wines come from three different cultivars (classes). Each record represents one wine sample, along with 13 chemical properties measured in a laboratory.
The dataset is widely used in machine-learning research to demonstrate classification, EDA, and model comparison.


