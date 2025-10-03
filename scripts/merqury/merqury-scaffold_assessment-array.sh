#!/usr/bin/env bash
#SBATCH --job-name=merqury-hifi-db
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 30
#SBATCH --time=06:00:00
#SBATCH --mem=50GB
#SBATCH --array=1,4,6,9
#SBATCH -o %x_%a_%A_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

export MERQURY="/home/${USER}/hpcfs/software/merqury"

SCAFFDIR="/home/${USER}/al-biohub/billy_trim/scaffolding/haphic"
DB="/home/${USER}/al-biohub/billy_trim/scaffolding/scaffolding-assessment/01-meryl-read-db/hifi.meryl"
OUT="/home/${USER}/al-biohub/billy_trim/scaffolding/scaffolding-assessment/02-Kmer-evaluation"

FA=$(find "${SCAFFDIR}" -name 'scaffolds.fa' | tr '\n' ' ' | cut -d' ' -f "${SLURM_ARRAY_TASK_ID}") # Path to 'scaffold.fa' file
TMP_VAL=$(dirname "${FA}") # Can ignore this
BN=$(basename "$(dirname "${TMP_VAL}")") # Name contains arguments we tested
BN_SIMPLE=$(echo "${BN}" | sed -r 's/.{3}//')

# Merqury results directory
mkdir -p "${OUT}/${BN}"

cd "${OUT}/${BN}" || exit 1

echo $BN
merqury.sh "${DB}" "${FA}" "${BN_SIMPLE}"
