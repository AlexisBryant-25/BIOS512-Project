
---
```Dockerfile
# BIOS 512 Final Project Container (RStudio + R environment)
FROM rocker/rstudio:4.3.2

# System dependencies
RUN apt-get update -qq && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev libxt-dev pandoc make

# Install R packages
RUN R -e "install.packages(c('tidyverse', 'cluster', 'factoextra', 'caret', 'glmnet', 'GGally', 'nnet', 'rmarkdown'))"

# Environment setup
WORKDIR /home/rstudio/project
COPY . /home/rstudio/project

# Default password
ENV PASSWORD=rstudio

EXPOSE 8787
