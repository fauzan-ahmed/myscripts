#Script to create a dataframe for PCA 
#Need matrix data. 
library(RColorBrewer)
library(plotly)
#Derive matrix from raw counts data
pca <- prcomp(t(mat), center=TRUE, scale.=FALSE) # Where mat is the normalized counts matrix - can be TMM, CPM or DESeq2 VST matrix. 

#Create dataframe. 
pca_df <- data.frame(
  PC1       = pca$x[,1],
  PC2       = pca$x[,2],
  PC3       = pca$x[,3],
  Sample    = rownames(pca$x)
)

# Attach Treatment being studied, sample name column, etc
pca_df$`....` <- metadata_filled[pca_df$Sample, "....."]

#Calculate % variance explained for axis labels
var_explained <- round(100 * (pca$sdev^2 / sum(pca$sdev^2)), 1)

#Plot the actual graph
plot_ly(data= pca_df, x = ~PC1, y = ~PC2, z = ~PC3,
        color = ~`Treatment`,type = "scatter3d", #These are options that can be edited based on preferences and requirements. 
        mode= "markers", marker  = list(size = 7, symbol = "circle-open", line =list(width=2)) # Shapes can also vary. 
) %>%
  layout(
    title = "3D PCA of Samples",
    scene = list(
      xaxis = list(title = paste0("PC1: ", var_explained[1], "% var")),
      yaxis = list(title = paste0("PC2: ", var_explained[2], "% var")),
      zaxis = list(title = paste0("PC3: ", var_explained[3], "% var"))
    )
  )
