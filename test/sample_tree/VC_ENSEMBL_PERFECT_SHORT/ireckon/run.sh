#!/bin/bash -e
#BSUB -J ireckon
#BSUB -o ireckon.%J.out
#BSUB -e ireckon.%J.error
#BSUB -n 10
#BSUB -M 16000
[[ -f tmp_ireckon_ucsc ]]  || ln -s /project/itmatlab/for_katharina/greg_new/annotation/mm9_ensebl_ucsc_format_filtered.txt tmp_ireckon_ucsc
[[ -f tmp_genome_fa ]]  || ln -s /home/hayer/itmat/benchmark_quantifiers/index/mm9_ucsc_all_numbered_chr.fa tmp_genome_fa
[[ -f tmp_genome_fa.fai ]]  || ln -s /home/hayer/itmat/benchmark_quantifiers/index/mm9_ucsc_all_numbered_chr.fa.fai tmp_genome_fa.fai
java -Xmx15000M -jar /home/hayer/itmat/benchmark_quantifiers/tools/IReckon-1.0.8.jar test/sample_tree/VC_ENSEMBL_PERFECT_SHORT/VC.ENS.PS.s.bam tmp_genome_fa tmp_ireckon_ucsc -1 test/sample_tree/reads/VC.ENS.PS_fwd.fq -2 test/sample_tree/reads/VC.ENS.PS_rev.fq -o . -n 10 -b 0 -novel 0
