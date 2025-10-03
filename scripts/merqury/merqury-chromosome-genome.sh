#!/usr/bin/env bash
#SBATCH --job-name=merqury-hifi-db-chromosome
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 30
#SBATCH --time=06:00:00
#SBATCH --mem=50GB
#SBATCH -o %x_%a_%A_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

export MERQURY="/home/${USER}/hpcfs/software/merqury"

BN='hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3'
DIR="/home/${USER}/al-biohub/billy_trim"
OUT="${DIR}/chromosome-assembly/17-${BN}/assessment/kmer-evaluation"
FA="${DIR}/chromosome-assembly/17-${BN}/${BN}-v1.fa"

DB="${DIR}/scaffolding/scaffolding-assessment/01-meryl-read-db/hifi.meryl"

# Merqury results directory
mkdir -p "${OUT}/${BN}"

cd "${OUT}/${BN}" || exit 1

echo $BN
merqury.sh "${DB}" "${FA}" "${BN}"
