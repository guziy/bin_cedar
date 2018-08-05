#! /bin/bash

start_year=$1
end_year=$2

prefix=$3

nFilesInFolder=-1


for y in $(seq ${start_year} ${end_year})
do
    missing_months=0
    for m in 01 02 03 04 05 06 07 08 09 10 11 12
    do
        path="${prefix}${y}${m}"
        if [[ -d ${path} ]]
        then

            	#check if the number of files is not changing between folders
            	nFilesCurrent=$(ls ${path} | wc -w)
           	#echo "num of files in the folder ${nFilesCurrent}"
            			
		if [ ${nFilesCurrent} -lt 2 ]; then
			echo "might be a problem here: ${path}, only ${nFilesCurrent} files there!"
		else
			hasPmOrDmOrDp=0
			for f in ${path}/*
			do
				bf=$(basename $f)
				if [[ $bf == pm* ]] || [[ $bf == dm* ]] || [[ $bf == dp* ]] || [[ $bf == pp* ]]; then
					((hasPmOrDmOrDp=hasPmOrDmOrDp+1))
					continue	
				else
					echo "Unrecognized file or folder found: ${path}/$bf"
				fi
			done

			if [[ ${hasPmOrDmOrDp} -eq 0 ]]; then
				echo "Could not find the usual output files in ${path}"
			fi
		
		fi
	        
        else
            missing_months=$((${missing_months} + 1))
            echo "${path} does not exist!"
        fi
    done

    if [ "${missing_months}" == "0" ]
    then
        echo "All months for the year ${y} are present!"
    fi
    missing_months=0

done


echo "Checking if data for each month is complete:"


# find first month dir
# first_month=$(ls -1 ${prefix}* | sort -n | head -1)

for m in {1..12}; do
    mm=$(printf "%02d" $m)

    nfiles_per_month=0

    month_stats="checks_for_month_${mm}.txt"
    echo "Checking ${mm}:" > ${month_stats}
    for y in $(seq ${start_year} ${end_year}); do
        for monthdir in ${prefix}*${y}${mm}; do
                       

            if [ ! -d ${monthdir} ]; then
                echo "ERROR: ${monthdir} does not exist!"
                continue
            fi
            echo "$y/$mm --> $(ls -1 ${prefix}*${y}${mm} | wc -l)" >> ${month_stats}
        done
    done 
done


# print the summary of counts for each month
echo "Unique counts summary for each month:"
for m in checks_for_month_*.txt; do echo "${m}: $(grep '\-\-' ${m} | cut -d ' ' -f 3 | uniq)"; done


