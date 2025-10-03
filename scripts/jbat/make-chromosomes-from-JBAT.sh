#!/usr/bin/env bash

BN='hmaj-default-primary_dual-scaff_no-post-join_lowQ50-n14-correct_rounds_3'

DIR="/home/${USER}/al-biohub/billy_trim"
CTG="${DIR}/assembly/hmaj-default-primary_dual-scaff_no-post-join_lowQ50.hic.p_ctg.fa"
LO="${DIR}/scaffolding/haphic/17-${BN}/04.build/out_JBAT.liftover.agp"
OUT="${DIR}/chromosome-assembly/17-${BN}"

source "/home/${USER}/hpcfs/micromamba/etc/profile.d/micromamba.sh"
micromamba activate haphic

cd "${OUT}" || exit 1

~/hpcfs/software/HapHiC/utils/juicer post \
    -o tmp \
    out_JBAT.review.assembly \
    "${LO}" \
    "${CTG}"

seqkit sort -l -r tmp.FINAL.fasta | seqkit -p .+ -r "scaffold_{nr}" -o "${BN}-v1.fa"

micromamba deactivate
