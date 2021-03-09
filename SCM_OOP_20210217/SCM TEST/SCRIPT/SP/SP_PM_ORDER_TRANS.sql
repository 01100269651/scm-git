
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.SP_PM_ORDER_TRANS;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure SP_PM_ORDER_TRANS'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--DROP PROC  SP_PM_ORDER_TRANS        
        
        
CREATE PROC SP_PM_ORDER_TRANS        
        
(@TRANS_DATE DATETIME)               
         
AS                       
                  
  BEGIN      
        
	DECLARE 			                  
				@FACT						DEC(2,0) ,                  
                 
				@MDEPT						DEC(2,0) ,                  
                 
				@DEPT						DEC(3,0) ,                  
                 
				@ORD_DATE					DATETIME ,                 
                 
				@TITLE 						VARCHAR(100) ,                 
                 
				@CAUSE						VARCHAR(100) ,                 
                 
				@ORD_ID					DEC(8,2) ,                      
                 
 				@TYPE						CHAR(4) ,                            
				                 
				@FIN_DATE					DATETIME ,                 
                 
				@FIN_ID 						NUMERIC(8,0),                 
                 
				@L_ID						NUMERIC(8,2),                 
                 
				@PRJCT						NUMERIC(15,0),                 
                 
				@REQ_REP					VARCHAR(100),                 
                 
				@UMDEPT 					NUMERIC(2,0),                 
                 
				@UDEPT 					NUMERIC(3,0),                 
                 
				@STAT 						NUMERIC(1,0)                 
                  
        
DECLARE		 CUR_ORDERS_TRANS1	 CURSOR FOR                                   
                        
                 
	SELECT DM_ORDER_IC.FACT_ID,                    
                 
         DM_ORDER_IC.MDEPT_ID,                    
                 
         DM_ORDER_IC.DEPT_ID,                    
                 
         DM_ORDER_IC.ORD_DATE,                    
                 
         DM_ORDER_IC.TITLE,                    
                 
         DM_ORDER_IC.CAUSE,                    
	                 
         DM_ORDER_IC.ORD_ID,                    
                 
         DM_ORDER_IC.TYPE,                    
                 
	 DM_ORDER_IC.FNL_DATE,                    
                 
	 DM_ORDER_IC.FNL_ID,                  
		                 
	 DM_ORDER_IC.LAST_ID,                    
                 
         DM_ORDER_IC.PROJECT_ID,                    
                 
	 DM_ORDER_IC.REQUIRED_REP,                    
       
	 DM_ORDER_IC.UMDEPT_ID,                    
                 
         DM_ORDER_IC.UDEPT_ID,                   
                 
	 DM_ORDER_IC.STATE_CODE                  
              
	FROM          DM_ORDER_IC         
        
WHERE  DM_ORDER_IC.UPD_FLAG=2	        
        
FOR READ ONLY                                  
                                          
	OPEN CUR_ORDERS_TRANS1          
               
FETCH CUR_ORDERS_TRANS1 INTO                    
				                 
				@FACT ,                  
                 
				@MDEPT			,                         
                 
				@DEPT			,                          
                 
				@ORD_DATE		,                 
                 
				@TITLE 			,                 
                 
				@CAUSE			,                         
                 
				@ORD_ID		,                             
                 
 				@TYPE			,                                    
				                 
				@FIN_DATE		,                         
                 
				@FIN_ID 			,                         
                 
				@L_ID			,                         
                 
				@PRJCT			,                         
                 
				@REQ_REP		,                 
                 
				@UMDEPT 		,                         
                 
				@UDEPT 		,                         
                 
				@STAT 			                        
              			        
				        
        
        
WHILE @@SQLSTATUS !=2        
   
BEGIN                
        
INSERT INTO PM_ORDER        
                 
	(PM_ORDER.FACT_ID,                    
                 
         PM_ORDER.MDEPT_ID,                    
                 
         PM_ORDER.DEPT_ID,                 
                    
         PM_ORDER.ORD_ID,                    
                 
         PM_ORDER.ORD_DATE,                  
                   
         PM_ORDER.TITLE,                    
                 
         PM_ORDER.CAUSE,                    
                 
         PM_ORDER.TYPE,                    
                 
         PM_ORDER.FNL_DATE,                    
                 
         PM_ORDER.FNL_ID,                    
                 
         PM_ORDER.LAST_ID,                    
                 
         PM_ORDER.PROJECT_ID,                    
                 
         PM_ORDER.UMDEPT_ID,                    
                 
         PM_ORDER.UDEPT_ID,                    
                 
         PM_ORDER.STATE_CODE,                    
                 
      	PM_ORDER.UPD_FLAG ,    
        
	PM_ORDER.TRANS_DATE        
)                 
                 
VALUES                  
(                 
				@FACT			 ,                  
                 
				@MDEPT			,                         
                 
				@DEPT			,                          
			                 
				@ORD_ID 		,                 
                 
				@ORD_DATE		,                 
                 
				@TITLE 			,                 
                 
				@CAUSE			,                         
                 
 				@TYPE			,                                    
				                 
				@FIN_DATE		,                         
                 
				@FIN_ID 			,                         
                 
				@L_ID			,                         
                 
				@PRJCT			,                         
                 
				@UMDEPT 		,                         
                 
				@UDEPT 		,                         
                 
				@STAT 			,                         
                 
				  2 ,    
			      
				GETDATE() 	)                 
  
  
UPDATE DM_ORDER_IC   
		  
		SET DM_ORDER_IC.UPD_FLAG=3  
		  
		WHERE DM_ORDER_IC.UPD_FLAG=2 AND DM_ORDER_IC.FACT_ID=@FACT AND DM_ORDER_IC.TYPE=@TYPE AND DM_ORDER_IC.ORD_ID=@ORD_ID  
              
          
                 
FETCH CUR_ORDERS_TRANS1 INTO	 @FACT			 ,                  
                 
				@MDEPT			,                         
                 
				@DEPT			,                          
                 
				@ORD_DATE		,                 
                 
				@TITLE 			,                 
                 
				@CAUSE			,                         
                 
				@ORD_ID		,                             
                 
 				@TYPE			,                                    
				                 
				@FIN_DATE		,                         
                 
				@FIN_ID 			,                         
                 
				@L_ID			,                         
                 
				@PRJCT			,                         
                 
				@REQ_REP		,               
        
				@UMDEPT 		,                         
                 
				@UDEPT 		,                         
                 
				@STAT 			   
   
END                         
                 
		        
IF  @@ERROR =0                                  
                            
                    COMMIT     
			                                 
                            
                    ELSE                                  
                            
       BEGIN                                  
                            
                        ROLLBACK                                  
                            
                        RAISERROR 200013 'TRY AGAIN'                                  
                            
                        END                                   
                            
	CLOSE  CUR_ORDERS_TRANS1                  
                            
             DEALLOCATE CURSOR  CUR_ORDERS_TRANS1                  
  
  
	  
RETURN           
   
END       
			                          	        
       
                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                            
go 


sp_procxmode 'SP_PM_ORDER_TRANS', unchained
go 

setuser
go 

