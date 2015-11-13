#!/bin/bash -e
#BSUB -J StringTie
#BSUB -o StringTie.%J.out
#BSUB -e StringTie.%J.error
#BSUB -n 10
/home/hayer/itmat/benchmark_quantifiers/tools/stringtie-1.1.2.Linux_x86_64/stringtie test/sample_tree//VC_ENSEMBL_RIBOZ_EFFECTS_LONG/tophat_out/accepted_hits.bam -o transcripts.gtf -p 10 -v -G  /project/itmatlab/for_katharina/greg_new/annotation/simulator_config_geneinfo_mm9-ensembl-stdchr_GTF.gtf -e
