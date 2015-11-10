#!/bin/bash -e
#BSUB -J express
#BSUB -o express.%J.out
#BSUB -e express.%J.error
#BSUB -n 20
#BSUB -M 30000
/home/hayer/itmat/benchmark_quantifiers/tools/bowtie-1.1.2/bowtie --threads 20 -k 50 -S -X 800 --offrate 1 /home/hayer/itmat/benchmark_quantifiers/index/transcripts_offrate_1 -1 test/sample_tree//reads/VC.ENS.REL_fwd.fq -2 test/sample_tree//reads/VC.ENS.REL_rev.fq | /home/hayer/itmat/bp2/tools/samtools-0.1.19/samtools view -Sb - > test/sample_tree//VC_ENSEMBL_RIBOZ_EFFECTS_LONG/express/hits.bam
/home/hayer/itmat/benchmark_quantifiers/tools/express-1.5.1-linux_x86_64/express  -m 269.61 -s 39.84 --fr-stranded  /home/hayer/itmat/benchmark_quantifiers/index/transcripts.fa hits.bam
