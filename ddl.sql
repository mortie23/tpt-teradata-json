-- Author:	Christopher Mortimer
-- Date:	2020-06-10
-- Desc:	Create audit table for loading with TPT script

DROP TABLE PRD_ADS_HWD_WDAPGRP_DB.STR_AUDIT_LOG;
CREATE TABLE PRD_ADS_HWD_WDAPGRP_DB.STR_AUDIT_LOG (
  ID_COL VARCHAR(100) 
  , ENV VARCHAR(4)
  , FILENAME VARCHAR(100)
  , JSON_DATA JSON (16776192)  
)
PRIMARY INDEX(ID_COL)
;