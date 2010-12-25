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
  esac
done

echo "found ${hosts} and ${eth}"

