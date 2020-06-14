-- Author:  Christopher Mortimer
-- Date:    2020-06-10
-- Desc:    A view layer that parses out the JSON into a relational table

-- Test parsing out the JSON values for entire table
REPLACE VIEW PRD_ADS_HWD_WDAPGRP_DB.STR_AUDIT_LOG_V AS
SELECT
  CAST((date '1970-01-01' + A.epochts/86400) AS TIMESTAMP(0)) + (A.epochts MOD 86400) * INTERVAL '00:00:01' HOUR TO SECOND AS timest
  , A.*
FROM (
	SELECT  
	  id_col
	  , env
    , filename
	  , CAST(SUBSTR(T.JSON_DATA.JSONEXTRACTVALUE('$.time'),1,10) AS bigint) AS epochts
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.ipAddress') AS ipAddress
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.action') AS action
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.duration') AS duration
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.source') AS source
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.user') AS usernm
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.groups[0]') AS groups
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.hostname') AS hostname  
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.jobUuid') AS jobUuid
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.thread') AS thread
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.txdId') AS txdId
	  --, T.JSON_DATA.JSONEXTRACTVALUE('$.txd') AS txd
	  , 'too long' AS txd
	FROM 
	  PRD_ADS_HWD_WDAPGRP_DB.STR_AUDIT_LOG T
	WHERE
	  not (T.JSON_DATA.JSONEXTRACTVALUE('$.groups[0]') = 'APP-XA_SPX_WEB' 
	      and T.JSON_DATA.JSONEXTRACTVALUE('$.action') = 'query')
	union all
	SELECT  
	  id_col
	  , env
	  , filename
	  , CAST(SUBSTR(T.JSON_DATA.JSONEXTRACTVALUE('$.time'),1,10) AS bigint) AS epochts
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.ipAddress') AS ipAddress
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.action') AS action
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.duration') AS duration
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.source') AS source
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.user') AS usernm
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.groups[0]') AS groups
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.hostname') AS hostname  
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.jobUuid') AS jobUuid
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.thread') AS thread
	  , T.JSON_DATA.JSONEXTRACTVALUE('$.txdId') AS txdId
	  , 'too long' AS txd
	FROM 
	  PRD_ADS_HWD_WDAPGRP_DB.STR_AUDIT_LOG T
	WHERE
	  (T.JSON_DATA.JSONEXTRACTVALUE('$.groups[0]') = 'APP-XA_SPX_WEB' 
	      and T.JSON_DATA.JSONEXTRACTVALUE('$.action') = 'query')
	) A
;