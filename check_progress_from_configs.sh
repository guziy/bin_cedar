

# Check progress of simulations whose config folders are in the current folder
# using chunk_job.log

prefix=${1:-'*'}

echo "prefix=${prefix}"
for chjlog in ${prefix}/chunk_job.log ; do
	echo ""

	label=$(printf "%-40.50s" $(dirname ${chjlog})) 
	value=$(tail -1 ${chjlog})
		
	echo "${label} ---------> ${value}"
	echo "================================="
done
	
