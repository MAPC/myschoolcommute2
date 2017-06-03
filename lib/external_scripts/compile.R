library(RPostgreSQL)
library(DBI)
library(reshape2)
library(plyr)
library(ggplot2)
library(scales)
library(knitr)
library(Hmisc)

DATE1 = "2012-06-01"
DATE2 = "2013-06-01"

args = commandArgs(trailingOnly=TRUE) #2

dbname = args[1]
dbuser = args[2]
dbpasswd = args[3]
ORG_CODE = args[4]
DATE1 = args[5]
DATE2 = args[6]
WORKDIR = args[7]

setwd('lib/external_scripts')

load('.RData')
source("generate_report.R")
# test with 1 response
# ORG_CODE = "06450310"
# source("generate_report.R")
# test with more than 10 responses
# ORG_CODE = "02480014"
# source("generate_report.R")
# test with missing org code
# ORG_CODE = "05160002"
# source("generate_report.R")


