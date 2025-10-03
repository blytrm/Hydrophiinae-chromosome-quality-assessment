#!/usr/bin/env bash
#SBATCH --job-name=compleasm-scaffold_assessment
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 30
#SBATCH --time=02:00:00
#SBATCH --mem=35GB
#SBATCH --array=9
#SBATCH -o %x_%a_%A_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

SCAFFDIR="/home/${USER}/al-biohub/billy_trim/scaffolding/haphic"
OUTDIR="/home/${USER}/al-biohub/billy_trim/scaffolding/scaffolding-assessment/03-compleasm"
DB="/home/${USER}/al-biohub/database/busco-databases"

FA=$(find "${SCAFFDIR}" -name 'scaffolds.fa' | tr '\n' ' ' | cut -d' ' -f "${SLURM_ARRAY_TASK_ID}") # Path to 'scaffold.fa' file
TMP_VAL=$(dirname "${FA}")
BN=$(basename "$(dirname "${TMP_VAL}")") # Name contains arguments we tested

mkdir -p "${OUTDIR}/${BN}"
echo $BN
compleasm run \
    -a "${FA}" \
    -o "${OUTDIR}/${BN}" \
    -t "${SLURM_CPUS_PER_TASK}" \
    -l 'squamata' \
    -L "${DB}"
