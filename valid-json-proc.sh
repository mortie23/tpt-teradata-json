#!/bin/bash
## Author:  Christopher Mortimer
## Date:    2020-06-09
## Desc:    The log file is a file that contains many valid JSON rows
##          To read this into a Teradata table they should be split into a JSON file per row
## Usage:   ./valid-json-proc.sh <test,prod>
## Example: ./valid-json-proc.sh test

## Include the echolog function
. echolog.sh

## Read in argument as log filename
env=${1}
## Clear the proc directory before a run
rm data/${env}/proc/*.json
echoLog "INFO" "files deleted: data/${env}/proc/*.json"
## Clear file if exists or create if not
:> data/${env}.csv
echoLog "INFO" "file reset: data/${env}.csv"

for filenm in data/${env}/*.log; do
  filenmNoPath=${filenm##*/}
  echoLog "INFO" "${filenmNoPath}"
  ## Set the iterator
  i=1
  ## Loop over lines in file
  while read -r line; do
    ## Write each line to a new file
    echo $line > ./data/${env}/proc/${filenmNoPath}_${i}.json;
    ## Build the txt file listing the files and filenames
    echo ${i},${env},${filenmNoPath},data/${env}/proc/${filenmNoPath}_${i}.json >> data/${env}.csv
    ## Inrement
    i=$((i+1))
  done < ${filenm}
  i=$((i-1))
  echoLog "INFO" "${i} lines parsed"
done

# TODO: Need a way to eliminate the long JSON coming through in tdx field e.g. the pre-canned table for "groups":["APP-XA_SPX_WEB"]
