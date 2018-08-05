#prefix=${1}
year=${1}
varname=TT
nrecords=0
for f in *${year}??/dm*
do
	nmonth=$(voir -iment $f -style  2>&1 | grep -v NOMV | grep -v FORTRAN | grep ${varname} | wc -l)
	((nrecords=${nrecords}+${nmonth}))
	echo "${nmonth} for ${year}: $f"
done

echo "${nrecords} for ${year}"
