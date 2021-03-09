
-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'stock_dbase.dbo.SP_PM_OFFER_INS;1'
-----------------------------------------------------------------------------
print 'Creating Stored Procedure SP_PM_OFFER_INS'
go 

use stock_dbase
go 

setuser 'dbo'
go 

--DROP PROC  SP_PM_OFFER_INS     
                
CREATE PROC SP_PM_OFFER_INS(@TRANS_DATE1 DATETIME)                     
               
AS                          
                        
  BEGIN            
              
	DECLARE 			                        
				@FACT						DEC(2,0) ,                        
                                      
  				@TYPE						CHAR(4) ,             
     
				@ORD_ID					DEC(8,2) ,                            
                       
				@ORD_DATE					DATETIME,        
        
				@SER						NUMERIC(3,0) ,         
     
				@OFF_SER					NUMERIC(1,0) ,     
			      
				@SANF_ID 					CHAR(9) ,                                   
                      
				@QTY_REQ					NUMERIC(13,2),                      
											                      
				@SUP_ID1					NUMERIC(10,0),                      
                      
				@SUP_VALUE1				NUMERIC(15,2),                                       
     
				@TOTAL_VALUE1				NUMERIC(15,2),                                       
     
				@SUP_ID2					NUMERIC(10,0),                      
                      
				@SUP_VALUE2				NUMERIC(15,2),                                       
     
				@TOTAL_VALUE2				NUMERIC(15,2),                                       
     
				@SUP_ID3					NUMERIC(10,0),                      
                      
				@SUP_VALUE3				NUMERIC(15,2),                                       
     
				@TOTAL_VALUE3				NUMERIC(15,2),                                       
     
				@SUP_ID4					NUMERIC(10,0),                      
                      
				@SUP_VALUE4				NUMERIC(15,2),                                       
     
				@TOTAL_VALUE4				NUMERIC(15,2),                                       
     
				@SUP_ID5					NUMERIC(10,0),                      
                      
				@SUP_VALUE5				NUMERIC(15,2),                                       
     
				@TOTAL_VALUE5				NUMERIC(15,2),                                       
     
                 		@TRAN_DATE					DATETIME,     
     
				@TECH_FLAG1				NUMERIC(1,0)	,     
     
				@TECH_FLAG2				NUMERIC(1,0)	,     
     
				@TECH_FLAG3				NUMERIC(1,0)	,	        
     
				@TECH_FLAG4				NUMERIC(1,0)	,     
     
				@TECH_FLAG5				NUMERIC(1,0)	,     
     
				@UNIT_ID					NUMERIC(2,0)		,   
   
				@FFF				  	   NUMERIC(1,0)		   
	             
         DECLARE		 CUR_OFFERS_INS2	 CURSOR  FOR                                         
                       
	SELECT	 PM_ORDER_ITEMS_OFFERS_2.FACT_ID,                          
                       
         PM_ORDER_ITEMS_OFFERS_2.ORD_TYPE,              
        
	PM_ORDER_ITEMS_OFFERS_2.ORD_ID,                      
                  
	 PM_ORDER_ITEMS_OFFERS_2.ORD_DATE,        
     
	PM_ORDER_ITEMS_OFFERS_2.ITM_ID,      
                               
        PM_ORDER_ITEMS_OFFERS_2.ORD_SER,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.QTY_REQ,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.SUP_ID1,                        
		                       
	 PM_ORDER_ITEMS_OFFERS_2.SUP_VALUE1,                          
                       
         PM_ORDER_ITEMS_OFFERS_2.TOTAL_VALUE1,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.TECH_FLAG1,             
     
	 PM_ORDER_ITEMS_OFFERS_2.SUP_ID2,                        
		                       
	 PM_ORDER_ITEMS_OFFERS_2.SUP_VALUE2,                          
                       
         PM_ORDER_ITEMS_OFFERS_2.TOTAL_VALUE2,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.TECH_FLAG2,                          
     
	 PM_ORDER_ITEMS_OFFERS_2.SUP_ID3,                        
		                       
	 PM_ORDER_ITEMS_OFFERS_2.SUP_VALUE3,                          
                       
         PM_ORDER_ITEMS_OFFERS_2.TOTAL_VALUE3,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.TECH_FLAG3,                          
     
	 PM_ORDER_ITEMS_OFFERS_2.SUP_ID4,                        
		                       
	 PM_ORDER_ITEMS_OFFERS_2.SUP_VALUE4,                          
                       
         PM_ORDER_ITEMS_OFFERS_2.TOTAL_VALUE4,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.TECH_FLAG4,                          
     
	 PM_ORDER_ITEMS_OFFERS_2.SUP_ID5,                        
		                       
	 PM_ORDER_ITEMS_OFFERS_2.SUP_VALUE5,                          
                       
         PM_ORDER_ITEMS_OFFERS_2.TOTAL_VALUE5,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.TECH_FLAG5,                          
                       
	 PM_ORDER_ITEMS_OFFERS_2.UNIT_ID                      
              
	FROM    PM_ORDER_ITEMS_OFFERS_2     
              
	WHERE  PM_ORDER_ITEMS_OFFERS_2.ORD_DATE =@TRANS_DATE1      
        
	FOR READ ONLY                                        
                                                
	OPEN CUR_OFFERS_INS2     
                     
	FETCH CUR_OFFERS_INS2 INTO                          
				                       
				@FACT						,                        
                                      
				@TYPE						,        
     
				@ORD_ID					 ,                            
                       
 				@ORD_DATE					,             
				       
				@SANF_ID 					,        
      
				@SER						,        
                        
				@QTY_REQ  					,        
                      
				@SUP_ID1					,                      
                      
				@SUP_VALUE1				,                                       
     
				@TOTAL_VALUE1				,      
     
				@TECH_FLAG1                                ,      
     
				@SUP_ID2					,                      
                      
				@SUP_VALUE2				,                                       
     
				@TOTAL_VALUE2				,     
     
				@TECH_FLAG2                                ,      
     
				@SUP_ID3					,     
                      
				@SUP_VALUE3				,     
     
				@TOTAL_VALUE3				,     
     
				@TECH_FLAG3                                ,      
     
				@SUP_ID4					,     
                      
				@SUP_VALUE4				,     
     
				@TOTAL_VALUE4				,     
     
				@TECH_FLAG4                                ,      
     
				@SUP_ID5					,     
                      
				@SUP_VALUE5				,     
     
				@TOTAL_VALUE5				,     
     
				@TECH_FLAG5                             ,      
     
				    
				@UNIT_ID	   
   
									     
     
     DELETE  FROM PM_ORDER_ITEMS_OFFERS WHERE TRAN_DATE = @TRANS_DATE1                   
		              
WHILE @@SQLSTATUS !=2              
         
BEGIN                  
     
SELECT @SUP_ID1=ISNULL(@SUP_ID1,0)       
     
SELECT @SUP_VALUE1=ISNULL(@SUP_VALUE1,0)       
     
SELECT @TOTAL_VALUE1=ISNULL(@TOTAL_VALUE1,0)       
     
SELECT @TECH_FLAG1=ISNULL(@TECH_FLAG1,0)       
     
-----------------------------------     
     
SELECT @SUP_ID2=ISNULL(@SUP_ID2,0)       
     
SELECT @SUP_VALUE2=ISNULL(@SUP_VALUE2,0)       
     
SELECT @TOTAL_VALUE2=ISNULL(@TOTAL_VALUE2,0)       
     
SELECT @TECH_FLAG2=ISNULL(@TECH_FLAG2,0)       
     
-------------------------------------     
     
     
SELECT @SUP_ID3=ISNULL(@SUP_ID3,0)       
     
SELECT @SUP_VALUE3=ISNULL(@SUP_VALUE3,0)       
     
SELECT @TOTAL_VALUE3=ISNULL(@TOTAL_VALUE3,0)       
     
SELECT @TECH_FLAG3=ISNULL(@TECH_FLAG3,0)       
--------------------------------------------------     
     
SELECT @SUP_ID4=ISNULL(@SUP_ID4,0)       
     
SELECT @SUP_VALUE4=ISNULL(@SUP_VALUE4,0)       
     
SELECT @TOTAL_VALUE4=ISNULL(@TOTAL_VALUE4,0)       
     
SELECT @TECH_FLAG4=ISNULL(@TECH_FLAG4,0)       
     
----------------------------------------------------------                 
SELECT @SUP_ID5=ISNULL(@SUP_ID5,0)       
     
SELECT @SUP_VALUE5=ISNULL(@SUP_VALUE5,0)       
     
SELECT @TOTAL_VALUE5=ISNULL(@TOTAL_VALUE5,0)       
     
SELECT @TECH_FLAG5=ISNULL(@TECH_FLAG5,0)       
     
---------------------------------------------------------------     
   IF       @SUP_ID1<>0     
BEGIN    
    
INSERT INTO PM_ORDER_ITEMS_OFFERS(FACT_ID,ORD_TYPE,ORD_ID,ORD_DATE,ITM_ID,ORD_SER,OFFER_SER,QTY_REQ,SUP_ID,SUP_VALUE,TOTAL_VALUE,TECH_FLAG,TRAN_DATE,UNIT_ID)                       
VALUES (@FACT, @TYPE , @ORD_ID,   @ORD_DATE,   @SANF_ID 	,   @SER	, 1,  @QTY_REQ,  	@SUP_ID1, @SUP_VALUE1,@TOTAL_VALUE1,@TECH_FLAG1,@TRANS_DATE1,@UNIT_ID)                 
     
END     
    
   IF       @SUP_ID2<>0     
BEGIN    
    
INSERT INTO  PM_ORDER_ITEMS_OFFERS(FACT_ID,ORD_TYPE,ORD_ID,ORD_DATE,ITM_ID,ORD_SER,OFFER_SER,QTY_REQ,SUP_ID,SUP_VALUE,TOTAL_VALUE,TECH_FLAG,TRAN_DATE,UNIT_ID)                       
VALUES (@FACT, @TYPE , @ORD_ID,   @ORD_DATE,   @SANF_ID 	,   @SER	, 2,  @QTY_REQ,  	@SUP_ID2, @SUP_VALUE2,@TOTAL_VALUE2,@TECH_FLAG2,@TRANS_DATE1,@UNIT_ID)           
 END    
    
   IF       @SUP_ID3<>0     
BEGIN    
INSERT  INTO  PM_ORDER_ITEMS_OFFERS(FACT_ID,ORD_TYPE,ORD_ID,ORD_DATE,ITM_ID,ORD_SER,OFFER_SER,QTY_REQ,SUP_ID,SUP_VALUE,TOTAL_VALUE,TECH_FLAG,TRAN_DATE,UNIT_ID)                       
VALUES (@FACT, @TYPE , @ORD_ID,   @ORD_DATE,   @SANF_ID 	,   @SER	, 3,  @QTY_REQ,  	@SUP_ID3, @SUP_VALUE3,@TOTAL_VALUE3,@TECH_FLAG3,@TRANS_DATE1,@UNIT_ID)           
 END    
    
   IF       @SUP_ID4<>0     
BEGIN    
INSERT  INTO  PM_ORDER_ITEMS_OFFERS(FACT_ID,ORD_TYPE,ORD_ID,ORD_DATE,ITM_ID,ORD_SER,OFFER_SER,QTY_REQ,SUP_ID,SUP_VALUE,TOTAL_VALUE,TECH_FLAG,TRAN_DATE,UNIT_ID)                       
VALUES (@FACT, @TYPE , @ORD_ID,   @ORD_DATE,   @SANF_ID 	,   @SER	, 4,  @QTY_REQ,  	@SUP_ID4, @SUP_VALUE4,@TOTAL_VALUE4,@TECH_FLAG4,@TRANS_DATE1,@UNIT_ID)           
 END    
    
   IF       @SUP_ID5<>0     
BEGIN    
INSERT  INTO PM_ORDER_ITEMS_OFFERS(FACT_ID,ORD_TYPE,ORD_ID,ORD_DATE,ITM_ID,ORD_SER,OFFER_SER,QTY_REQ,SUP_ID,SUP_VALUE,TOTAL_VALUE,TECH_FLAG,TRAN_DATE,UNIT_ID)                       
VALUES (@FACT, @TYPE , @ORD_ID,   @ORD_DATE,   @SANF_ID 	,   @SER	,5,  @QTY_REQ,  	@SUP_ID5, @SUP_VALUE5,@TOTAL_VALUE5,@TECH_FLAG5,@TRANS_DATE1,@UNIT_ID)           
      END    
                            
   
   UPDATE PM_ORDER_ITEMS_OFFERS     
   
     SET FLAG = 1     
   
   WHERE PM_ORDER_ITEMS_OFFERS.SUP_VALUE in    
   
(SELECT min( PM_ORDER_ITEMS_OFFERS.SUP_VALUE) FROM PM_ORDER_ITEMS_OFFERS   
   
 GROUP BY PM_ORDER_ITEMS_OFFERS.FACT_ID, PM_ORDER_ITEMS_OFFERS.ORD_TYPE, PM_ORDER_ITEMS_OFFERS.ORD_ID, PM_ORDER_ITEMS_OFFERS.ITM_ID    )   
             
   
   
   
FETCH CUR_OFFERS_INS2 INTO	         
				        
				@FACT						,                        
                                      
				@TYPE						,        
     
				@ORD_ID					 ,                            
                       
 				@ORD_DATE					,             
				       
				@SANF_ID 					,        
      
				@SER						,        
                        
				@QTY_REQ  					,        
                      
				@SUP_ID1					,                      
                      
				@SUP_VALUE1				,                                       
     
				@TOTAL_VALUE1				,      
     
				@TECH_FLAG1                                ,      
     
				@SUP_ID2					,                      
                      
				@SUP_VALUE2				,                                       
     
				@TOTAL_VALUE2				,     
     
				@TECH_FLAG2                                ,      
     
				@SUP_ID3					,     
                      
				@SUP_VALUE3				,     
     
				@TOTAL_VALUE3				,     
     
				@TECH_FLAG3                                ,      
     
				@SUP_ID4					,     
                      
				@SUP_VALUE4				,     
     
				@TOTAL_VALUE4				,     
     
				@TECH_FLAG4                                ,      
     
				@SUP_ID5					,     
                      
				@SUP_VALUE5				,     
     
				@TOTAL_VALUE5				,     
     
				@TECH_FLAG5                                ,      
     
				@UNIT_ID					     
     
     
END                               
                       
		              
IF  @@ERROR =0                                        
                                  
                    COMMIT                                          
                                  
                    ELSE                                        
                                  
       BEGIN                                        
                                  
                        ROLLBACK                                        
                                  
                        RAISERROR 200013 'TRY AGAIN'                                        
                                  
                        END                                         
                                  
	CLOSE  CUR_OFFERS_INS2     
                                  
       DEALLOCATE CURSOR  CUR_OFFERS_INS2     
		                 
RETURN                 
         
END             
                                                                                                                                                                                                                                               
                                                                                                                              
go 


sp_procxmode 'SP_PM_OFFER_INS', unchained
go 

setuser
go 

