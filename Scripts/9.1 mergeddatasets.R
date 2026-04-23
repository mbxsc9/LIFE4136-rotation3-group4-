#load libraries
library(readr)
library(dplyr)

#import metadata file
setwd("/Users/laylameghjee/GIT/Rot3")
metadata <- read_tsv("/Users/laylameghjee/GIT/Rot3/metadata.tsv")
metadata_df <- as.data.frame(metadata)

#seeing the names of the columns
colnames(metadata_df)

#keeps only specified columns
MD_refined <- select(metadata_df, sample_accession, individual_id, breed, run_accession,scientific_name)

#importing csv file of weight info per breed
dogdata <- read_csv("/Users/laylameghjee/GIT/Rot3/akc-data-2020-05-18 11_36_36.944067.csv")

#renaming column one as breeds so it matches metadata
colnames(dogdata)[1] <- "breed"

mergeddata <- merge(MD_refined, dogdata, by = "breed")
