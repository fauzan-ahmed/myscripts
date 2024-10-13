#Load Seurat
#This script is used for the converting seurat object to loom file format
#Install dev tools and loomR if not installed
library(Seurat)
install.packages("devtools")
remotes::install_github(repo = 'mojaveazure/loomR', ref = 'develop')
remotes::install_github("mojaveazure/seurat-disk")
library(loomR)
library(SeuratDisk)
#Read in RDS file
seurat_object = readRDS(“Enter your own file path/file.rds)
#Save new loom file
as.loom(seurat_object, filename = “Enter “file path/file.loom”)