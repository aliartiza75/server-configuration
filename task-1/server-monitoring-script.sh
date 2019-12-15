#!/usr/bin/env bash

# $# show the number of cli arguments provides
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        declare $v="$2"
   fi
  # shift is a bash built-in which kind of removes arguments from the beginning of the argument list
  shift
done

OUTPUT_FILE=$HOME/$(date --utc +%Y-%m-%d-%H-%M-%S).log
echo "Data will be stored in ${OUTPUT_FILE} file" >> ${OUTPUT_FILE}

# ${0} shows the filename that is being executed
echo "Server Monitoring Script ${0} has been started" >> ${OUTPUT_FILE}

echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOWS AVAILABLE RAM" >> ${OUTPUT_FILE}
AVAILABLE_MEM=$(free -m | sed 's/|/ /' | awk '{print $7}' | sed -n '2p') >> ${OUTPUT_FILE}
bc -l <<< "scale=2; $AVAILABLE_MEM/1024" >> ${OUTPUT_FILE}

echo ""  >> ${OUTPUT_FILE}
echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOWS AVAILABLE CPU" >> ${OUTPUT_FILE}
echo CPU: `top -b -n2 | grep "Cpu(s)" | awk '{print  $8}'` >> ${OUTPUT_FILE}

echo ""  >> ${OUTPUT_FILE}
echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOWS DISK REMAINING" >> ${OUTPUT_FILE}
df | awk '{ SUM += $4} END { print SUM/1024/1024 }' >> ${OUTPUT_FILE}

echo ""  >> ${OUTPUT_FILE}
echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOWS TOP 5 PROCESSES FOR ROOT USER" >> ${OUTPUT_FILE}
ps -u root | sed -n '2,6p' >> ${OUTPUT_FILE}

echo ""  >> ${OUTPUT_FILE}
echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOWS PROCESSES WITH THEIR RESPECTIVE PORT" >> ${OUTPUT_FILE}
lsof -i | awk '{print $9}' >> ${OUTPUT_FILE}

echo ""  >> ${OUTPUT_FILE}
echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOW FILE SIZE IN MB IN DESCENDING ORDER" >> ${OUTPUT_FILE}
# /home/irti/Desktop/
# CAVEAT: As I have specified to show the files sizes in MB therefore some file sizes shown zero. 

# NOTE FS stands for file sizes
if [ "$FS" != "" ]; then
    echo "Positional parameter 1 contains something" >> ${OUTPUT_FILE}
    # du -amh /home/irti/Desktop/ | sort -n || true
    du -a --block-size=M $FS/. | sort -nr >> ${OUTPUT_FILE}
else
    echo "File sizes cannot be calculated because FS var value is empty" >> ${OUTPUT_FILE}  
fi

echo "" >> ${OUTPUT_FILE}
echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "SHOWS FOLDER SIZE IN MB IN DESCENDING ORDER" >> ${OUTPUT_FILE}
# NOTE DS stands for directory sizes
if [ "$DS" != "" ]; then
    du -sh --block-size=M $DS/*/ | sort -nr >> ${OUTPUT_FILE}
else
    echo "Directory sizes cannot be calculated because DS var value is empty" >> ${OUTPUT_FILE}  
fi

echo $(date --utc +%Y:%m:%d-%H:%M:%S:%Z) "Server Monitoring Script ${0} has been stopped" >> ${OUTPUT_FILE}