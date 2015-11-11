#!/bin/bash -e
#BSUB -J express
#BSUB -o express.%J.out
#BSUB -e express.%J.error
/home/hayer/itmat/benchmark_quantifiers/tools/express-1.5.1-linux_x86_64/express --no-error-model -m 269 -s 39 --fr-stranded  /home/hayer/itmat/benchmark_quantifiers/index/transcripts.fa ../hits.bam
