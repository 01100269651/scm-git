
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.ORDER_TRANSFER;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure ORDER_TRANSFER'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--DROP PROC  ORDER_TRANSFER                 
               
CREATE PROC  ORDER_TRANSFER   (@DATE_DAY DATETIME)                   
                 
AS                              
       
BEGIN                       
        
               
	DECLARE 			                
				@FACT						DEC(2,0) ,                
               
				@MDEPT						DEC(2,0) ,                
               
				@DEPT						DEC(3,0) ,                
               
				@ORD_DATE					DATETIME ,               
               
				@TITLE 						VARCHAR(100) ,               
               
				@CAUSE						VARCHAR(100) ,               
               
				@ORD_ID					    DEC(8,2) ,                    
               
 				@TYPE						CHAR(4) ,                          
				               
				@FIN_DATE					DATETIME ,               
               
				@FIN_ID 					NUMERIC(8,0),               
               
				@L_ID						NUMERIC(8,2),               
               
				@PRJCT						NUMERIC(15,0),               
               
				@REQ_REP					VARCHAR(100),               
               
				@UMDEPT 					NUMERIC(2,0),               
               
				@UDEPT 					    NUMERIC(3,0),               
               
				@STAT 						NUMERIC(1,0),               
               
				@SER						NUMERIC(3,0) ,               
               
				@ITM_GRP					CHAR(3),               
											               
				@SANF_ID 					CHAR(9) ,               
               
				@PART_NO					CHAR(12) ,               
               
				@NO_IN_SRV                 			NUMERIC(8,0),               
               
				@QTY_R  					DECIMAL(13,4) ,                                
               
				@UNT_ID					NUMERIC(3,0),               
               
				@DW_ID						VARCHAR(20) ,               
               
				@BALANCE					DEC(13,4)   ,                   
                   
				@CONS1						DEC(13,4) ,                   
                   
 				@CONS2						DEC(13,4)  ,                  
                   
				@CONS3						DEC(13,4)  ,               
               
				@CONS4						DEC(13,4)  ,               
               
				@REC_ID			    		VARCHAR(10) ,               
                         
				@REC_DATE 					DATETIME ,                          
                         
				@SUP_NAME					VARCHAR(100) ,                       
				                       
				@PRICE						DEC(13,4) ,               
               
				@CURR						DEC(2,0) ,               
               
				@MACH_CODE				CHAR(9)               
		                    
                          
	DECLARE		 CUR_ORDERS_TRANS	 CURSOR FOR                                 
                      
               
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
                      
         DM_ORDER_IC.MACHINE_CODE,   	                        
               
	 DM_ORDER_IC.UMDEPT_ID,                  
               
         DM_ORDER_IC.UDEPT_ID,                 
               
	 DM_ORDER_IC.STATE_CODE,                
               
         DM_ORDER_ITEMS_IC.SER,                  
               
         DM_ORDER_ITEMS_IC.ITM_ID,                  
               
         DM_ORDER_ITEMS_IC.ITM_GRP,                  
               
         DM_ORDER_ITEMS_IC.PART_NO,                  
               
         DM_ORDER_ITEMS_IC.NO_IN_SERVICE,                  
               
         DM_ORDER_ITEMS_IC.QTY,                  
               
         DM_ORDER_ITEMS_IC.UNIT_CODE,                  
               
         DM_ORDER_ITEMS_IC.DRAWING_NO,                  
               
         DM_ORDER_CALC.BALANCE,                  
               
    	DM_ORDER_CALC.CONS1,                  
               
         DM_ORDER_CALC.CONS2,                  
               
         DM_ORDER_CALC.CONS3,                  
               
         DM_ORDER_CALC.CONS4 ,                  
               
	DM_ORDER_CALC.SUP_NAME, 	               
               
         DM_ORDER_CALC.REC_ID,                  
               
         DM_ORDER_CALC.REC_DATE,                  
               
         DM_ORDER_CALC.PRICE,                  
               
         DM_ORDER_CALC.CURRENCY                 
               
	FROM DM_ORDER_CALC,                  
               
         DM_ORDER_IC ,                  
               
         DM_ORDER_ITEMS_IC                 
               
   	 WHERE ( DM_ORDER_CALC.FACT_ID = DM_ORDER_IC.FACT_ID ) and                 
               
         ( DM_ORDER_ITEMS_IC.FACT_ID = DM_ORDER_CALC.FACT_ID ) and                 
               
         ( DM_ORDER_IC.ORD_ID = DM_ORDER_ITEMS_IC.ORD_ID ) and                 
               
	 ( DM_ORDER_IC.ORD_ID = DM_ORDER_CALC.ORD_ID ) and                 
               
         ( DM_ORDER_ITEMS_IC.TYPE = DM_ORDER_IC.TYPE ) and                 
               
         ( DM_ORDER_IC.TYPE = DM_ORDER_CALC.TYPE ) and                 
               
         ( DM_ORDER_IC.ORD_DATE = DM_ORDER_CALC.ORD_DATE ) and                 
               
         ( DM_ORDER_IC.ORD_DATE = DM_ORDER_ITEMS_IC.ORD_DATE ) and                 
               
         ( DM_ORDER_ITEMS_IC.SER = DM_ORDER_CALC.SER )   AND               
	               
	(DM_ORDER_IC.ORD_DATE=@DATE_DAY ) AND              
              
	(DM_ORDER_ITEMS_IC.ORD_DATE =@DATE_DAY ) AND               
              
	( DM_ORDER_CALC.ORD_DATE =@DATE_DAY )           AND  (DM_ORDER_IC.UPD_FLAG <> 2)  
              
			               
		FOR READ ONLY                                
                                        
	OPEN CUR_ORDERS_TRANS               
                   
	FETCH CUR_ORDERS_TRANS INTO                  
				               
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
               
				@MACH_CODE        ,               
               
				@UMDEPT 		,                       
               
				@UDEPT 		,                       
               
				@STAT 			,                       
               
				@SER			,                       
               
				@SANF_ID 		,                       
											               
				@ITM_GRP	,                       
               
				@PART_NO		,                       
               
				@NO_IN_SRV         ,                       
               
				@QTY_R  		,                                
               
				@UNT_ID		,                       
               
				@DW_ID			,                       
               
				@BALANCE		,                   
                   
				@CONS1			,                           
                   
 				@CONS2			,                       
                   
				@CONS3			,                       
               
				@CONS4			 ,               
               
				@SUP_NAME		,               
                         
			      	@REC_ID		 ,                 
			               
				@REC_DATE 		,                      
				                       
				@PRICE			,               
               
				@CURR					               
                                
               
		WHILE @@SQLSTATUS !=2                                   
               
	             BEGIN   
               
INSERT INTO DM_ORDER_FINAL               
               
	( DM_ORDER_FINAL.FACT_ID,                  
               
         DM_ORDER_FINAL.MDEPT_ID,                  
               
         DM_ORDER_FINAL.DEPT_ID,               
                  
         DM_ORDER_FINAL.ORD_ID,                  
               
         DM_ORDER_FINAL.ORD_DATE,                
                 
         DM_ORDER_FINAL.TITLE,                  
               
         DM_ORDER_FINAL.CAUSE,                  
               
         DM_ORDER_FINAL.ORD_TYPE,                  
               
         DM_ORDER_FINAL.FIN_DATE,                  
               
         DM_ORDER_FINAL.FNL_ID,                  
               
         DM_ORDER_FINAL.LAST_ID,                  
               
         DM_ORDER_FINAL.PRJCT_ID,                  
               
         DM_ORDER_FINAL.UMDEPT_ID,                  
               
         DM_ORDER_FINAL.UDEPT_ID,                  
               
         DM_ORDER_FINAL.STATE_CODE,                  
               
         DM_ORDER_FINAL.SER,                  
               
         DM_ORDER_FINAL.ITM_ID,                  
               
         DM_ORDER_FINAL.ITM_GRP,                  
               
         DM_ORDER_FINAL.PART_NO,                  
               
         DM_ORDER_FINAL.NO_IN_SERVICES,                  
               
         DM_ORDER_FINAL.QTY,                  
               
         DM_ORDER_FINAL.UNIT_CODE,                  
               
         DM_ORDER_FINAL.BALANCE,                  
               
         DM_ORDER_FINAL.CONS1,                  
               
         DM_ORDER_FINAL.CONS2,                  
               
         DM_ORDER_FINAL.CONS3,                  
               
         DM_ORDER_FINAL.CONS4,                  
               
         DM_ORDER_FINAL.REC_ID,                  
               
         DM_ORDER_FINAL.REC_DATE,                  
               
         DM_ORDER_FINAL.PRICE,                  
               
         DM_ORDER_FINAL.CURRENCY,                  
               
         DM_ORDER_FINAL.SUP_NAME,               
               
	  DM_ORDER_FINAL.DW_ID                 
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
               
				@SER			,                       
               
				@SANF_ID		,                       
											               
				@ITM_GRP 		,                       
               
				@PART_NO		,                       
               
				@NO_IN_SRV         ,                       
               
				@QTY_R  		,                                
               
				@UNT_ID		,                       
               
			  	@BALANCE		,                   
                   
				@CONS1			,                           
                   
 				@CONS2			,                       
                   
				@CONS3			,                       
               
				@CONS4			 ,               
                         
			      	@REC_ID		 ,                 
			               
				@REC_DATE 		,                      
				                       
				@PRICE			,               
               
				@CURR			,               
               
				@SUP_NAME   ,               
               
				@DW_ID	  )               
            
     
             UPDATE  DM_ORDER_IC  
			  
			SET UPD_FLAG= 2  
				  
			WHERE FACT_ID=@FACT AND ORD_ID=@ORD_ID AND TYPE=@TYPE   
  
  
FETCH CUR_ORDERS_TRANS INTO	@FACT			 ,                
               
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
      
				@MACH_CODE        ,                 
               
				@UMDEPT 		,                       
               
				@UDEPT 		,                       
               
				@STAT 			,                       
               
				@SER			,                       
               
				@SANF_ID 		,                       
											               
			@ITM_GRP	,                       
               
				@PART_NO		,                       
               
				@NO_IN_SRV         ,                       
               
				@QTY_R  		,                                
               
				@UNT_ID		,                       
               
				@DW_ID			,                       
               
				@BALANCE		,                   
                   
				@CONS1			,                           
                   
 				@CONS2			,                       
                   
				@CONS3			,                       
               
				@CONS4			 ,               
               
				@SUP_NAME		,               
                         
			      	@REC_ID		 ,                 
			               
				@REC_DATE 		,                      
				                       
				@PRICE			,               
               
				@CURR               
          END   
               
		IF  @@ERROR =0                                
                          
                    COMMIT                                  
                          
                    ELSE                                
                          
       BEGIN                                
                          
                        ROLLBACK                                
                          
                        RAISERROR 200013 'TRY AGAIN'                                
                          
                        END                                 
            
	CLOSE  CUR_ORDERS_TRANS                
    
             DEALLOCATE CURSOR  CUR_ORDERS_TRANS                
         
RETURN         
    
END                                                                 
      
go 


sp_procxmode 'ORDER_TRANSFER', unchained
go 

setuser
go 

