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

# setwd('lib/external/report')
setwd('C:/Users/cgately/Downloads/myschoolcommute2-develop/myschoolcommute2-develop/lib/external/report')
load('.RData')
source('_read_data.R')
source('_functions.R')

# Clean enrollment data column names for ORG Code
enrollment16_17$ORG_CODE <- sprintf("%08d",enrollment16_17$schid)
enrollment16_17$ORG.CODE <- enrollment16_17$ORG_CODE

enrollment17_18$ORG_CODE <- sprintf("%08d",enrollment17_18$schid)
enrollment17_18$ORG.CODE <- enrollment17_18$ORG_CODE

enrollment18_19$ORG_CODE <- sprintf("%08d",enrollment18_19$ORG_CODE)
enrollment18_19$ORG.CODE <- enrollment18_19$ORG_CODE

enrollment19_20$ORG_CODE <- sprintf("%08d",enrollment19_20$ORG_CODE)
enrollment19_20$ORG.CODE <- enrollment19_20$ORG_CODE

enrollment20_21$ORG_CODE <- sprintf("%08d",enrollment20_21$ORG_CODE)
enrollment20_21$ORG.CODE <- enrollment20_21$ORG_CODE

save(list = ls(all.names = TRUE), file = ".RData", envir = .GlobalEnv)
