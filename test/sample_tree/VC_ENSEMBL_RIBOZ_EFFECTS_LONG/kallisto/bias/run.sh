#!/bin/bash -e
#BSUB -J kallisto
#BSUB -o kallisto.%J.out
#BSUB -e kallisto.%J.error
#BSUB -n 10
/home/hayer/itmat/benchmark_quantifiers/tools/kallisto_linux-v0.42.3/kallisto quant -i /home/hayer/itmat/benchmark_quantifiers/index/transcripts_kallisto -o test/sample_tree//VC_ENSEMBL_RIBOZ_EFFECTS_LONG/kallisto/bias -t 10 --bias test/sample_tree//reads/VC.ENS.REL_fwd.fq test/sample_tree//reads/VC.ENS.REL_rev.fq
