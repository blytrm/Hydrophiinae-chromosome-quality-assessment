#!/usr/bin/env bash
#SBATCH --job-name=build-JBAT-hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 2
#SBATCH --time=8:00:00
#SBATCH --mem=40GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

SCAFFDIR="/home/${USER}/al-biohub/billy_trim/scaffolding/haphic/17-hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3/04.build"

cd "${SCAFFDIR}" || exit 1

bash juicebox.sh
