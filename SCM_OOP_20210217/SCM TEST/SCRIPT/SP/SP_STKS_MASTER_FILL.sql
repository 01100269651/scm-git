
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.SP_STKS_MASTER_FILL;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure SP_STKS_MASTER_FILL'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--  DROP PROC  SP_STKS_MASTER_FILL     
    
 CREATE PROC SP_STKS_MASTER_FILL     
     
AS    
     
     
 DELETE FROM STKS_MASTER    
      
COMMIT     
    
INSERT INTO STKS_MASTER(FACT_ID,STR_ID,ITM_ID,F_BAL_QTY ,F_BAL_VAL,SUP_QTY,SUP_VAL,ISSUED_QTY,ISSUED_VAL ,RED_SUP_QTY,RED_SUP_VAL,RED_ISSUED_QTY,RED_ISSUED_VAL,AVG_COST,NET_QTY,NET_VAL)     
SELECT convert(numeric(2,0),master.factor_no) ,master.store_no ,master.item_no,     
convert(numeric(13,2),master.ffirst_qty),     
convert(numeric(13,2),master.first_val),     
convert(numeric(13,2),master.in_qty),     
convert(numeric(13,2),master.in_val),     
convert(numeric(13,2),master.out_qty),     
convert(numeric(13,2),master.out_val),     
convert(numeric(13,2),master.ein_qty),     
convert(numeric(13,2),master.ein_val),     
convert(numeric(13,2),master.eout_qty),     
convert(numeric(13,2),master.eout_val),     
convert(numeric(15,0),master.average_cost),     
convert(numeric(13,2),master.net_qty),     
convert(numeric(13,2),master.net_val)     
from master     
     
COMMIT 
 
DELETE FROM STKS_ITM 
 
COMMIT 
 
INSERT INTO STKS_ITM(ITM_ID) 
 
SELECT item_no FROM items 
 
 
COMMIT                                                                                                                         
go 


sp_procxmode 'SP_STKS_MASTER_FILL', unchained
go 

setuser
go 

