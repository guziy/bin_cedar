
restarts_dir=${1:-"./"}

# ls ${restart_dir}


months_to_del="02 03 04 05 06 07 08 09 10 11"

for mm in ${months_to_del}; do
	for f in $(ls ${restarts_dir}/*${mm}step*.gz); do
		echo "Deleting $f"
		rm $f
	done
done
