## Name:    Echo Log
## Author:  Christopher Mortimer
## Date:    2019-05-20
## Desc:    Standard functions for use across all scripts
## Usage:   . commonFunctions.sh

## Echo a info log level message with the current time
## usage echoLog "<loglevel>" "<message>"
## where log level is [INFO,WARN,ERROR,etc]

logfile=./logs/log-`date +'%Y%m%d_%H%M%S'.log`
function echoLog() {
  logLevel=${1}
  message=${2}
  strdtm=`date +'%Y-%m-%d_%H:%M:%S'`
  echo "${logLevel}, ${strdtm}, func(${FUNCNAME[1]}), ${message}" |& tee -a ${logfile}
}