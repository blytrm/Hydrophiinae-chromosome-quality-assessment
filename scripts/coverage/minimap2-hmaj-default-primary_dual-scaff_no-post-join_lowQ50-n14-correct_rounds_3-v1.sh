#!/usr/bin/env bash
#SBATCH --job-name=hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3-v1
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 40
#SBATCH --time=12:00:00
#SBATCH --mem=50GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

BN='hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3'
DIR="/home/${USER}/al-biohub/billy_trim"
OUT="${DIR}/chromosome-assembly/17-${BN}/assessment/coverage"
ASM="${DIR}/chromosome-assembly/17-${BN}/${BN}-v1.fa"
HIFI="/home/${USER}/al-biohub/bpa/data/hifi/hydmaj.fastq.gz"

mkdir -p "${OUT}"; cd "${OUT}" || exit 1

source /hpcfs/users/a1645424/micromamba/etc/profile.d/micromamba.sh
micromamba activate minimap2

minimap2 -ax map-hifi -K 2G -2 -t 36 "${ASM}" "${HIFI}" |
samtools sort -m 1G -O BAM -@ 8 -o "${BN}-v1.hifi.bam" -

micromamba deactivate
