#!/bin/bash

. s.ssmuse.dot diagtools gemclim_3.3.3.1-dev


smp_folder=${1:-$(true_path ./Samples)}

echo "Working on ${smp_folder}"


cd ${smp_folder}


folder_name=$(basename $(dirname ${smp_folder})_daily)

mkdir -p ../../I_daily_PR/${folder_name}
dest_dir=$(true_path ../../I_daily_PR/$folder_name)



# cleanup the output folder
rm -f ${dest_dir}/*


# Select precip and do daily time averaging
for daily_file in */pm*
do


	mfolder=$(basename $(dirname ${daily_file}))

	# Skip december 2012
	if [[ ${mfolder} == *2012?? ]]; then
		continue
	fi


	fname_in=$(basename ${daily_file})
	if [[ ${fname_in} == pm*_00000000p ]]; then
		echo "Skipping ${daily_file}"
		continue
	fi

	rm -f ${daily_file}_PR $(true_path ${daily_file}_PR)_dmean
	echo "desire(-1, ['PR'], -1, -1, -1, -1, -1)" | editfst -s ${daily_file} -d ${daily_file}_PR

	r.diag timavg ${daily_file}_PR $(true_path ${daily_file}_PR)_dmean

	rm ${daily_file}_PR

done


# Create file with coordinates
rm -f coords
for f in $(ls */pm* | grep -v dmean)
do
	
	echo "desire(-1,['^^', '>>'], -1, -1, -1, -1, -1)" | editfst -s $f -d coords
	break
done


coords_file=$(true_path coords)


# Put daily means in one file per month
for mfolder in *
do

	# Skip december 2012
	if [[ ${mfolder} == *201212 ]]; then
		continue
	fi


	# month folder should be a folder, not file
	if [ ! -d ${mfolder} ]; then
		continue
	fi


	cd ${mfolder}
	
	echo "desire(-1, PR, -1, -1, -1, -1, -1)" | editfst -s *_PR_dmean -d ./PR_${mfolder}.rpn
	editfst -i 0 -s ${coords_file} -d ./PR_${mfolder}.rpn

	mv PR_${mfolder}.rpn ${dest_dir}

	rm *_PR_dmean

	# Go back to the samples dir
	cd -

done


rm -f ${coords_file}






