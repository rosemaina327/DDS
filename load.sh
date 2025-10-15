export BASE="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
source /adl/design_kits/umc_65_2025.sh
source ${BASE}/.venv/bin/activate

if [[ -f ${BASE}/lib/icflow/load.sh ]]
then
    echo "Loading ICFLOW from repository"
    source ${BASE}/lib/icflow/load.sh
fi