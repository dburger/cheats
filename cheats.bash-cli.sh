# examples, examples, and more examples?

# make it so that any non-zero exit code will exit the script
set -e

# make it so that output redirects won't clobber files
set -o noclobber
# and of course turn off
set +o noclobber
# even when noclobber is on you can override with >|
echo "whatever" >|filename.txt

# suppress newline with echo
echo -n "whatever"
# do shell escapse with echo
echo -e "hello\nworld"

# redirect stderr to same place as stdout, classic
echo "whatever" >file.txt 2>&1
# using shortcut
echo "whatever" >&file.txt
# or flipped
echo "whatever" &>file.txt

# capture all output without using a subshell, spaces
# and semicolons important!
{ echo "yeah"; cd foo; ls -al; } > file.txt

# this can also allow you to group a couple of statements,
# spaces and semicolons important!
[ $result = 1 ] || { echo "didn't work"; exit 69; }

# $* will give all passed parameters but for handling spaces
# you should probably use the following:
for a in "$@"; do
done

# the count of parameters is in $#, can use in comparison
if [ $# -lt 3 ]; then
# or arithmetic
if (( $# < 3 )); then

# type and which will show you where a command is coming from,
# type includes aliases and builtins while which does not, with
# the -a switch it shows all instead of stopping at first found
type -a cd
which -a cat

# apropos returns results from man pages
apropos delete

# different kinds of file information
file name.txt
stat name.txt

# show defualt file permissions, bit on means does not get
umask
0027

# change mask so that everyone gets read and execute but not write
umask 0022

# rename a bunch of files from a prefix + number to just the number
ls QuizUI_* | sed 's/Quiz\(UI_[0-9][0-9]\.png\)/mv Quiz\1 \1/' | sh

# chop up a web page changing a <option> list into a couple of columns
sed -e 's/<option value=\(....\)>\(.*\)/put(\1, "\2");/g' countries.txt

# in place edit with backup remove single space in CSV column
sed -i[bak] -e 's/, ,/,,/g' hotspot-list2.txt

# recursive in place edit, no backup, of X with Y, grep is better here than find
grep -rl 'X' | xargs sed -i 's/X/Y/g'

# another fancy rename making *-consolidated.xls consolidated-*.xls
ls *consolidated.xls | sed 's/\(.*\)-consolidated.xls/mv \0 consolidated-\1.xls/' | sh

# remove from { to } in a text file spanning multiple lines, used to clean up
# an informix DDL for usage with SQL Server, derived from sed one liners page
sed -e ':a;s/{[^}]*}//g;/{/N;/{/ba' input.ddl

# output lines from line 1 to line 1000 to a file
sed -n '1,1000 p' file > output
# what? why not just
head -1000

# output a range of a file turning on with first regex and off with second
sed -n '/Starting analysis mailing.*30379003/,/Completed analysis mailing.*30379003/p' gse.log-2010_11_17_19_11_46

# add line numbers to the output and then dump the range
cat -n foo.txt | sed -n "/start/,/finish/p"

# fetchmail forward to dburger@camberhawaii.org every 5 minutes from dburger
# account at ip
fetchmail -d 300 --smtpname dburger@camberhawaii.org -p POP3 -u dburger 172.16.100.7

# syntax colorization
source-highlight Test.java -f html

# set up ethernet card from command line
sudo ifconfig eth0 netmask 255.255.255.0 72.235.74.144
route add default gw 72.235.74.1
sudo ifconfig eth0 up

# checkout a git repo
git clone ssh://git.camberhawaii.org/var/data/repos/first.git

# make a local branch also remote
git push origin local-branch-name

# mail with sendmail compatible send
mail -s 'pagemon report' to@addr.com -- -F'David J. Burger' --ffrom@addr.com

# don't send if body empty via -E
somecmd | mail -E -s "the subject" addr@com.com

# simple loop
for i in *; do ....; .....; done

# remove files from a directory older than 30 days
find /home/you/backup/ -mtime +30 -exec rm {} \;

# list files modified 1 or fewer days ago
find . -type f -mtime -1

# list files modified 5 or fewer minutes ago
find . -type f -mmin -5

# sort a CSV file by a column, here by column 7
sort -t',' -k 7 hotspot-list2.txt  > foo.txt

# select 100 random lines of a file via a random sort
sort -R file | head -100

# set up a tunnel, local box listening on lport hitting rport on tohost,
# through throughhost
ssh -L  lport:tohost:rport throughhost

# chown a symlink, pass -h
chown -h user:group symlink

# email a picture to your flickr addr
(cat description.txt; uuencode laura.jpg laura.jpg) | mail -s 'subject' flickraddr@photos.flickr.com

# checkout every revision of a file from subversion
svn log -q ./src/java/com/bigtribe/sync/adapter/SimpleCsvReader.java | \
    grep "^r[0-9]\+ " | awk '{ print substr($1, 2) }' | \
    while read rev; do svn cat -r $rev src/java/com/bigtribe/sync/adapter/SimpleCsvReader.java > $rev.txt; done

# awk to print second column identify longest line
awk 'BEGIN {FS=","}; {print $2}' hotspot-list2.txt | wc -L

# awk to pull ip address from box
ifconfig | grep 'Bcast' | awk '{print $2' | awk 'BEGIN {FS=":"} ; {print $2}'

# change jpg to pdf using ImageMagick
convert page1.jpg -compress jpeg page1.pdf

# merge pdfs using ghostscript
gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
   -sOutputFile=out.pdf page1.pdf page2.pdf

# send through netcat
tar cvf  - * | nc target 12345
# receive through netcat
nc -lp 12345 | tar xvf -

# cause hit to port 80 to hit 9080 with iptables
sudo iptables -t nat -A OUTPUT -d 127.0.0.1 -p tcp --dport 80 -j REDIRECT --to-port 9080
# and port 443 to 9443
sudo iptables -t nat -A OUTPUT -d 127.0.0.1 -p tcp --dport 443 -j REDIRECT --to-port 9443

# andy actually did this with an xinetd setup:
service geohana{
        type            = unlisted
        socket_type     = stream
        protocol        = tcp
        user            = root
        wait            = no
        port            = 80
        redirect        = localhost 9080
        disable         = no
}

# on OS X using firewall rules having 80 hit 9080
ipfw add 100 fwd 127.0.0.1,9080 tcp from any to any 80 in

# remote X11 execution
ssh -X -Y -C dburger@uhunix.its.hawaii.edu emacs

# git pull multiple projects under the current directory
for dir in */; do (cd "$dir" && git pull) done

# template for executing multiple commands with find
find . -type f | while read $file; do
  echo "$file"
  # do lots o stuff
done

# batch resize and compress images - will attempt to keep aspect ratio
# unless you add a ! to the end of the dimensions
mogrify -resize 1024x1024 -quality 75 *JPG

# generate self signed cert
openssl req -new -x509 -days 30 \
  -keyout /etc/apache2/conf/ssl.key/server.key \
  -out /etc/apache2/conf/ssl.crt/server.crt \
  -subj '/CN=Test-Only Certificate'

# notifications on the gnome desktop
notify-send -i info -t 3000 "don't do that"

# generate TAG file with exuberant etags recursively from the current directory
# ignoring directories starting with blaze
# (note, "sudo apt-get install exuberant-ctags", this is not standard
#  etags / ctags syntax)
ctags --exclude=blaze* -e -R .

# regular expression comparison in bash
if [[ "Hour 1276625700" =~ ^Hour\ [0-9]+$ ]]; then
  echo "matched"
else
  echo "nomatch"
fi

# negation of regular expression comparison in bash
if [[ ! "Hour 1276625700" =~ ^Hour\ [0-9]+$ ]]; then
  echo "nomatch"
else
  echo "matched"
fi

# make a backup at 4:20 am everyday with rsync via cron
20 4 * * * rsync -av --delete /usr/local/google/git/eye3 /home/dburger/bak

# scrape with curl and mail
30 9 * * * curl http://eye3-analysis/varz | grep "\(\(g\|p\)4.*invocations\)\|\(sccs.*\)" | sed -e 's/<b>//g;s/<\/b>//g;s/<br>//g' | mail -s "SCCS Stats - example script harvested output" recipient@foo.com

# loop against some database machines collecting some information, here executing mysql
for host in agpq14 bfgd20 iaco20 ynoo20 ynpp21 ynqq20 ynrr17 ynss21; do
  ssh root@$host "mysql -u user -ppassword database -e 'SHOW SLAVE STATUS\G' | grep Seconds_Behind_Master"
done

# and a second simple looping example
for host in agpq14 bfgd20 iaco20 ynoo20 ynpp21 ynqq20 ynrr17 ynss21; do
  ssh root@$host "mysql -u user -ppassword database -e 'CHECKSUM TABLE IdSequences'"
done

# determine the log file a process is writing to, first determine the pid, then
lsof -p pid | grep log

# using dot to draw a directed graph given the input file, piping through tred
# would give you a transitive reduction
digraph G {
  main -> parse -> execute;
  main -> init;
  main -> cleanup;
  execute -> make_string;
  execute -> printf;
  init -> make_string;
  main -> printf;
  execute -> compare;
}
$ dot -Tpng -o deps.png input.dot

# example bulk import change with sed, will leave .BAK backup files
find . -name "*java" | xargs grep -l "com\.google\.gwt\.event\.shared\.SimpleEventBus" | xargs sed -i.BAK 's/com\.google\.gwt\.event\.shared\.SimpleEventBus/com.google.web.bindery.event.shared.SimpleEventBus/'

# use awk to produce average from stream
grep "^110513 04.*Task completed in" gse.log | \
    sed 's/^.*Task completed in \([0-9]*\) .*$/\1/' | \
    awk '{total+=$1; count+=1} END {print total/count}'

# grep for counts of event during each 10 minute time frame in the 1 am hour
for x in 0 1 2 3 4 5; do grep "^110520 03:${x}.*Task completed" gse.log  | wc -l; done

# show the lines common to file1 and file2
comm -12 <(sort file1) <(sort file2)

# handling spaces in file names when piping from find to xargs
# causes null terminated separation, either way
find . -name "*.foo" -print0 | xargs --null ls -l
find . -name "*.foo" -print0 | xargs -0 ls -l

# prune a path from a find before the rest of the matching
find . -path ./review -prune -o -name "*java"

# example one line while
while true; do ls; echo "sleeping"; sleep 5; done
# or similar
while :; do ls; echo "sleeping"; sleep 5; done

# launch screen changing activation key to C-\ instead of C-a
screen -e ^\\\\\\

# create a navigable master document from several markdown files
pandoc -st html5 --toc --section-divs -o /home/dburger/www/out.html *markdown

# tail, but instead of how many tail lines to show, what line to start at
tail +100 file.txt

# xargs for parallel execution, 1 argument to each invocation, 15 threads
cat input | xargs -n 1 -P 15 doit.sh

# xargs as non tail argument
cat input | xargs -I '{}' cmd --foo='{}' --bar=baz

# xargs one arg at a time, 40 threads, on a randomized file
sort -R leftovers | xargs -n 1 -P 40 -I '{}' ms delete_rows --ns=eye3.prod --table=PositionsV2 --key='{}'

# using a here document as data in a script
grep $1 <<EOF
EOF

# prevent shell expansion in a here document, add a slash
<<\EOF
EOF

# allow tab indent in here document, use the minus
<<-EOF
EOF

# read with a prompt
read -p "What is your name?" NAME

# read with prompt suppress echo
read -sp "What is your name?" NAME

# select for multiple choice input
select foo in $list; do
  if [ $foo = "whatever"]
    ...
    break;
done

# when you run a process in the background you get a process number
# and pid
$ foo &
[1] 8970
# the process number can be used to bring the process to the foreground
$ fg 1
# if you start a process in the foreground and it is going to take a
# long time you can make it a background process first by hitting
# CTRL-Z to pause it and then bg to send it to the background

# launch detached process using nohup
nohup longproc &

# parameter expansion return value or default if not set
PATH=${1:-/tmp}

# assign and return if not set or empty
${HOME:=/tmp}
# assign and return if not set
${HOME=/tmp}

# integer math two ways
X=(( COUNT * 3 ))
let X=COUNT*3

# three types of while, arithmetic
while (( COUNT < MAX )); do
# filetest
while [ -z "${FILE}" ]; do
# read
while read A B; do

# pattern match with [[
if [[ "${MYFILE}" == *.jpg ]]; then
# or regex with =~
if [[ "${MYFILE}" =~ .*\.jpg ]]; then

# will parse out according to separator, putting all remaining
# in last
ls -l | while read X Y; do echo $X; done

for ((i=0; i<10; i++); do
for i in $(seq 1.0 .01 1.1); do
seq 1.0 .01 1.1 | while read i; do
for i in {1..12}; do

until [ ]; do

done

# trick for using positional argument parsing
set -- $(ls -al)
# now can use $1, $2, ...

# using a function for parsing
function foo() {
  PERMS=$1
  ...
# invoke to set your variables
foo $(ls -al ~/some/file)
# now use your variables

${RANDOM}

# invoke command foo with argument bar suppressing function lookup
command foo bar

# invoke shell built in without command look up
builtin cd ~/foo

# null command can be used with variable setting parameter expansions
: ${FOO:=doggy}

# if wait is not given an id, it waits for all currently active
# child processes to finish
whatever &
another &
wait

# dump seconds since epoch at beginning of given date
date -d "$yea/$month/$day" +%s

# with dashes
date +%F

# example worker script
#!/usr/bin/env bash

count=0
while ((count < 100)); do
  servers=$(foo zork | awk '{print $4":"$3}')
  num=0
  for server in $servers; do
    rpcget "$server/exceptionz?proto" > "out.$count.$num.statusz"
    ((num++))
  done
  echo "Finished round $count, sleeping 10 minutes"
  sleep 600
  ((count++))
done

# bash arrays iterative additions
x=(something)
x+=(another)
# expansion
echo "${x[*]}"
# when within quotes the prior is a single word, this is separate words
echo "${x[@]}"

# sed delete matching lines in place
find . -name BUILD | xargs sed -i '/"\/\/java\/com\/google\/monitoring\/eye3\/model\/validation"/d'

# Escaping shell arugments, since single quotes escape everything replace each ' with '\'' and then
# surround entire argument with single quotes. Example:
\000\377\$Ux&foo<boo'hi\323 becomes '\000\377\$Ux&foo<boo'\''hi\323'

# execute on each found file, one at a time
$ find . -name '*sh' -exec et {} \;
# same as
$ find . -name '*.sh' | xargs et

# execute on each found file, passing all at once
$ find . -name '*sh' -exec et {} +
# same as
$ find . -name '*.sh' | xargs -n 1 et

# sed example large in place edit
grep -rlI "import com.google.monitoring.eye3.common.persistence.Datastores" . | xargs sed -i 's/import com.google.monitoring.eye3.common.persistence.Datastores/import com.google.monitoring.eye3.persistence.Datastores/'

# sed example delete matching lines
$ find . -name BUILD | xargs sed -i '/ui:mock/d'

# what imports are used among several different files
$ grep -h import | sort -u

# what is running on port 8080?
$ netstat -t | grep 8080

# combo for work
$ lockserv resolveall /abns/docs/kix-scary-canary.frontend | cut -d' ' -f2,3 | sed -e 's/ /:/' | xargs -I '{}' echo "rpcget http://{}/protostatusz?messages&mode=proto" > foo.txt

# nmcli
nmcli device wifi list
nmcli device wifi connect pookie5g -a
nmcli -f name -t connection show --active

# change delimiter in sed when address is first
# start with backslash
$ find . -name BUILD | xargs sed -i '\|foo|d'

# Showing file system usage disk space usage
$ df -HT

# Showing disks
$ fdisk -l

# sed delete bash style comments and blank lines
$ sed "s/\s*#.*//g; /^$/d" file.txt

# Generating random numbers
$ echo $RANDOM
# In a range
$ echo $(( RANDOM % 100 ))
