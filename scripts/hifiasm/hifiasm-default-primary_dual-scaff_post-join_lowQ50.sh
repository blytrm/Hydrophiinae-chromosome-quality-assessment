#!/usr/bin/env bash
#SBATCH --job-name=hifiasm-default-primary_dual-scaff_post-join_lowQ50
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 40
#SBATCH --time=06:00:00
#SBATCH --mem=150GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

HIFI="/home/a1645424/al-biohub/bpa/data/hifi/hydmaj.fastq.gz"
HIC_R1="/home/a1645424/al-biohub/bpa/data/hic/hic-trim/350845_R1.fastq.gz"
HIC_R2="/home/a1645424/al-biohub/bpa/data/hic/hic-trim/350845_R2.fastq.gz"
OUTDIR='/home/a1645424/al-biohub/billy_trim/assembly'

mkdir -p "${OUTDIR}"; cd "${OUTDIR}" || exit 1

hifiasm \
    -o "hmaj-default-primary_dual-scaff_post-join_lowQ50" \
    -t "${SLURM_CPUS_PER_TASK}" \
    --primary \
    --dual-scaf \
    -u 1 \
    --lowQ 50 \
    --h1 "${HIC_R1}" --h2 "${HIC_R2}" \
    "${HIFI}"
