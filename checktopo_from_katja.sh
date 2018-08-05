


nx=$1
ny=$2

for x in {5..15}; do
  for y in {5..15}; do
    # echo $(checktopo -gni ${nx} -gnj ${ny} -gnk 56 -cfl 5 -hblen 10 -vspng 3  -npx $x -npy $y)
    if [ `checktopo -gni ${nx} -gnj ${ny} -gnk 56 -cfl 5 -hblen 10 -vspng 3  -npx $x -npy $y  | grep -e "NOT OK" -e "too small" | wc -l` -eq 0 ] ; then
      echo "x=$x y=$y =$(( $x * $y )) OK"
    else
      echo "x=$x y=$y =$(( $x * $y )) not OK"
    fi
  done
done
