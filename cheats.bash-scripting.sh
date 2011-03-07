# demonstrates how to prevent something like concurrent cron execution with
# file locks via flock
SCRIPT=$(basename "$0")

(
flock -n 200
if [ $? -ne 0 ]
then
  echo "Unable to run ${SCRIPT} because prior run has not finished." | \
    mail -s "${SCRIPT} did not run" dburger@xxxxxx.xxx
  exit 1
fi

echo "got the lock"
sleep 60
) 200>"/var/lock/${SCRIPT}.lock"


# simple demo of basic getopts, for example
# call with getopts -h localhost -e eth42
hosts=
eth=
while getopts "h:e:" name; do
  case $name in
    h) hosts=$OPTARG;;
    e) eth=$OPTARG;;
    *) usage;;
  esac
done

echo "found ${hosts} and ${eth}"

# typical non getopts style parsing of command line arguments
# with parameter expansion
cells="foo bar baz"
command="dumpage"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --cells=*) cells="${1/--cells=/}";;
    --command=*) command="${1/--command=/}";;
    *) usage;;
  esac
  shift
done
