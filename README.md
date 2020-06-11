# tpt-teradata-json

Load JSON to Teradata table using TPT.  

## Install and Software

What? 
1. MobaXterm
1. add PATH to your environment variable.
   1. Find the path of the Teradata binaries and add this line to your .bashrc  
   1. `vim ~/.bashrc`
   1. `i` to enter insert mode
   1. copy this to clipboard `export PATH=$PATH:"/drives/c/Program Files/Teradata/Client/15.10/bin"`
   1. `right click` to paste
   1. `ESC :wq ENTER` to exit vim

## Get the logs

From your SuperWeb2 server machine.  
Secure copy from remote webserver to local superserver.  

```sh
scp user@machine:/opt/STR/audit/2020-05-14-superweb2.log ~/
```

```sh
# For MobaXterm bash path
/drives/c/<repo>/audit-log/data/
# For Windows Path
U:\<repo>\audit-log\data\
```

## Valid JSON

You need to load files that have valid JSON.  The structure of the audit logs is was not valid JSON, each line is though.  
So there is a shell script that parses each line to a seperate file.  
This should be run in a local terminal (bash) session using MobaXterm.  

```sh
# Get into the path of the script
cd /drives/u/<repo>/audit-log/
./valid-json-proc.sh ./data/2020-05-14-superweb2.log
```

## Create your table

Run the `ddl.sql` file against your database (i.e. copy and paste code to Teradata Studio and run).  

## Run the TPT

Make a copy of the `loadJSON-jobvars-template.txt` file as `loadJSON-jobvars-<any-name>.txt`.  
You'll need to run a command like this (depending on what you called your jobvars file.  
`cmd /C tbuild -f loadJSON.tpt -v loadJSON-jobvars-all.txt`.  
This should load all the JSON to a Teradata table.  

![Log](img/tpt-log.png)

## Test the load

Copy and paste the `select-test.sql` scripts into Teradata Studio and run them.  
![Select Test](img/select-test.png)  
![Results](img/select-test-results.png)

## Notes

Usually you do not need `cmd /C to run a tbuild, but there is something strange in the Dept Health environment.  


