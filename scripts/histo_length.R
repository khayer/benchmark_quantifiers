# Histrogramm for Transcript length
setwd("/Users/hayer/github/benchmark_quantifiers/scripts/")

d = read.csv("../files/transcript_metrics_ENS.PD.txt",sep = "\t")
head(d)
hist(log(d$length[d$length<20000]))
max(d$length)
# 106477
mean(d$length)
# 1919.879
median(d$length)
# 1215
sum(d$length < 1200)
# 43509
sum(d$length >= 1200)
# 44056
dim(d)
#[1] 87565     9
tail(sort(d$length),100)
