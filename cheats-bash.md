# Bash Cheat Sheet

## Some set options

```bash
$ # Non-zero exit codes exit the script
$ set -e
$ # Output redirects won't clobber files
$ set -o noclobber
$ # And then turn back off
$ set +o noclobber
$ # Even when noclobber is on you can override with >|
$ echo "whatever" >|filename.txt
```

## Common set options for all scripts

```bash
set -euo pipefail
```

*   `-e` for exit on errors
*   `-u` for exit on unset variables
*   `-o pipefail` for exit if any part of a pipe fails

## Accumulate command and execute pattern

This pattern builds a command in an array and then executes it.
(Contrived example building up an ls command.)

```bash
# Build it up.
cmd=(ls)
if [[ "${all}" == "true" ]]; then
  cmd+=(-a)
fi
if [[ "${list}" == "true" ]]; then
  cmd+=(-l)
fi
if [[ -n "${filespec}" ]]; then
  cmd+=("${filespec}")
fi
# Execute it.
"${cmd[@]}"
```

## Some echo options

```bash
$ # Suppress newline with echo
$ echo -n "whatever"
$ # Honor shell escapse with echo
$ echo -e "hello\nworld"
```

## Redirect stderr to stdout

```bash
$ # Classic
$ echo "whatever" >file.txt 2>&1
$ # Shortcut approach
$ echo "whatever" >&file.txt
$ # Or same thing flipped
echo "whatever" &>file.txt
```

## Subshell capturing output, spaces and semicolons important!

```bash
$ { echo "yeah"; cd foo; ls -al; } > file.txt
$ # Also allows statement grouping
$ [ $result = 1 ] || { echo "didn't work"; exit 69; }
```

## Trick for using positional argument parsing

```bash
set -- $(ls -al)
# now can use $1, $2, ...
```

## Using a function for argument parsing

```bash
function foo() {
  PERMS=$1
  ...
# invoke to set your variables
foo $(ls -al ~/some/file)
# now use your variables
```

## Looping on parameters

```bash
# $* will give all passed parameters but for handling spaces you
# should probably use the following:
for a in "$@"; do
  echo "$a"
done
```

## Count of parameters is in $#, can use in comparison

```bash
# Classic style
if [ $# -lt 3 ]; then
# Or arithmetic comparison
if (( $# < 3 )); then
```

## Finding out where a command is coming from

```bash
$ # type and which will show you where a command is coming from,
$ # type includes aliases and builtins while which does not, with
$ # the -a switch it shows all instead of stopping at first found
$ type -a cd
$ which -a cat
```

## apropos returns results from man pages

```bash
$ apropos delete
```

## Show file information

```bash
$ file name.txt
$ stat name.txt
```

## umask stuff

```bash
$ # Show defualt file permissions, bit on means does not get
$ umask 0027
$ # Change mask so that everyone gets read and execute but not write
$ umask 0022
```

## fetchmail forward to dburger@camberhawaii.org every 5 minutes from dburger account at ip

```bash
$ fetchmail -d 300 --smtpname dburger@camberhawaii.org -p POP3 -u dburger 172.16.100.7
```

## git stuff

```bash
$ # Checkout a git repo
$ git clone ssh://git.camberhawaii.org/var/data/repos/first.git
$ # Make a local branch also remote
$ git push origin local-branch-name
$ # git pull multiple projects under the current directory
$ for dir in */; do (cd "$dir" && git pull) done
```

## mail with sendmail compatible send

```bash
$ mail -s 'pagemon report' to@addr.com -- -F'David J. Burger' --ffrom@addr.com
$ # Don't send if body empty via -E
$ somecmd | mail -E -s "the subject" addr@com.com
```

## Simplest loop

```bash
$ for i in *; do ....; .....; done
```

## find operations

```
$ # Remove files from a directory older than 30 days
$ find /home/you/backup/ -mtime +30 -exec rm {} \;
$ # List files modified 1 or fewer days ago
$ find . -type f -mtime -1
$ # List files modified 5 or fewer minutes ago
$ find . -type f -mmin -5
$ # Prune a path from a find before the rest of the matching
$ find . -path ./review -prune -o -name "*java"
```

## Template for executing multiple commands with find

```bash
find . -type f | while read $file; do
  echo "$file"
 # do lots o stuff
done
```

## Sort a CSV file by a column, here by column 7

```
$ sort -t',' -k 7 hotspot-list2.txt  > foo.txt
```

## chown a symlink, pass -h

```
$ chown -h user:group symlink
```

## Email a picture to your flickr addr

```bash
(cat description.txt; uuencode laura.jpg laura.jpg) | mail -s 'subject' flickraddr@photos.flickr.com
```

## Checkout every revision of a file from subversion

```bash
svn log -q ./src/java/com/bigtribe/sync/adapter/SimpleCsvReader.java | \
    grep "^r[0-9]\+ " | awk '{ print substr($1, 2) }' | \
    while read rev; do svn cat -r $rev src/java/com/bigtribe/sync/adapter/SimpleCsvReader.java > $rev.txt; done
```

## awk stuff

```bash
$ # awk to print second column identify longest line
$ awk 'BEGIN {FS=","}; {print $2}' hotspot-list2.txt | wc -L
$ # awk to pull ip address from box
$ ifconfig | grep 'Bcast' | awk '{print $2' | awk 'BEGIN {FS=":"} ; {print $2}'
$ # Produce average from stream
$ grep "^110513 04.*Task completed in" gse.log | \
> sed 's/^.*Task completed in \([0-9]*\) .*$/\1/' | \
> awk '{total+=$1; count+=1} END {print total/count}'
$ # Undo changes to .json repo files that are staged
$ git status | grep json | awk '{print $2}' | xargs git checkout
```

## Change jpg to pdf using ImageMagick

```bash
$ convert page1.jpg -compress jpeg page1.pdf
```

## Batch resize and compress images

This will attempt to keep aspect ratio# unless you add a ! to the
end of the dimensions:

```bash
$ mogrify -resize 1024x1024 -quality 75 *JPG
```

## Merge pdfs using ghostscript

```bash
$ gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
> -sOutputFile=out.pdf page1.pdf page2.pdf
```

## Show systems IP address

```bash
$ # Old way
$ ifconfig
$
$ # New way
$ ip addr show
$ ip addr show eth0
```

## Set up ethernet card from command line

```bash
$ sudo ifconfig eth0 netmask 255.255.255.0 72.235.74.144
$ route add default gw 72.235.74.1
$ sudo ifconfig eth0 up
```

## set up a tunnel, local box listening on lport hitting rport on tohost, through throughhost

```
$ ssh -L  lport:tohost:rport throughhost
```

## netcat stuff

```bash
$ # send through netcat
$ tar cvf  - * | nc target 12345
$ # receive through netcat
$ nc -lp 12345 | tar xvf -
```

## iptables port forwarding

```bash
$ # Cause hit to port 80 to hit 9080 with iptables
$ sudo iptables -t nat -A OUTPUT -d 127.0.0.1 -p tcp --dport 80 -j REDIRECT --to-port 9080
$ # and port 443 to 9443
$ sudo iptables -t nat -A OUTPUT -d 127.0.0.1 -p tcp --dport 443 -j REDIRECT --to-port 9443
$ # On OS X using firewall rules having 80 hit 9080
$ ipfw add 100 fwd 127.0.0.1,9080 tcp from any to any 80 in
```

## Andy's port forwarding with xinetd setup:

```bash
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
```

## Remote X11 execution

```bash
$ ssh -X -Y -C dburger@uhunix.its.hawaii.edu emacs
```

## Generate self signed cert

```bash
$ openssl req -new -x509 -days 30 \
> -keyout /etc/apache2/conf/ssl.key/server.key \
> -out /etc/apache2/conf/ssl.crt/server.crt \
> -subj '/CN=Test-Only Certificate'
```

## Notifications on the gnome desktop

```bash
$ notify-send -i info -t 3000 "don't do that"
```

## Regular expression comparison in bash

```bash
if [[ "Hour 1276625700" =~ ^Hour\ [0-9]+$ ]]; then
  echo "matched"
else
  echo "nomatch"
fi
```
## Glob pattern match with [[

```bash
if [[ "${MYFILE}" == *.jpg ]]; then
```

## Negation of regular expression comparison in bash

```bash
if [[ ! "Hour 1276625700" =~ ^Hour\ [0-9]+$ ]]; then
  echo "nomatch"
else
  echo "matched"
fi
```

## Cronjob examples

```bash
# Make a backup at 4:20 am everyday with rsync via cron
20 4 * * * rsync -av --delete /usr/local/google/git/eye3 /home/dburger/bak
## Scrape with curl and mail
30 9 * * * curl http://eye3-analysis/varz | grep "\(\(g\|p\)4.*invocations\)\|\(sccs.*\)" | sed -e 's/<b>//g;s/<\/b>//g;s/<br>//g' | mail -s "SCCS Stats - example script harvested output" recipient@foo.com
```

## Loop against some database machines collecting some information, here executing mysql

```bash
for host in agpq14 bfgd20 iaco20 ynoo20 ynpp21 ynqq20 ynrr17 ynss21; do
  ssh root@$host "mysql -u user -ppassword database -e 'SHOW SLAVE STATUS\G' | grep Seconds_Behind_Master"
done
```

## Second looping against remote machines example

```bash
for host in agpq14 bfgd20 iaco20 ynoo20 ynpp21 ynqq20 ynrr17 ynss21; do
  ssh root@$host "mysql -u user -ppassword database -e 'CHECKSUM TABLE IdSequences'"
done
```

## Determine the log file a process is writing to, first determine the pid, then

```bash
$ lsof -p pid | grep log
```

## Using dot to draw a directed graph

Given the input file, piping through tred would give you a transitive reduction

```bash
$ cat input.dot
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
```

## Grep for counts of event during each 10 minute time frame in the 1 am hour

```bash
$ for x in 0 1 2 3 4 5; do grep "^110520 03:${x}.*Task completed" gse.log  | wc -l; done
```

## Show the lines common to file1 and file2

```bash
comm -12 <(sort file1) <(sort file2)
```

# Handling spaces in file names when piping from find to xargs

```bash
$ # Causes null terminated separation, either way
$ find . -name "*.foo" -print0 | xargs --null ls -l
$ find . -name "*.foo" -print0 | xargs -0 ls -l
```

## example one line while

```bash
$ while true; do ls; echo "sleeping"; sleep 5; done
$ # or similar
$ while :; do ls; echo "sleeping"; sleep 5; done
```
## Launch screen changing activation key to C-\ instead of C-a

```bash
$ screen -e ^\\\\\\
```

## Create a navigable master document from several markdown files

```bash
$ pandoc -st html5 --toc --section-divs -o /home/dburger/www/out.html *markdown
```

## Tail, but instead of how many tail lines to show, what line to start at

```bash
$ tail +100 file.txt
```

## xargs stuff

```bash
$ # xargs for parallel execution, 1 argument to each invocation, 15 threads
$ cat input | xargs -n 1 -P 15 doit.sh
$ # xargs as non tail argument
$ cat input | xargs -I '{}' cmd --foo='{}' --bar=baz
$ # xargs one arg at a time, 40 threads, on a randomized file
$ sort -R leftovers | xargs -n 1 -P 40 -I '{}' ms delete_rows --ns=eye3.prod --table=PositionsV2 --key='{}'
```

## Here documents

```bash
# Using a here document as data in a script
grep $1 <<EOF
EOF
# Prevent shell expansion in a here document, add a slash
<<\EOF
EOF
# allow tab indent in here document, use the minus
<<-EOF
EOF
```

## User input

```bash
$ # Read with a prompt
$ read -p "What is your name?" NAME
$ # read with prompt suppress echo
$ read -sp "What is your name?" NAME
# select for multiple choice input
select foo in $list; do
  if [ $foo = "whatever"]
    ...
    break;
done
```

## Reading from stdin with a read loop

```bash
#!/usr/bin/env bash

# Invoke as $0 < something.txt

while read -r line; do
  echo "${line}"
  # ...
done
```

## Using read and the IFS to "split"

```bash
value='world/wide'
IFS='/'
read -r -a values <<< "${value}"
location="${values[0]}"
region="${values[1]}"
```

## Process control

```bash
$ # When you run a process in the background you get a process number and pid
$ foo &
[1] 8970
$ # The process number can be used to bring the process to the foreground
$ fg 1
$ # Send a foreground process to the background with CTRL-Z,
$ # then bring it back
$ fg 1
$ # Launch a detached process using nohup
$ nohup longproc &
```

## if conditional grep command output

```bash
if grep -q needle <<< $(curl http://what.com); then
  echo "Found the needle!"
else
  echo "Didn't find the needle!"
fi
```

## Parameter expansion

```bash
$ # Return value or default if not set
$ PATH=${1:-/tmp}
$ # Assign and return if not set or empty
$ ${HOME:=/tmp}
$ # Assign and return if not set
$ ${HOME=/tmp}
$ # null command can be used with variable setting parameter expansions
$ : ${FOO:=doggy}
```

## Integer math, two ways

```bash
$ X=(( COUNT * 3 ))
$ let X=COUNT*3
```

# while loops

```bash
# Arithmetic
while (( COUNT < MAX )); do
# filetest
while [ -z "${FILE}" ]; do
# read
while read A B; do
```

# Will parse out according to separator, putting all remaining
# in last (Y)

```bash
$ ls -l | while read X Y; do echo $X; done
```

# Read a string separating by newlines

```bash
while IFS= read -r path; do
  echo "We got a line with ${path}"
done <<< "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}"
```

# for loops

```bash
$ for ((i=0; i<10; i++)); do something; done
$ for i in $(seq 1.0 .01 1.1); do something; done
$ seq 1.0 .01 1.1 | while read i; do something; done
$ for i in {1..12}; do something; done
$ until [ ]; do something; done
```

## Special invocations

```bash
$ # invoke command foo with argument bar suppressing function lookup
$ command foo bar
$ # invoke shell built in without command look up
$ builtin cd ~/foo
```

# wait, without id

If wait is not given an id, it waits for all currently active
child processes to finish

```bash
whatever &
another &
wait
```

## Date stuff


```bash
$ # Dump seconds since epoch at beginning of given date
$ date -d "$yea/$month/$day" +%s
$ # with dashes
$ date +%F
$ # Get epoch seconds for time in LA timezone
$ date --date='TZ="America/Los_Angeles" 2019-11-15 06:59:19' +%s
```

## Example worker script

```bash
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
```

## Inline array creation and iteration

```bash
repos=(
    "repo1"
    "repo2"
    "repo3"
)

for repo in "${repos[@]}"; do
  echo "${repo}"
  # ...
done
```

## Bash arrays iterative additions

```bash
$ x=(something)
$ x+=(another)
$ # As a single word expansion
$ echo "${x[*]}"
$ # when within quotes the prior is a single word, this is separate words
$ echo "${x[@]}"
```

## Execute on each found file, one at a time

```bash
$ find . -name '*sh' -exec et {} \;
# same as
$ find . -name '*.sh' | xargs et
```

## Execute on each found file, passing all at once

```bash
$ find . -name '*sh' -exec et {} +
$ # same as
$ find . -name '*.sh' | xargs -n 1 et
```

## Escaping shell arugments

Since single quotes escape everything replace each ' with '\'' and then
surround entire argument with single quotes. Example:

```bash
\000\377\$Ux&foo<boo'hi\323 becomes '\000\377\$Ux&foo<boo'\''hi\323'
```

## What imports are used among several different files?

```bash
$ grep -h import | sort -u
```

## What is listening / running on ports...

```bash
$ netstat -tulpn
$
$ # What is running on port 8080?
$ netstat -t | grep 8080
```

# Combination command for work

*   resolve the servers
*   take fields 2 and 3
*   replace space with colon
*   write out a file to rpcget the protostatusz

```bash
$ lockserv resolveall /abns/docs/kix-scary-canary.frontend | cut -d' ' -f2,3 | sed -e 's/ /:/' | xargs -I '{}' echo "rpcget http://{}/protostatusz?messages&mode=proto" > foo.txt
```

## nmcli stuff

```bash
$ nmcli device wifi list
$ nmcli device wifi connect pookie5g -a
$ nmcli -f name -t connection show --active
```

## File system stuff

```bash
$ # Show file system usage disk space usage
$ df -HT
$ df -ah
$
$ # Show disks
$ fdisk -l
$
$ # Size of directory's contents
$ du -sh dir/
```

# Change delimiter in sed, when address is first start with backslash

```bash
$ find . -name BUILD | xargs sed -i '\|foo|d'
```

## sed examples

```bash
$ # rename a bunch of files from a prefix + number to just the number
$ ls QuizUI_* | sed 's/Quiz\(UI_[0-9][0-9]\.png\)/mv Quiz\1 \1/' | sh
$ # chop up a web page changing a <option> list into a couple of columns
$ sed -e 's/<option value=\(....\)>\(.*\)/put(\1, "\2");/g' countries.txt
$ # in place edit with backup remove single space in CSV column
$ sed -i[bak] -e 's/, ,/,,/g' hotspot-list2.txt
$ # recursive in place edit, no backup, of X with Y, grep is better here than find
$ grep -rl 'X' | xargs sed -i 's/X/Y/g'
$ # another fancy rename making *-consolidated.xls consolidated-*.xls
$ ls *consolidated.xls | sed 's/\(.*\)-consolidated.xls/mv \0 consolidated-\1.xls/' | sh
$ # remove from { to } in a text file spanning multiple lines, used to clean up
$ # an informix DDL for usage with SQL Server, derived from sed one liners page
$ sed -e ':a;s/{[^}]*}//g;/{/N;/{/ba' input.ddl
$ # output lines from line 1 to line 1000 to a file
$ sed -n '1,1000 p' file > output
$ # what? why not just
$ head -1000
$ # output a range of a file turning on with first regex and off with second
$ sed -n '/Starting analysis mailing.*30379003/,/Completed analysis mailing.*30379003/p' gse.log-2010_11_17_19_11_46
$ # add line numbers to the output and then dump the range
$ cat -n foo.txt | sed -n "/start/,/finish/p"
$ # sed delete bash style comments and blank lines
$ sed "s/\s*#.*//g; /^$/d" file.txt
$ # sed example large in place edit
$ grep -rlI "import com.google.monitoring.eye3.common.persistence.Datastores" . | xargs sed -i 's/import com.google.monitoring.eye3.common.persistence.Datastores/import com.google.monitoring.eye3.persistence.Datastores/'
$ # sed example delete matching lines
$ find . -name BUILD | xargs sed -i '/ui:mock/d'
$ # sed delete matching lines in place
$ find . -name BUILD | xargs sed -i '/"\/\/java\/com\/google\/monitoring\/eye3\/model\/validation"/d'
$ # example bulk import change with sed, will leave .BAK backup files
$ find . -name "*java" | xargs grep -l "com\.google\.gwt\.event\.shared\.SimpleEventBus" | xargs sed -i.BAK 's/com\.google\.gwt\.event\.shared\.SimpleEventBus/com.google.web.bindery.event.shared.SimpleEventBus/'
```

## Generating random numbers

```bash
$ # Between 0 and 32767
$ echo $RANDOM
$ # In a range using a modulus
$ echo $(( RANDOM % 100 ))
```
## select 100 random lines of a file via a random sort

```bash
sort -R file | head -100
```

## Shuffling a file, or generating random numbers

```bash
$ # Just shuffle the lines of a file
$ shuf file.txt
$ # Only take ten lines of the file
$ shuf file.txt -n 10
$ # Shuffle a range of numbers instead
$ shuf -i 10-20
$ # Just take one of the range
$ shuf -i 1000-2000 -n 1
$ # Take ten samples and allow repeats
$ shuf -i 1-20 -n 10 -r
```
## Run a command after debian package update

Add a post-invoke hook in the right location:

```bash
echo "post-invoke='sudo -u $USER dmenu_path > /dev/null'" > /etc/dpkg/dpkg.cfg.d/dmenu-path-update-hook
```

## Run a command when files change

Install [entr](http://entrproject.org) and then:

```bash
$ find . -name '*star' | entr ./regenerate_configs.sh
```

## etags stuff

```bash
$ # generate TAG file with exuberant etags recursively from the current directory
$ # ignoring directories starting with blaze
$ # (note, "sudo apt-get install exuberant-ctags", this is not standard
$ #  etags / ctags syntax)
$ ctags --exclude=blaze* -e -R .
```
## jq JSON parsing magic

```bash
$ # For each element under the top level configs key,
$ # process it only if .id.name is charlie,
$ # then output its .guide.children property
$ jq '.configs[] | select(.id.name == "charlie") | .guide.children' file.json
$
$ # Select top level key "master" and output its configs property
$ jq '.["master"].configs' file.json
$
$ # Output the .foo.bar and .status fields, followed by a record separator, used as pipe
$ some fetch | jq '.foo.bar, .status, "=========="'
$
$ # For each element under top level builderConfigs key, run the select
$ # which will output a new array of the elements that matched. Here only
$ # one would in theory match and its .general.critical value would be
$ # output.
$ jq ".builderConfigs | map(select(.id.name == \"grunt-cq\"))[0].general.critical" file.json
```

## Change line input to comma separated

```bash
# With xargs and sed:
$ cat input.txt | xargs echo | sed -e 's/ /,/g'
# With paste,
# -s for serial, one file at a time, and -d to change the 
# delimiter to a comma.
$ cat input.txt | paste -sd ,
```

## Execute command for each line of a file

```bash
$ while read url; do   youtube-dl "${url}"; done <playlist.txt
```

Many other possibilities described [here](https://stackoverflow.com/questions/13939038/how-do-you-run-a-command-for-each-line-of-a-file).
