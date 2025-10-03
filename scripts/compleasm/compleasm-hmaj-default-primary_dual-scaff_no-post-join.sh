#!/usr/bin/env bash
#SBATCH --job-name=compleasm-hmaj-default-primary_dual-scaff_no-post-join
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -c 30
#SBATCH --time=4:00:00
#SBATCH --mem=30GB
#SBATCH -o %x_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alastair.ludington@adelaide.edu.au

FA='/home/a1645424/al-biohub/billy_trim/assembly/hmaj-default-primary_dual-scaff_no-post-join.hic.p_ctg.fa'
OUTDIR='/home/a1645424/al-biohub/billy_trim/assembly-assessment/compleasm'
DB='/home/a1645424/al-biohub/database/busco-databases'

BN=$(basename ${FA%%.*})

mkdir -p $OUTDIR/${BN}

compleasm run \
    -a ${FA} \
    -o ${OUTDIR}/${BN} \
    -t $SLURM_CPUS_PER_TASK \
    -l 'squamata' \
    -L ${DB}
