FROM ruby:2.4.2
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
      nodejs \
      build-essential \
      libxml2-dev \
      libxslt-dev \
      libpq-dev \
      postgresql \
      libgeos-dev \
      ruby-geos \
    ; \
    bundle install

#RUN set -ex \
#    ; \
#    apt-get install -y \
#      libgfortran3 \
#      libreadline6 \
#      r-base \
#    ; \
#    echo 'install.packages(c("RPostgreSQL","DBI","reshape2","plyr","ggplot2","scales","knitr","Hmisc","httr","Rcpp","car"), repos="http://cran.rstudio.com")' > install-packages \
#    && Rscript install-packages \
#    && rm install-packages


# Create user account for Cap and security

COPY .ssh /root/.ssh


CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0
