-- Test that the TPT load was successful
select *
from	XMLDEV.audit_log
;

-- Test parsing out the JSON keys for a single JSON row
SELECT 	
  CAST(JSONKEYS AS VARCHAR(100)) AS JSONKEYS
  , T.JSON_DATA.JSONEXTRACTVALUE('$.'||JSONKEYS) AS JSONVALUES
FROM 
  XMLDEV.AUDIT_LOG T
  , JSON_KEYS (
ON (
SELECT 
  JSON_DATA 
FROM 
  XMLDEV.AUDIT_LOG 
WHERE ID_COL=1
) USING QUOTES('N')
  ) AS JSON_DATA
WHERE 
  T.ID_COL=1
;

-- Test parsing out the JSON values for entire table
SELECT 	
  id_col
  , T.JSON_DATA.JSONEXTRACTVALUE('$.ipAddress') AS ipAddress
  , T.JSON_DATA.JSONEXTRACTVALUE('$.actionquery') AS actionquery
  , T.JSON_DATA.JSONEXTRACTVALUE('$.duration') AS duration
  , T.JSON_DATA.JSONEXTRACTVALUE('$.source') AS source
  , T.JSON_DATA.JSONEXTRACTVALUE('$.groups') AS groups
  , T.JSON_DATA.JSONEXTRACTVALUE('$.hostname') AS hostname  
  , T.JSON_DATA.JSONEXTRACTVALUE('$.ipAddress') AS ipAddress
  , T.JSON_DATA.JSONEXTRACTVALUE('$.jobUuid') AS jobUuid
  , T.JSON_DATA.JSONEXTRACTVALUE('$.thread') AS thread
  , T.JSON_DATA.JSONEXTRACTVALUE('$.time') AS timest
  --, T.JSON_DATA.JSONEXTRACTVALUE('$.txd') AS txd
FROM 
  XMLDEV.AUDIT_LOG T
;
