

old_pp=$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:~/bin

python show_domain.py "$@"

export PYTHONPATH=${old_pp}
