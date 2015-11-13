#!/bin/bash -e
#BSUB -J rsem
#BSUB -o rsem.%J.out
#BSUB -e rsem.%J.error
#BSUB -M 50000
#BSUB -n 10
/home/hayer/itmat/benchmark_quantifiers/tools/RSEM-1.2.23/rsem-calculate-expression -p 15 --strand-specific --paired-end test/sample_tree//reads/VC.ENS.REL_fwd.fq test/sample_tree//reads/VC.ENS.REL_rev.fq /home/hayer/itmat/benchmark_quantifiers/index/RSEM_mm9_ucsc_all_numbered_chr_transcripts_INDEX -o rsem
