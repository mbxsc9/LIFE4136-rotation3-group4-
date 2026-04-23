##install.packages("qqman")
library(qqman)
library(tidyverse)

library(qqman)
library(tidyverse)

## select the directory
setwd("XXX/Rot3/dog")
data <- read.table("gwas_doggies_height_pca3.assoc.linear", header = TRUE)

# Function to convert chromosome names to numeric values for qqman manhattan plot
chr_to_int <- function(x, unique_chromosmes) {
  match(x, unique_chromosmes)} 
  
# Order by CHR and assign numeric values to chromosomes
data <- data %>% arrange(CHR)
unique_chromosmes <- c(unique(data$CHR))
data$CHR_NUM <- chr_to_int(data$CHR, unique_chromosmes)

# Filter for only ADD
data <- data[data$TEST=="ADD", ]
  
# Create Manhattan plot
png(file="Canis_Manhattan.png", width = 1600, height=1200)
manhattan(data, chr = "CHR_NUM", bp = "BP", p = "P", main = "Genome-wide Association Analysis of Height in Canis lupus familiaris", ylim = c(0,15), col=c("#3f97b4", "#6a6a6a"))
dev.off()

# View Highest P value points
canis_dataset_top_P_value <- data %>% arrange(P)
head(canis_dataset_top_P_value, 25)


manhattan(merged_data, chr = "CHR", ps = "BP", p = "P")
