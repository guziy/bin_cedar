#!/bin/bash

# sim_path_in_stage=/gs/project/ugh-612-aa/huziy/EXECDIR/stage/NA_0.11d_Jun14_SN_climato_over_PC-region_201306
# output_samples_folder="/gs/project/ugh-612-aa/huziy/Output/Floods/NA_0.11d_Jun14_SN_climato_over_PC-region/Samples"

set -e

sim_path_in_stage=/home/huziy/MODEL_EXEC_RUN/cedar5/stage/coupled-GL-future_CanESM2_??????
output_samples_folder="/home/huziy/rrg-sushama-ab/Output/GL_CC_CanESM2_RCP85/coupled-GL-future_CanESM2/Samples"

#. s.ssmuse.dot fulldev

function get_year_month
{
	#set -x 
	# path to the rpn file
	rfile=$1

	nums=($(voir -iment ${rfile} -style | grep -v -E ">>|\^\^|HY" | grep -E "^[[:space:]]+[[:digit:]]+-" | head -1 | grep -E -o "([[:digit:]]{8,})"))


	# get the date string and then select only the year and month parts
	# echo ${nums[@]}
	the_date=${nums[0]}
	date_len=${#the_date}


	echo ${the_date::${date_len}-2}

}


function get_out_file_path
{
	infile=$1
	out_samples=$2

	ym=$(get_year_month ${infile})
	for mfolder in ${out_samples}/*${ym}
	do
		infname=$(basename ${infile})
		echo ${mfolder}/${infname%%-*}_${infname##*_}
		break
	done

}



for f in ${sim_path_in_stage}/last_step_*/000-000/*
do
	# get_year_month $f


	out_fpath=$(get_out_file_path "${f}" "${output_samples_folder}")
	
	out_fname=$(basename ${out_fpath})

	if [ -e "${out_fpath}" ]; then
 		echo "${out_fpath} already exists, skipping."
		continue
	fi

	echo $f

	cp ${f} ${out_fpath} 

done



for sim_dir in ${sim_path_in_stage}; do
	mv ${sim_dir} ${sim_dir}.bak
done







