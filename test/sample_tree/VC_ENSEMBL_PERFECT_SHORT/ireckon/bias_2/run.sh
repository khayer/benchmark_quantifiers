#!/bin/bash -e
#BSUB -J ireckon
#BSUB -o ireckon.%J.out
#BSUB -e ireckon.%J.error
#BSUB -n 10
#BSUB -M 16000
java -Xmx15000M -jar /home/hayer/itmat/benchmark_quantifiers/tools/IReckon-1.0.8.jar test/sample_tree//VC_ENSEMBL_PERFECT_SHORT/VC.ENS.PS.s.bam /home/hayer/itmat/benchmark_quantifiers/index/mm9_ucsc_all_numbered_chr.fa /home/hayer/itmat/benchmark_quantifiers/index/mm9_ucsc_all_numbered_chr.fa /project/itmatlab/for_katharina/greg_new/annotation/mm9_ensebl_ucsc_format_filtered.txt -1 test/sample_tree//reads/VC.ENS.PS_fwd.fq -2 test/sample_tree//reads/VC.ENS.PS_rev.fq -o . -n 10 -b 2 -novel 0
