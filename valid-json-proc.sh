#!/bin/bash
## Author:  Christopher Mortimer
## Date:    2020-06-09
## Desc:    The log file is a file that contains many valid JSON rows
##          To read this into a Teradata table they should be split into a JSON file per row
## Usage:   ./valid-json-proc.sh <logfile.log>

## Read in argument as log filename
logfile=${1}
echo ${logfile}
logFileNoPath=${logfile##*/}
## Clear txt file listing
rm ${logfile%.*}.txt

## Set the iterator
i=1
while read -r line
  do
    ## Write each line to a new file
    echo $line > ./data/proc/${logFileNoPath}_${i}.json;
    ## Build the txt file listing the files and filenames
    echo ${i},data/proc/${logFileNoPath}_${i}.json >> ${logfile%.*}.txt
    ## Inrement
    i=$((i+1))
  done < ${logfile}

  # TODO: Need a way to eliminate the long JSON coming through in tdx field e.g. the pre-canned table for "groups":["APP-XA_SPX_WEB"]
