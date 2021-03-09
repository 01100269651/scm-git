
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.SP_PM_SO_GEN;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure SP_PM_SO_GEN'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--DROP PROC  SP_PM_SO_GEN       
                          
CREATE PROC SP_PM_SO_GEN(@TRANS_DATE1 DATETIME)                               
                       
AS                                    
           
           
 BEGIN           
                        
	DECLARE 			                                  
		@FACT				DEC(2,0) ,                                  
                                                
  		@SUP_ID			DEC(10,0) ,                                      
                  
		@SERIAL_NO 			NUMERIC(6) ,                   
    				           
		@DATENOW			DATE   ,        
        
                @FACT2                     	DEC(2,0) ,         
         
                @T_ID                     	 DEC(2,0) ,        
        
                @T_TEXT                    	 VARCHAR(100)        
           
SELECT @DATENOW=GETDATE()       
				                       
  DECLARE		 CUR_GEN_SO	 CURSOR  FOR                                                   
                                 
	SELECT	 DISTINCT FACT_ID , SUP_ID           
                
	FROM    PM_ORDER_ITEMS_OFFERS               
                        
	WHERE  PM_ORDER_ITEMS_OFFERS.TRAN_DATE=@TRANS_DATE1     AND FLAG=1           
                  
	FOR READ ONLY                                                  
                                                          
	OPEN CUR_GEN_SO           
         
	FETCH CUR_GEN_SO INTO                                    
				                
				@FACT,           
                            
				@SUP_ID                                 
                                                
               
     DELETE  FROM SCM_PM_SO WHERE SO_DATE= @DATENOW           
      
SELECT @SERIAL_NO=ISNULL(MAX(SO_ID),0) FROM SCM_PM_SO         
      
      
                        
      
WHILE @@SQLSTATUS !=2                        
                   
 BEGIN      
SELECT @SERIAL_NO= @SERIAL_NO +1 	       
---------------------------------------------------------------               
INSERT  INTO SCM_PM_SO(FACT_ID,SO_ID,SO_DATE,SUPP_ID) VALUES (@FACT,@SERIAL_NO,@DATENOW,@SUP_ID)                                 
         
----------------------------------------------------------------------------        
------------------------------------------------------------------------------        
   
 DECLARE		 CUR_TERM_INS	 CURSOR  FOR                                                   
                                 
	SELECT	 FACT_ID , TERM_ID,TERM_TEXT           
                
	FROM    SCM_TERMS        
                          
	FOR READ ONLY                                                  
                
OPEN CUR_TERM_INS        
        
FETCH CUR_TERM_INS INTO        
        
@FACT2 ,@T_ID,@T_TEXT        
        
DELETE FROM SCM_SO_TERMS WHERE TERM_DATE=@TRANS_DATE1   
  
WHILE @@SQLSTATUS !=2         
        
BEGIN        
        
INSERT INTO SCM_SO_TERMS(FACT_ID,TERM_ID,TERM_TEXT,SO_ID,SO_DATE,TERM_DATE)        
        
VALUES (@FACT2,@T_ID,@T_TEXT,@SERIAL_NO,@DATENOW,@DATENOW)        
        
FETCH CUR_TERM_INS INTO	                   
				                  
				@FACT2 ,@T_ID,@T_TEXT				                               
     
 END          
        
IF  @@ERROR =0                                                  
                                            
                    COMMIT                                                    
                                            
                    ELSE                                                  
                                            
       BEGIN                                                  
                                            
                        ROLLBACK                                                  
                                            
                        RAISERROR 200013 'TRY AGAIN'                                                  
                                            
                        END            
        
	CLOSE  CUR_TERM_INS         
                                            
       DEALLOCATE CURSOR  CUR_TERM_INS         
  
------------------------------------------------------------------------------        
---------------------------------------------------------------------------------        
          
                 
FETCH CUR_GEN_SO INTO	                   
				                  
				@FACT	,                                  
				@SUP_ID					                               
                  
               
 END          
		                        
IF  @@ERROR =0                                                  
                                            
                    COMMIT                                                    
                                            
                    ELSE                                                  
                                            
       BEGIN                                                  
                                            
                        ROLLBACK                                                  
                                            
                        RAISERROR 200013 'TRY AGAIN'                                                  
                                            
                        END            
        
        
                                            
	CLOSE  CUR_GEN_SO            
                                            
       DEALLOCATE CURSOR  CUR_GEN_SO            
       
		                           
RETURN                           
                   
END                                                                                                         
                                                                                                            
go 


sp_procxmode 'SP_PM_SO_GEN', unchained
go 

setuser
go 

