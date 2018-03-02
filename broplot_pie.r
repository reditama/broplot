#!/usr/bin/Rscript
library('getopt')
library('batch')
library('plotly')
library('methods')

option_specification = matrix(c(
  'input', 'i', 2, 'character',
  'output', 'o', 2, 'character'
), byrow=TRUE, ncol=4);

options=getopt(option_specification);

table=read.delim(options$input, "\t", header=FALSE,row.names=NULL);
ttable=t(table);
colnames(ttable)=ttable[1,];
data=data.frame(ttable[-1,]);
sequence=seq(2, ncol(data));

for(i in sequence){
datax=data[,c(1,i)];
datay=datax[!(datax[,2]==0),];
dataz=datay[order(datay[,2], decreasing=TRUE),];
printitle=paste(colnames(dataz)[1],"of",colnames(dataz)[2], sep=" ");
printfilename=paste(colnames(dataz)[1],"_of_",colnames(dataz)[2],".html", sep="");
p<-plot_ly(dataz, labels=dataz[,1], values=dataz[,2], type='pie');
p<-layout(p, title=printitle, showlegend=TRUE,
	xaxis=list(showgrid=FALSE, zeroline=FALSE, showticklabels=FALSE),
	xaxis=list(showgrid=FALSE, zeroline=FALSE, showticklabels=FALSE));
htmlwidgets::saveWidget(p, printfilename, title = printitle);
print(dataz)
}
