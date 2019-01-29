library(RPostgreSQL)
library(DBI)
library(reshape2)
library(plyr)
library(ggplot2)
library(scales)
library(knitr)
library(Hmisc)
library(httr)
library(car)

DATE1 = "2012-06-01"
DATE2 = "2013-06-01"
setwd('lib/external/report')
load('.RData')

commandArguments = commandArgs(trailingOnly=TRUE)
args = unlist(strsplit(commandArguments, split=" ")) #2

dbname = args[1]
ORG_CODE = args[2]
DATE1 = args[3]
DATE2 = args[4]
SURVEY_ID = args[5]

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


