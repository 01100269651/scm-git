-- master.factor_no =CONVERT(CHAR(2),@FACT)  
/*This operation is being done in a transaction.     
Please ensure that in case of error the transaction is rolled back.*/    
    
/*This operation is being done in a transaction.      
Please ensure that in case of error the transaction is rolled back.*/     
     
--drop procedure dbo.SP_ORDER_CALC2     
     
--DROP PROC SP_ORDER_CALC2       
                 
                 
		CREATE PROCEDURE  SP_ORDER_CALC2                     
                 
		(@DATE_EDIT DATETIME)                      
                 
                 
		AS                      
                 
		BEGIN                   
                     
		DECLARE 	       
       
				@FACT					DEC(2,0),        
	                        
				@ORD_ID					 DEC(8,2),                      
                 
				@DATE_WRITE				 DATETIME ,                       
		                 
				@SANF_ID 					CHAR(9) ,             
       
				@TYPE						CHAR(4),       
       
				@SER						DEC(2,0),                  
                 
				@QTY_R  					DECIMAL(13,4) ,                        
                 
				@REC_DATE 					DATETIME ,                  
                 
				@REC_ID			    		VARCHAR(10) ,               
               
				@SUP_NAME					VARCHAR(100),               
				               
				@PRICE						DEC(13,2) ,            
		     				          
           
				@OUTCOME1					DEC(13,2) ,           
           
 				@OUTCOME2					DEC(13,2) ,          
           
				@OUTCOME3					DEC(13,2) ,       
    
                @CONS1						DEC(13,2),        
     
				@CONS1_EQ					DEC(13,2),           
          
				@CONS2						DEC(13,2),        
     
				@CONS2_EQ					DEC(13,2),        
          
				@CONS3						DEC(13,2),          
     
				@CONS3_EQ					DEC(13,2),          
          
				@CONS4						DEC(13,2) ,         
     
				@CONS4_EQ					DEC(13,2) ,         
         
				@REQ_YR_CONS				DEC(13,2)         
          
          
           
           
   -- DECLARE CUSOR TO SELECT ALL ITEMS FROM DM_ORDER_ITEMS_IC       
                 
	DECLARE		 CUR_ORDER_ITEMS		 CURSOR FOR                        
                 
				SELECT DM_ORDER_ITEMS_IC.FACT_ID,       
       
				 DM_ORDER_ITEMS_IC.ORD_ID,                         
                 
				DM_ORDER_ITEMS_IC.ORD_DATE,       
				       
				DM_ORDER_ITEMS_IC.TYPE,       
                 
				DM_ORDER_ITEMS_IC.SER,                        
        
				DM_ORDER_ITEMS_IC.ITM_ID                        
                 
				FROM DM_ORDER_ITEMS_IC        
                 
				WHERE DM_ORDER_ITEMS_IC.ORD_DATE = @DATE_EDIT      AND TYPE IN ("1","2")                   
                 
				FOR READ ONLY             
       
                               
				OPEN  CUR_ORDER_ITEMS       
                 
				FETCH CUR_ORDER_ITEMS  INTO  @FACT, @ORD_ID , @DATE_WRITE ,@TYPE,@SER,@SANF_ID        
                       
			                      
			                      
				WHILE @@SQLSTATUS !=2                          
	        BEGIN                  
            
            
			   -- Calculate the OUTCOME of the item from master table             
            
				 SELECT @OUTCOME1= isnull(master.ein_qty,0) + isnull(master.out_qty,0)           
				              
 				from master            
				            
				 WHERE             
            
				    master.item_no   = @SANF_ID  and  master.factor_no =CONVERT(CHAR(2),@FACT)  
         
  			                     
				          
          
				SELECT @OUTCOME2= isnull(SUM(transactions.trans_qty) ,0)           
				              
 				from transactions            
				            
				  where              
            
				  transactions.item_no   =  @SANF_ID            
            
				  and    transactions.tran_cd   in ( '3','2')    and       transactions.factor_no =CONVERT(CHAR(2),@FACT)  
 
            
	            
            		 SELECT @OUTCOME3=@OUTCOME1+ @OUTCOME2          
          
         
-------------- CALCULATE QUANTITY OF PREVIOUS YEAR          
         
          
			SELECT @CONS2= isnull(SUM(history.htrans_qty) ,0)           
				              
 				from history  ,stores_save                
				            
				  where              
            
				  history.hitem_no   =  @SANF_ID            
            
				  and    history.htran_cd =  '3'        and  history.hfactor_no =CONVERT(CHAR(2),@FACT)  
          
				  and  history.htran_date between '2019-07-01' AND '2020-06-30'       and   stores_save.store_no =history.hstore_no and   stores_save.kind_code=1  
      
    
-------------------------    
SELECT @CONS2_EQ= isnull(SUM(history.htrans_qty) ,0)           
				              
 				from history   ,stores_save                       
				            
				  where              
            
				  history.hitem_no   =  @SANF_ID            
            
				  and    history.htran_cd =  '4'           and  history.hfactor_no =CONVERT(CHAR(2),@FACT)  
          
				  and  history.htran_date between '2019-07-01' AND '2020-06-30'           and   stores_save.store_no =history.hstore_no and   stores_save.kind_code=1  
  
    
    
  SELECT @CONS2 = @CONS2 -  @CONS2_EQ        
          
	-------------- CALCULATE QUANTITY OF  previous PREVIOUS YEAR          
          
			SELECT @CONS3= isnull(SUM(history.htrans_qty) ,0)           
				              
 				from history    ,stores_save                      
				            
				  where              
            
				  history.hitem_no   =  @SANF_ID            
            
				  and    history.htran_cd    =  '3'            and  history.hfactor_no =CONVERT(CHAR(2),@FACT)  
          
				  and  history.htran_date BETWEEN '2018-07-01' AND '2019-06-30'  and   stores_save.store_no =history.hstore_no and   stores_save.kind_code=1  
         
    
----------------------------------------    
    
	SELECT @CONS3_EQ= isnull(SUM(history.htrans_qty) ,0)           
				              
 				from history    ,stores_save                             
				            
				  where              
            
				  history.hitem_no   =  @SANF_ID            
            
				  and    history.htran_cd    =  '4'            and  history.hfactor_no =CONVERT(CHAR(2),@FACT)  
          
				  and  history.htran_date BETWEEN '2018-07-01' AND '2019-06-30'    and   stores_save.store_no =history.hstore_no and   stores_save.kind_code=1       
          
	SELECT @CONS3 = @CONS3 -  @CONS3_EQ   		    
	          
   -------------- CALCULATE QUANTITY OF PREVIOUS  previous PREVIOUS YEAR          
       
			SELECT @CONS4= isnull(SUM(history.htrans_qty) ,0)           
				              
 				from history    ,stores_save                             
				            
				  where              
            
				  history.hitem_no   =  @SANF_ID            
            
				  and    history.htran_cd    =  '3'             and  history.hfactor_no =CONVERT(CHAR(2),@FACT)  
          
				  and  history.htran_date BETWEEN '2017-07-01' AND '2018-06-30'    and   stores_save.store_no =history.hstore_no and   stores_save.kind_code=1             
          
      ------------------------------    
    
SELECT @CONS4_EQ= isnull(SUM(history.htrans_qty) ,0)           
				              
 				from history   ,stores_save                                     
				            
				  where              
            
				  history.hitem_no   =  @SANF_ID            
            
				  and    history.htran_cd    =  '4'             and  history.hfactor_no =CONVERT(CHAR(2),@FACT)  
          
				  and  history.htran_date BETWEEN '2017-07-01' AND '2018-06-30'  and   stores_save.store_no =history.hstore_no and   stores_save.kind_code=1                   
          
     SELECT @CONS4 = @CONS4 -  @CONS4_EQ      
			--- Calculate the sum of the total quantity required from the DM_ORDER_ITEMS_IC        
         
			         
   			SELECT 	@REQ_YR_CONS= isnull(SUM(DM_ORDER_ITEMS_IC .QTY) ,0)           
				              
 				FROM DM_ORDER_ITEMS_IC        
				            
				  WHERE   DM_ORDER_ITEMS_IC .ITM_ID =  @SANF_ID            
             
				               
				BEGIN                   
         
		-- begin block of updating the DM_ORDER_CALC       
				               
				 UPDATE DM_ORDER_CALC       
                 
		 		 SET  DM_ORDER_CALC.TOT_QTY_REQ=@REQ_YR_CONS          
                 
				WHERE (DM_ORDER_CALC.ORD_ID=@ORD_ID AND                       
                 
				DM_ORDER_CALC.ORD_DATE=@DATE_EDIT AND                       
                 
				DM_ORDER_CALC.ITM_ID=@SANF_ID )                    
         
         
         
               
				-- begin block of updating the orders table               
				               
				 UPDATE DM_ORDER_CALC       
                 
		 		 SET  DM_ORDER_CALC.CONS1=@OUTCOME3          
                 
				WHERE (DM_ORDER_CALC.ORD_ID=@ORD_ID AND                       
                 
				DM_ORDER_CALC.ORD_DATE=@DATE_EDIT AND                       
                 
				DM_ORDER_CALC.ITM_ID=@SANF_ID )                    
          
          
			 UPDATE DM_ORDER_CALC       
                 
		 		 SET DM_ORDER_CALC.CONS2=@CONS2          
                 
				WHERE (DM_ORDER_CALC.ORD_ID=@ORD_ID AND                       
                 
				DM_ORDER_CALC.ORD_DATE=@DATE_EDIT AND                       
                 
				DM_ORDER_CALC.ITM_ID=@SANF_ID )              
          
          
          
			       UPDATE DM_ORDER_CALC       
                 
		 		 SET  DM_ORDER_CALC.CONS3=@CONS3          
                 
				WHERE (DM_ORDER_CALC.ORD_ID=@ORD_ID AND                       
                 
				DM_ORDER_CALC.ORD_DATE=@DATE_EDIT AND                       
                 
				DM_ORDER_CALC.ITM_ID=@SANF_ID )                    
          
				          
          
				  UPDATE DM_ORDER_CALC       
                 
		 		 SET  DM_ORDER_CALC.CONS4=@CONS4          
                 
				WHERE (DM_ORDER_CALC.ORD_ID=@ORD_ID AND                       
                 
				DM_ORDER_CALC.ORD_DATE=@DATE_EDIT AND                       
                 
				DM_ORDER_CALC.ITM_ID=@SANF_ID )                    
            
				                  
		  END                    
		 		              
				FETCH CUR_ORDER_ITEMS  INTO  @FACT, @ORD_ID , @DATE_WRITE ,@TYPE,@SER,@SANF_ID        
                
				                
				END                   
                 
                 
		 IF  @@ERROR =0                       
                 
                    COMMIT                         
                 
                	    ELSE                       
        	         
		       BEGIN                       
                 
                        ROLLBACK                       
                 
                        RAISERROR 200013 'TRY AGAIN'                       
                 
                        END                        
                 
		 CLOSE  CUR_ORDER_ITEMS         
                 
             DEALLOCATE CUR_ORDER_ITEMS         
			                       
			 END