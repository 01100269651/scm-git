
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.SP_PM_ORDER_ITEMS_TRANS;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure SP_PM_ORDER_ITEMS_TRANS'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--DROP PROC  SP_PM_ORDER_ITEMS_TRANS           
  
CREATE PROC SP_PM_ORDER_ITEMS_TRANS  (@TRANS_DATE DATETIME)                  
  
AS                          
  BEGIN         
           
	DECLARE 			                     
				@FACT						DEC(2,0) ,                     
                                   
				@ORD_ID					DEC(8,2) ,                         
                    
 				@TYPE						CHAR(4) ,          
				     
				@ORD_DATE					DATETIME,     
     
				@SER						NUMERIC(3,0) ,      
			   
				@SANF_ID 					CHAR(9) ,                                
                   
				@ITM_GRP					CHAR(3),                   
											                   
				@PART_NO					CHAR(12) ,                   
                   
				@NO_IN_SRV                 			NUMERIC(8,0),                   
                   
				@QTY_R  					DECIMAL(13,4) ,                                    
                   
				@UNT_ID					NUMERIC(3,0),                   
                   
				@DW_ID						VARCHAR(20)     
	  
           
DECLARE		 CUR_ORDERS_TRANS2	 CURSOR FOR                                      
                    
	SELECT DM_ORDER_ITEMS_IC.FACT_ID,                       
                    
         DM_ORDER_ITEMS_IC.ORD_ID,           
     
	DM_ORDER_ITEMS_IC.TYPE,                   
               
	 DM_ORDER_ITEMS_IC.ORD_DATE,     
                            
         DM_ORDER_ITEMS_IC.SER,                       
                    
	 DM_ORDER_ITEMS_IC.ITM_ID,                       
                    
	 DM_ORDER_ITEMS_IC.ITM_GRP,                     
		                    
	 DM_ORDER_ITEMS_IC.PART_NO,                       
                    
         DM_ORDER_ITEMS_IC.NO_IN_SERVICE,                       
                    
	 DM_ORDER_ITEMS_IC.QTY,                       
          
	 DM_ORDER_ITEMS_IC.UNIT_CODE,                       
                    
         DM_ORDER_ITEMS_IC.DRAWING_NO                     
                    
           
	FROM          DM_ORDER_ITEMS_IC , PM_ORDER     
           
WHERE  (PM_ORDER.FACT_ID =  DM_ORDER_ITEMS_IC.FACT_ID ) AND                      
                    
        (PM_ORDER.ORD_ID = DM_ORDER_ITEMS_IC.ORD_ID) AND             
     
	(PM_ORDER.TYPE = DM_ORDER_ITEMS_IC.TYPE)  AND     
               
	(PM_ORDER.ORD_DATE = DM_ORDER_ITEMS_IC.ORD_DATE) AND  (PM_ORDER.UPD_FLAG=2)     
     
           
FOR READ ONLY                                     
                                             
	OPEN CUR_ORDERS_TRANS2             
                  
FETCH CUR_ORDERS_TRANS2 INTO                       
				                    
				@FACT						,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,     
     
				@ORD_DATE					,          
				     
				@SER						,     
                   
				@SANF_ID 					,     
    
				@ITM_GRP					,     
                   
				@PART_NO					,     
                   
				@NO_IN_SRV                 			,     
                   
				@QTY_R  					,     
                   
				@UNT_ID					,     
                   
				@DW_ID						     
      			           
           
WHILE @@SQLSTATUS !=2           
      
BEGIN                   
           
INSERT INTO PM_ORDER_ITEMS           
                    
	(PM_ORDER_ITEMS.FACT_ID,                       
                                
        PM_ORDER_ITEMS.ORD_ID,            
     
	PM_ORDER_ITEMS.TYPE,                   
                    
        PM_ORDER_ITEMS.ORD_DATE,                     
                      
        PM_ORDER_ITEMS.SER,                       
                    
        PM_ORDER_ITEMS.ITM_ID,                       
                    
        PM_ORDER_ITEMS.ITM_GRP,                       
                    
        PM_ORDER_ITEMS.PART_NO,                       
                    
        PM_ORDER_ITEMS.NO_IN_SERVICE,                       
                    
        PM_ORDER_ITEMS.QTY,                       
                    
      	PM_ORDER_ITEMS.UNIT_CODE,     
	     
	PM_ORDER_ITEMS.DRAWING_NO     
)                    
                    
VALUES                     
(       			@FACT						,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,         
     
				@ORD_DATE					,      
				     
				@SER						,     
     
				@SANF_ID 					,     
                   
				@ITM_GRP					,     
						                   
 				@PART_NO					,     
                   
				@NO_IN_SRV                 			,     
                   
				@QTY_R  					,     
                   
				@UNT_ID					,     
                   
				@DW_ID						)        
  
INSERT INTO PM_ORDER_ITEMS_OFFERS_2  
(  
  
				FACT_ID,  
	  
				ORD_ID,  
  
				ORD_TYPE,  
  
				ORD_DATE,  
  
				ITM_ID,  
  
				ORD_SER,  
  
				QTY_REQ,  
	  
				UNIT_ID,  
  
				TRAN_DATE  
  
)  
            VALUES  
(  
				@FACT						,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,          
    
				@ORD_DATE					,    
  
				@SANF_ID 					,     
   
				@SER						,     
   
               			@QTY_R  					,  
  
				@UNT_ID					,		  
				  
				@TRANS_DATE 				  
  
)  
             
                    
FETCH CUR_ORDERS_TRANS2 INTO	      
				     
				@FACT						,                     
                                   
				@ORD_ID					 ,                         
                    
 				@TYPE						,          
    
				@ORD_DATE					,    
				     
				@SER						,     
   
               			@SANF_ID 					,     
   
				@ITM_GRP					,     
                   
				@PART_NO					,     
                   
				@NO_IN_SRV                 			,     
                   
				@QTY_R  					,     
                   
				@UNT_ID					,     
                   
				@DW_ID	     
      
END                            
                    
IF  @@ERROR =0                                     
                               
                    COMMIT                                       
                               
                    ELSE                                     
                               
       BEGIN                                     
                               
                        ROLLBACK                                     
                               
                        RAISERROR 200013 'TRY AGAIN'                                     
                               
                        END                                      
                               
	CLOSE  CUR_ORDERS_TRANS2                     
                               
        DEALLOCATE CURSOR  CUR_ORDERS_TRANS2                     
		              
RETURN              
  
END                                                                                                                                                                                                                                                             
  
go 


sp_procxmode 'SP_PM_ORDER_ITEMS_TRANS', unchained
go 

setuser
go 

