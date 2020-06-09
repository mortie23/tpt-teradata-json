# tpt-teradata-json

Load JSON to Teradata table using TPT

## Install and Software

What? 
1. Teradata Tools and Utilities
1. A Teradata Database (Express VM or your own)

## Valid JSON

You need to load files that have valid JSON.  The structure I started with was not valid JSON, each line was though. So the shell script parses this to seperate files.  

## Create your table

Run the `ddl.sql` file against your database.  
Update the database schema first.  

## Run the TPT

Update the `loadJSON-jobvars-template.txt` file.
You'll need to run the command `tbuild -f loadJSON.tpt -v loadJSON-jobvars-all.txt`.  
This should load all the JSON to a Teradata table.

