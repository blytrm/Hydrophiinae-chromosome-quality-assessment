#!/usr/bin/env bash
#SBATCH --job-name=bwa2-hmaj-default-primary_dual-scaff_no-post-join_lowQ50
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 40
#SBATCH --time=06:00:00
#SBATCH --mem=60GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

BN='hmaj-default-primary_dual-scaff_no-post-join_lowQ50'
FA="/home/${USER}/al-biohub/billy_trim/assembly/${BN}.hic.p_ctg.fa"

HIC_R1="/home/${USER}/al-biohub/bpa/data/hic/hic-trim/350845_R1.fastq.gz"
HIC_R2="/home/${USER}/al-biohub/bpa/data/hic/hic-trim/350845_R2.fastq.gz"

SW="/home/${USER}/hpcfs/software/HapHiC"
OUT="/home/${USER}/al-biohub/billy_trim/scaffolding"

mkdir -p $OUT/hic-to-contigs

bwa-mem2 index ${FA}
bwa-mem2 mem \
    -t ${SLURM_CPUS_PER_TASK} \
    -SP5 \
    ${FA} \
    ${HIC_R1} ${HIC_R2} |
samblaster |
samtools view -Sbh -F 3340 -o "$OUT/hic-to-contigs/${BN}.hic.bam" -

${SW}/utils/filter_bam "$OUT/hic-to-contigs/${BN}.hic.bam" 1 --nm 3 --threads ${SLURM_CPUS_PER_TASK} |
samtools view -bh -@ 8 -o "$OUT/hic-to-contigs/${BN}.hic.filtered.bam" -
