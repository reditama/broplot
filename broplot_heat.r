#!/usr/bin/Rscript
library('getopt')
library('batch')
library('plotly')
library('methods')

option_specification = matrix(c(
  'input', 'i', 2, 'character'
), byrow=TRUE, ncol=4);

options=getopt(option_specification);

table=read.delim(options$input, "\t", header=TRUE, row.names=NULL);
rownames(table)=table[,1]
data=table[,-1]
datax=data.matrix(data)
p<-plot_ly(x = colnames(table), y = rownames(table), z = datax, type = "heatmap")

printitle=paste("Heatmap of", colnames(table)[1], sep=" ");
printfilename=paste("heatmap_of_", colnames(table)[1],".html", sep="");
htmlwidgets::saveWidget(p, printfilename, title = printitle);
print(data)

