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
    && apt-get install -y \ 
      nodejs \
      gconf-service \
      libasound2 \
      libatk1.0-0 \ 
      libatk-bridge2.0-0 \
      libc6 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libexpat1 \
      libfontconfig1 \
      libgcc1 \
      libgconf-2-4 \
      libgdk-pixbuf2.0-0 \
      libglib2.0-0 \
      libgtk-3-0 \ 
      libnspr4 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libstdc++6 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxcomposite1 \
      libxcursor1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxi6 \
      libxrandr2 \
      libxrender1 \
      libxss1 \
      libxtst6 \
      ca-certificates \
      fonts-liberation \
      libappindicator1 \
      libnss3 \
      lsb-release \
      xdg-utils \
      wget \
    ; \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y yarn


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
