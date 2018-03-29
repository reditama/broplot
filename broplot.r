#!/usr/bin/Rscript
library('getopt')
library('batch')
library('plotly')

option_specification = matrix(c(
  'input', 'i', 2, 'character',
  'output', 'o', 2, 'character'
), byrow=TRUE, ncol=4);

options=getopt(option_specification);

table=read.delim(options$input, "\t", header=TRUE,row.names=NULL);
table_num= ncol(table);
rowname=table[,1];
table_content=table[,2:table_num];
table_content_m=data.matrix(table_content);
table1=prop.table(table_content_m, 1)*100;
rownames(table1)<-rowname;
tablex<-data.frame(table1);
tcol=ncol(tablex);
sequence=seq(2,tcol);

p <- plot_ly(tablex, x = rowname, y = tablex[,1], type = 'bar', name = colnames(tablex)[1]) %>%
layout(yaxis = list(title = '% Abundance'), barmode = 'stack', title = colnames(table)[1])

for (i in sequence){
p <- add_trace(p, x = rowname, y = tablex[,i], name=colnames(tablex)[i])
}

htmlwidgets::saveWidget(p, options$output);
