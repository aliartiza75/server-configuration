# Monitor Server resources

## Overview 

In this task I created a cronjob for monitoring the server resources.

## Server Monitoring Script

Server monitoring script perform following tasks:

    1. Total Ram available in GB

    2. Total CPUs available

    3. Total storage space available for all mount points

    4. List top 5 processes for root user 

    5. List the ports exposed and the process associate with it.

    6. For a given directory list the files with their size in (MBs), and sort them with descending order 

    7. For a given directory list the Folders with their size in (MBs), and sort them with descending order

Server monitoring script can be execued using the commands given below:

1. Before executing it make sure the script is in executable form. If it is not use the command given below:

```bash
chmod +x server-monitoring-script.sh
```

2. The server monitoring script can be executed using the command given below:

```bash

./server-monitoring-script.sh -FS <folder-path> -DS <folder-path>
```

In the above script:

1. FS(File Sizes): Provide the path of the folder for which files size needs to be calculated.

2. DS(Directory Sizes): Provide the path of the folder for which directory sizes needs to be calculated

It creates a log file in the `$HOME` directory. The name of the log file is in this format `YYYY-mm-dd-HH-MM-SS.log`

## Create a cronjob

Follow the guidelines given below to create a cronjob for server monitoring:

1. To edit the crontab file use the command given below:

```bash
$ crontab -e
```

2. Add the cron job

```bash
*/5 * * * * <path-to-server-monitoring-script> --FS <folder-path> --DS <folder-path>
```

save the file after adding the script.
 
## Refrences

1. https://unix.stackexchange.com/questions/69167/bash-script-that-print-cpu-usage-diskusage-ram-usage
2. https://unix.stackexchange.com/questions/129391/passing-named-arguments-to-shell-scripts
3. https://zxq9.com/archives/795
4. https://superuser.com/questions/322521/du-only-for-directories
5. https://serverfault.com/questions/144411/how-do-i-see-du-in-gb-instead-of-mb-in-linux 