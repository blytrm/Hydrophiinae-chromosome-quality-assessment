#!/usr/bin/env bash
#SBATCH --job-name=tblastn-7tm-chromosome-assembly
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 30
#SBATCH --time=24:00:00
#SBATCH --mem=40GB
#SBATCH -o ./%x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

BN='hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3'
DIR="/home/${USER}/al-biohub/billy_trim"
OUTDIR="${DIR}/v2r-annotation"
REF="${DIR}/chromosome-assembly/17-${BN}/${BN}-v1.fa"
QUERY="/home/${USER}/hpcfs/analysis/popgen/results/v2r/tblastn-7tm-genome-search/HMA.7tm.cdhit.fa"

mkdir -p "${OUTDIR}"

cd "${OUTDIR}" || exit 1

source /hpcfs/users/a1645424/micromamba/etc/profile.d/micromamba.sh
micromamba activate blast

if [[ ! -f "${REF}.ndb" ]]; then
    makeblastdb -input_type fasta -in "${REF}" -dbtype nucl -out "${REF}" -parse_seqids
fi

tblastn \
    -query "${QUERY}" \
    -db "${REF}" \
    -out "$(basename ${REF%.fa}).7tm.tblastn.outfmt6" \
    -outfmt 6 \
    -num_threads "${SLURM_CPUS_PER_TASK}"

micromamba deactivate
