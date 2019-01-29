FROM ruby:2.5.3
MAINTAINER Eric Youngberg <eyoungberg@mapc.org>

WORKDIR /usr/src/app
VOLUME /usr/src/app
EXPOSE 3000


# Install Ruby deps

COPY Gemfile* ./

RUN set -ex \
    ; \
    apt-get update -qq \
    && apt-get install -y \
      git \
      tzdata \
      build-essential \
      libxml2-dev \
      libxslt-dev \
      libpq-dev \
      postgresql \
      libgeos-dev \
      ruby-geos \
    ; \
    bundle install


# Install Node

RUN set -ex \
    ; \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs


# Install R deps

RUN set -ex \
    ; \
    apt-get install -y \
      libgfortran3 \
      libreadline-dev \
      texlive \
      texlive-science \
      texlive-latex-extra \
      r-base \
    ; \
    echo 'install.packages(c("RPostgreSQL","DBI","reshape2","plyr","ggplot2","scales","knitr","Hmisc","httr","Rcpp","car","tinytex"), repos="http://cran.rstudio.com")' > install-packages \
    && Rscript install-packages \
    && rm install-packages


# Create user account for Cap and security

COPY .ssh /root/.ssh


CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0
