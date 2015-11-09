#!/bin/bash -e
#BSUB -J cufflinks_stats
#BSUB -o cufflinks_stats.%J.out
#BSUB -e cufflinks_stats.%J.error
#BSUB -n 15
#BSUB -M 30000
/home/hayer/itmat/benchmark_quantifiers/tools/cufflinks-2.2.1.Linux_x86_64/cufflinks -o test/sample_tree//VC_ENSEMBL_RIBOZ_EFFECTS_LONG/cufflinks -G /project/itmatlab/for_katharina/greg_new/annotation/simulator_config_geneinfo_mm9-ensembl-stdchr_GTF.gtf --library-type fr-secondstrand -p 15 test/sample_tree//VC_ENSEMBL_RIBOZ_EFFECTS_LONG/tophat_out/accepted_hits.bam