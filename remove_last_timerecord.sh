#!/bin/bash

in_dir=${1}
out_dir=${in_dir%\/}_fixed
# ======================================================

set -e

mkdir -p ${out_dir}

function get_month_from_path(){
	local fpath=$1
	
	fn=$(basename ${fpath})
	tok=$(echo ${fn} | egrep -Eo '\_[[:digit:]]{6}')
	mm=$(echo -n ${tok} | tail -c 2)
	echo ${mm} | sed 's/^0*//'
}

function get_next_month(){
	local m=$1
	
	m1=$((m + 1))
	if [ ${m1} = "13" ]; then 
		m1=1
	fi
	echo ${m1}
}


for f in ${in_dir}/*; do
	m=$(get_month_from_path ${f})
	m_next=$(get_next_month ${m})
	echo "${f}: ${m}, del month=${m_next}"

	f_out=${out_dir}/$(basename ${f})

	cdo delete,month=${m_next} ${f} ${f_out}
done
