
k14 <- read.csv(file.choose(), header = T)

library(EnhancedVolcano)
library(ggrepel)
merged <- na.omit(merged)
EnhancedVolcano(k14,
                lab = k14$Gene.name,
                x = "log2FoldChange",
                y = "padj",
                ylim = c(0,30),                                                 #careful with the limits not to cut everything off
                xlim = c(-15, 15),
                title = "Infected RHDV2 kittens vs uninfected, 24 hpi",
                subtitle = "Transcriptomics differential expression",
                col = c("black", "black", "black", "magenta"),
                colAlpha = 0.4,
                legendPosition = "right",
                legendLabels=c('Not significant','Log (base 2) FC','',
                               'p-value adj & Log (base 2) FC'),
                legendLabSize = 12,
                legendIconSize = 4.0,
                labSize = 3.0,
                #shape = c(6, 6, 6, 16),
                pointSize = c(ifelse(k14$log2FoldChange>2, 2.5, 1)),
                drawConnectors = TRUE,
                typeConnectors = "closed",
                widthConnectors = 0.1,
                colConnectors = "grey50",
                pCutoff = 0.01,
                FCcutoff = 2,
                border = 'full',
                borderWidth = 0.5,
                borderColour = 'black'
) 
