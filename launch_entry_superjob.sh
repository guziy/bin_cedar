#!/bin/bash

u.run_work_stream -t 2592000 -cpus 1 -name entry_runner_4 -maxidle 36000 -queues entry  -- -q sw -jn entry_runner_4
#u.run_work_stream -t 2592000 -cpus 1 -name entry_runner_4 -maxidle 36000 -queues entry  -- -q sw -jn entry_runner_4
