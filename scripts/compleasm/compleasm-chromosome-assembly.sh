#!/usr/bin/env bash
#SBATCH --job-name=compleasm-chromosome-assembly
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 30
#SBATCH --time=02:00:00
#SBATCH --mem=35GB
#SBATCH -o %x_%a_%A_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

BN='hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3'
FA="/home/${USER}/al-biohub/billy_trim/chromosome-assembly/17-${BN}/${BN}-v1.fa"
OUTDIR="/home/${USER}/al-biohub/billy_trim/chromosome-assembly/17-${BN}/assessment/compleasm"
DB="/home/${USER}/al-biohub/database/busco-databases"

mkdir -p "${OUTDIR}"

compleasm run \
    -a "${FA}" \
    -o "${OUTDIR}/${BN}" \
    -t "${SLURM_CPUS_PER_TASK}" \
    -l 'squamata' \
    -L "${DB}"
