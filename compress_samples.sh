#!/bin/bash

. s.ssmuse.dot fulldev

set -e
set -x


smp_dir=${1:-"./Samples"}

echo "smp_dir=$(true_path ${smp_dir})"
echo "work dir: $(pwd)"

for monthdir in ${smp_dir}/*; do
	for fin in ${monthdir}/*; do
		
		fstcompress -fstin ${fin} -fstout ${fin}_tmp -level best
		mv ${fin}_tmp ${fin}
	done
done
