#!/bin/bash

#before starting your run make sure that CLIMAT_pp_cpus=1; in the configexp.dot.cfg of the corresponding configuration
#Not sure, but it seems if you want to run several superjobs in parallel you have to specify different jobnames i.e -jn

#for i in {2..2}
#do
#    u.run_work_stream -t 86400 -cpus 1 -name pp_$i -maxidle 10800 -queues sj1 -- -q sw -jn postprocessor$i
#done

# 86400 - daily


. s.ssmuse.dot runtools

for i in {10..11}
do
    u.run_work_stream -t 86400 -cpus 1 -name pp_$i -maxidle 10800 -queues sj1 -- -q cpubase_bycore_b1 -jn postprocessor$i
done

