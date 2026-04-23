##install.packages("qqman")
library(qqman)
library(tidyverse)


getwd() #finds current working directory
## select the directory
setwd("/Users/smritichaudhary/Documents/R-studio/Rotation3")
list.files()
data <- read.table("height_gwas_pca3.assoc.linear", header = TRUE)
colnames(data) <- c("CHR_ID", "SNP", "BP", "A1", "TEST", "NMISS", "BETA", "STAT", "P")

acc <- read.table("accession_to_chr.txt", header = FALSE)
colnames(acc) <- c("CHR_ID", "CHR" )

acc$CHR <- sub(",$", "", acc$CHR)

merged_data <- merge(data, acc, by = "CHR_ID", all.x = TRUE, sort = FALSE)

merged_data <- merged_data[complete.cases(merged_data$CHR),] ## removing na
merged_data <- merged_data[complete.cases(merged_data$P),] ## removing na


merged_data$CHR <- as.numeric(merged_data$CHR) ## making it numeric
merged_data <- merged_data[!is.na(merged_data$CHR),]
any(is.na(merged_data$CHR))

merged_data$BP <- as.numeric(merged_data$BP) ## making it numeric
merged_data <- merged_data[!is.na(merged_data$BP),]
any(is.na(merged_data$BP))


manhattan(merged_data, chr = "CHR", ps = "BP", p = "P")
