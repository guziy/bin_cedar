#!/bin/bash

samples_dir=${1:-"./Samples"}

prefixes="dm pm"

for prfx in ${prefixes}; do
	
	out_dir=${samples_dir}_${prfx}

	for mdir in ${samples_dir}/*; do
		mkdir -p ${out_dir}/$(basename ${mdir})
		mv ${mdir}/${prfx}* ${out_dir}/$(basename ${mdir})
	done

done
