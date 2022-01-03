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


setwd('lib/external/report')
load('.RData')

commandArguments = commandArgs(trailingOnly=TRUE)
args = unlist(strsplit(commandArguments, split=" ")) #2

dbname = args[1]
ORG_CODE = args[2]
DATE1 = args[3]
DATE2 = args[4]
SURVEY_ID = args[5]
MAP_PNG = args[6]


# dbname="postgresql://postgres@pg.mapc.org:5432/myschoolcommute2"
# ORG_CODE = "00100010"
# DATE1 = "2020-08-01"
# DATE2 = "2021-06-01"
# SURVEY_ID = 34792
# MAP_PNG = 'test.png'

con <- file('test.log')
sink(con,append=T)
sink(con,append=T,type='message')
source("generate_report.R", echo=T, max.deparse.length=10000)
sink()
sink(type='message')
# test with 1 response
# ORG_CODE = "06450310"
# source("generate_report.R")
# test with more than 10 responses
# ORG_CODE = "02480014"
# source("generate_report.R")
# test with missing org code
# ORG_CODE = "05160002"
# source("generate_report.R")


