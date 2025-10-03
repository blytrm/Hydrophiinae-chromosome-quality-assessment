#!/usr/bin/env bash
#SBATCH --job-name=meryl-hifi-db
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 25
#SBATCH --time=24:00:00
#SBATCH --mem=65GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

READS="/home/a1645424/al-biohub/bpa/data/hifi/hydmaj.fastq.gz"
OUT="/home/${USER}/al-biohub/billy_trim/scaffolding/scaffolding-assessment/01-meryl-read-db"

# Meryl read database
mkdir -p "${OUT}"

meryl count \
    k=31 \
    threads="${SLURM_CPUS_PER_TASK}" \
    memory=50 \
    "${READS}" output "${OUT}/hifi.meryl"
