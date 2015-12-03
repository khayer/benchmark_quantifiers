setwd("/Users/kat/github/benchmark_quantifiers/files")
library(limma)
d = read.csv("transcript_metrics_ENS.PD.txt_new",sep="\t", row.names = 1)
head(d)
medium_length_fpkm = d$FPKM
d = read.csv("transcript_metrics_ENS.PLD.txt",sep="\t", row.names = 1)
head(d)
long_length_fpkm = d$FPKM
k = cbind(medium_length_fpkm,long_length_fpkm)
plotMA(k, main = "MVA plot - Medium vs. Long",ylab = "Expression log-ratio")
d = read.csv("transcript_metrics_ENS.PSD.txt_new",sep="\t", row.names = 1)
head(d)
short_length_fpkm = d$FPKM
k = cbind(medium_length_fpkm,short_length_fpkm)
plotMA(k, main = "MVA plot - Medium vs. Short",ylab = "Expression log-ratio")
