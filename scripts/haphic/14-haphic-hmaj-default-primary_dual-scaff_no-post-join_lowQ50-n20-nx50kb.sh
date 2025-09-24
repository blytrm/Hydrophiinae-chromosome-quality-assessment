#!/usr/bin/env bash
#SBATCH --job-name=haphic-hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n20-nx50kb
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 20
#SBATCH --time=2:00:00
#SBATCH --mem=20GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

BN="hmaj-default-primary_dual-scaff_no-post-join_lowQ50"
FA="/home/${USER}/al-biohub/billy_trim/assembly/${BN}.hic.p_ctg.fa"
BAM="/home/${USER}/al-biohub/billy_trim/scaffolding"
OUT="/home/${USER}/al-biohub/billy_trim/scaffolding/haphic"

mkdir -p ${OUT}/${BN}

SW="/home/${USER}/hpcfs/software/HapHiC"
N_CHROM=20

${SW}/haphic pipeline \
    ${FA} "$BAM/hic-to-contigs/${BN}.hic.filtered.bam" ${N_CHROM} \
    --RE "GATC,GANTC,CTNAG,TTAAC" \
    --outdir ${OUT}/14-${BN}-n20-Nx_50kb \
    --threads ${SLURM_CPUS_PER_TASK} \
    --processes ${SLURM_CPUS_PER_TASK} \
    --Nx 50000
