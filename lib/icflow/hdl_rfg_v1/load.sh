export RFGV1_HOME="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
export PATH="$RFGV1_HOME/bin:$PATH"

export PYTHONPATH="$RFGV1_HOME/python:$PYTHONPATH"
