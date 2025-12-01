FROM rocker/rstudio:4.3.2

RUN apt-get update -qq \
    && apt-get install -y \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libxt-dev \
        pandoc \
        make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN R -e "install.packages(c('tidyverse','cluster','factoextra','GGally','mclustcomp','rmarkdown'))"


WORKDIR /home/rstudio/project
COPY . /home/rstudio/project

ENV PASSWORD=rstudio
EXPOSE 8787
