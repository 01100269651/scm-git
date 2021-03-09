
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.SP_PM_ORDER_ITEMS_CALC_TRANS;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure SP_PM_ORDER_ITEMS_CALC_TRANS'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--DROP PROC  SP_PM_ORDER_ITEMS_CALC_TRANS    
           
           
CREATE PROC SP_PM_ORDER_ITEMS_CALC_TRANS  (@TRANS_DATE DATETIME)                  
            
AS                          
                     
  BEGIN         
           
	DECLARE 			                     
				@FACT						DEC(2,0) ,                     
                                   
				@ORD_ID					DEC(8,2) ,                         
                    
 				@TYPE						CHAR(4) ,          
				     
				@ORD_DATE					DATETIME ,     
     
				@SER						NUMERIC(3,0) ,      
			   
				@SANF_ID 					CHAR(9) ,                                
                   
				@BALANCE					DECIMAL(13,2) ,                                    
                   
				@CONS1						DECIMAL(13,2) ,                                    
                   
				@CONS2						DECIMAL(13,2) ,                                    
                   
				@CONS3						DECIMAL(13,2) ,                                    
                   
				@CONS4						DECIMAL(13,2) ,     
  
				@REC_ID					VARCHAR(10),  
  
				@REC_DATE					DATETIME,  
				  
				@PRICE						DECIMAL(13,2) ,     
                   
				@CUR						DECIMAL(2,0) ,                                    
                   
				@SUP_NAME					VARCHAR(100)     
				     
		     
				                    
               
                     
           
DECLARE		 	CUR_ORDERS_TRANS3	 CURSOR FOR                                      
                           
                    
	SELECT 		DM_ORDER_CALC.FACT_ID,                       
                    
         			DM_ORDER_CALC.ORD_ID,           
     
				DM_ORDER_CALC.TYPE,                   
               
	 			DM_ORDER_CALC.ORD_DATE,     
                            
     				DM_ORDER_CALC.SER,                       
                    
	 			DM_ORDER_CALC.ITM_ID,                       
                    
	 			DM_ORDER_CALC.BALANCE,                     
		                    
	 			DM_ORDER_CALC.CONS1,                       
  
				DM_ORDER_CALC.CONS2,  
  
				DM_ORDER_CALC.CONS3,  
  
				DM_ORDER_CALC.CONS4,  
                    
     				DM_ORDER_CALC.REC_ID,                       
                    
	 			DM_ORDER_CALC.REC_DATE,                       
          
	 			DM_ORDER_CALC.PRICE,                       
                    
    				DM_ORDER_CALC.CURRENCY ,  
  
				DM_ORDER_CALC.SUP_NAME  
                    
           
				FROM          DM_ORDER_CALC , PM_ORDER     
           
				WHERE  (PM_ORDER.FACT_ID =  DM_ORDER_CALC.FACT_ID ) AND                      
                    
        			(PM_ORDER.ORD_ID = DM_ORDER_CALC.ORD_ID) AND             
     
				(PM_ORDER.TYPE =DM_ORDER_CALC.TYPE)  AND     
               
				(PM_ORDER.ORD_DATE = DM_ORDER_CALC.ORD_DATE) AND  (PM_ORDER.UPD_FLAG=2)     
     
           
FOR READ ONLY                                     
                                             
	OPEN CUR_ORDERS_TRANS3             
                  
FETCH CUR_ORDERS_TRANS3 INTO                       
				                    
				@FACT						 ,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,          
				     
				@ORD_DATE					,     
     
				@SER						 ,      
			   
				@SANF_ID 					 ,                                
                   
				@BALANCE					,                                    
                   
				@CONS1						,  
                   
				@CONS2						,  
                   
				@CONS3						,  
                   
				@CONS4						,  
  
				@REC_ID					,  
  
				@REC_DATE					,  
				  
				@PRICE						,  
                   
				@CUR						,  
                   
				@SUP_NAME					  
           
           
WHILE @@SQLSTATUS !=2           
      
BEGIN                   
           
INSERT INTO PM_ORDER_ITEMS_CALC           
                    
				( PM_ORDER_CALC.FACT_ID,                       
                    
         			PM_ORDER_CALC.ORD_ID,           
     
				PM_ORDER_CALC.TYPE,                   
               
	 			PM_ORDER_CALC.ORD_DATE,     
                            
     				PM_ORDER_CALC.SER,                       
                    
	 			PM_ORDER_CALC.ITM_ID,                       
                    
	 			PM_ORDER_CALC.BALANCE,                     
		                    
	 			PM_ORDER_CALC.CONS1,                       
  
				PM_ORDER_CALC.CONS2,  
  
				PM_ORDER_CALC.CONS3,  
  
				PM_ORDER_CALC.CONS4,  
                    
     				PM_ORDER_CALC.REC_ID,                       
                    
	 			PM_ORDER_CALC.REC_DATE,                       
          
	 			PM_ORDER_CALC.PRICE,                       
                    
    				PM_ORDER_CALC.CURRENCY ,  
  
				PM_ORDER_CALC.SUP_NAME   )                    
                    
VALUES                     
  
				(@FACT						 ,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,          
				     
				@ORD_DATE					,     
     
				@SER						 ,      
			   
				@SANF_ID 					 ,                                
                   
				@BALANCE					,                                    
                   
				@CONS1						,  
                   
				@CONS2						,  
                   
				@CONS3						,  
                   
				@CONS4						,  
  
				@REC_ID					,  
  
				@REC_DATE					,  
				  
				@PRICE						,  
                   
				@CUR						,  
                   
				@SUP_NAME				)                    
                 
             
                    
FETCH CUR_ORDERS_TRANS3 INTO	      
				     
				@FACT						 ,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,          
				     
				@ORD_DATE					,     
     
				@SER						 ,      
			   
				@SANF_ID 					 ,                                
                   
				@BALANCE					,                                    
                   
				@CONS1						,  
                   
				@CONS2						,  
                   
				@CONS3						,  
                   
				@CONS4						,  
  
				@REC_ID					,  
  
				@REC_DATE					,  
				  
				@PRICE						,  
                   
				@CUR						,  
                   
				@SUP_NAME	  
      
END                            
                    
		           
			IF  @@ERROR =0                                     
                               
                    COMMIT                                       
                               
                    ELSE                                     
                               
      	 		BEGIN                                     
                               
                        ROLLBACK                                     
                               
                        RAISERROR 200013 'TRY AGAIN'                                     
                               
                        END                                      
                               
	CLOSE  CUR_ORDERS_TRANS3                     
                               
             DEALLOCATE CURSOR  CUR_ORDERS_TRANS3                     
		              
      
         
RETURN              
      
END          
			                          	           
          
      
                                                                                                                                                                                                                                               
go 


sp_procxmode 'SP_PM_ORDER_ITEMS_CALC_TRANS', unchained
go 

setuser
go 

