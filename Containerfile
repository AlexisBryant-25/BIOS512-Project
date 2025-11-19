

FROM rocker/rstudio:4.3.2


RUN apt-get update -qq && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev libxt-dev pandoc make


RUN R -e "install.packages(c('tidyverse', 'cluster', 'factoextra', 'caret', 'glmnet', 'GGally', 'nnet', 'rmarkdown'))"


WORKDIR /home/rstudio/project
COPY . /home/rstudio/project

ENV PASSWORD=rstudio

EXPOSE 8787
