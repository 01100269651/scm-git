-- history.suppl_name <>"%?????%"      
     
--DROP PROC SP_ORDER_CALC1       
                
CREATE PROCEDURE SP_ORDER_CALC1                    
                
(@DATE_EDIT DATETIME)                     
                
                
AS                     
                
BEGIN                  
                    
	DECLARE 	       
       
				       
				@FACT							DEC(2,0),       
	                       
				@ORD_ID					    DEC(8,2),           
       
				@TYPE							CHAR(4),                 
       
				@SER							DEC(2,0),       
			       
                
				@DATE_WRITE				    DATETIME ,                      
		                
				@SANF_ID 					CHAR(9) ,                       
                
				@QTY_R  					DECIMAL(13,4) ,                       
                
				@REC_DATE 					DATETIME ,                 
                
				@REC_ID			    		VARCHAR(10) ,              
              
				@SUP_NAME					VARCHAR(100),              
				              
				@PRICE						DEC(13,4) ,           
		           
				@BALANCE					DEC(13,4)   ,          
          
				@INCOME1					DEC(13,4) ,          
          
 				@INCOME2					DEC(13,4) ,         
          
				@OUTCOME					DEC(13,4)          
       
DELETE FROM  DM_ORDER_CALC WHERE ORD_DATE=@DATE_EDIT       
-- DECLARE CUSOR TO SELECT ALL ITEMS FROM DM_ORDER_ITEMS_IC       
                
	DECLARE		 CUR_ORDER_ITEMS		 CURSOR FOR                       
                
				SELECT DM_ORDER_ITEMS_IC.FACT_ID,                        
                
				DM_ORDER_ITEMS_IC.ORD_ID,                       
       
				DM_ORDER_ITEMS_IC.ORD_DATE,                       
       
				DM_ORDER_ITEMS_IC.TYPE,                       
       
				DM_ORDER_ITEMS_IC.SER,                       
       
				DM_ORDER_ITEMS_IC.ITM_ID                       
                
				FROM DM_ORDER_ITEMS_IC       
                
				WHERE DM_ORDER_ITEMS_IC.ORD_DATE = @DATE_EDIT      AND TYPE IN("1","2")                  
                
				FOR READ ONLY            
       
                 
                       OPEN  CUR_ORDER_ITEMS       
                
				FETCH CUR_ORDER_ITEMS  INTO  @FACT, @ORD_ID , @DATE_WRITE ,@TYPE,@SER,@SANF_ID       
       
       
	WHILE @@SQLSTATUS !=2                         
	        BEGIN                 
           
           
			   -- Calculate the balance of the item from master table            
           
				 SELECT @INCOME1= isnull(master.ffirst_qty,0) + isnull(master.in_qty,0) - isnull(master.ein_qty,0) - isnull(master.out_qty,0) + isnull(master.eout_qty,0)            
				             
 				from master           
				           
				 WHERE            
           
				    master.item_no   = @SANF_ID         and  master.factor_no =CONVERT(CHAR(2),@FACT) 
           
			                
                      
			           
	       
   	SELECT @INCOME2= isnull(SUM(transactions.trans_qty) ,0)          
				             
 				FROM  transactions           
				           
				  WHERE              
           
				           
				  transactions.item_no   =  @SANF_ID           
           
				  and    transactions.tran_cd   in ( '1','4')           
           
           
				SELECT @OUTCOME= isnull(SUM(transactions.trans_qty) ,0)          
				             
 				from transactions           
				           
				  where             
           
				          
           
				  transactions.item_no   =  @SANF_ID           
           
				  and    transactions.tran_cd   in ( '3','2')           and  transactions.factor_no =CONVERT(CHAR(2),@FACT) 
 
           
	           
             SELECT @BALANCE =@INCOME1 + @INCOME2 - @OUTCOME          
          
           
           
		            -- CHECK IF THE ITEM HAS ANY RECORDS IN TRANSACTIONS TABLE             
             
			IF NOT EXISTS (SELECT 1 FROM transactions WHERE item_no=@SANF_ID AND trans_qty > 0 AND trans_val > 0 AND tran_cd = '1' )                
                
	  			                
				BEGIN                
           
    SELECT  @REC_DATE= NULL      
			                
			    -- NOW SELECT THE LATEST RECIVE DATE OF THE ITEM WHICH IS MAXIUMUM              
             
				SELECT  @REC_DATE= isnull(max(history.suppl_date),null)                     
                
				FROM history                      
                
		   		WHERE (( history.hitem_no = @SANF_ID ) AND                       
                
        					( history.htrans_qty > 0 ) AND                       
                
         					( history.htrans_val > 0 ) AND                       
                
         					( history.htran_cd = '1' )    and  history.hfactor_no =CONVERT(CHAR(2),@FACT) 
 
   /*  and (ascii(substring(history.suppl_name,1,1)) <>198 )       
			   
								 or  (ascii(substring(history.suppl_name,2,1)) <>165 )                   
				   
								 or  (ascii(substring(history.suppl_name,3,1)) <>210 )                   
   
								or  (ascii(substring(history.suppl_name,4,1)) <>222 )                   
   
								or  (ascii(substring(history.suppl_name,5,1)) <>233 )                 */  
   
    )     
			             
			             
			-- STEP 2 : SELECT NUMBER OF RECIVE ORDER BASED ON THE ABOVE DATE             
        SELECT  @REC_ID= ""				        
           
				SELECT  @REC_ID= ISNULL(history.suppl_no,"")      
                
				FROM history                      
                
		   		WHERE (( history.hitem_no = @SANF_ID ) AND                       
                
        		( history.htrans_qty > 0 ) AND                       
                
         		( history.htrans_val > 0 ) AND                       
                
         		( history.htran_cd = '1' ) and                  
                
				(history.suppl_date=@REC_DATE) )      and  history.hfactor_no =CONVERT(CHAR(2),@FACT) 
           
              
				-- STEP 3 : Get the supplier name               
											              
				SELECT  @SUP_NAME= history.suppl_name                      
                
				FROM history                      
                
		   		WHERE (( history.hitem_no = @SANF_ID ) AND                       
                
        		( history.htrans_qty > 0 ) AND                       
                
         		( history.htrans_val > 0 ) AND                       
                
         		( history.htran_cd = '1' ) and                  
                
				(history.suppl_date=@REC_DATE) )               and  history.hfactor_no =CONVERT(CHAR(2),@FACT) 
  
				              
				              
				 -- step 4 Get the price by deviding the total amount by the total value             
				              
				              
				SELECT  @PRICE= isnull(round((isnull(history.htrans_val,0) / isnull(history.htrans_qty,0) ),2),0)               
                
				FROM history                      
                
		   		WHERE (( history.hitem_no = @SANF_ID ) AND                       
                
        		( history.htrans_qty > 0 ) AND                       
                
         		( history.htrans_val > 0 ) AND                       
                
         		( history.htran_cd = '1' ) and                  
                
				(history.suppl_date=@REC_DATE) )        and  history.hfactor_no =CONVERT(CHAR(2),@FACT) 
          
				              
				 -- the end of the block if item not  exists in transactions             
				END                 
	 -- The other case if item exists in  transactions we get data from transactions table              
				              
				IF  EXISTS (SELECT 1 FROM transactions WHERE item_no=@SANF_ID AND trans_qty > 0 AND trans_val > 0 AND tran_cd = '1' )               
				              
				BEGIN              
				             
				            
				-- step 1 select maximum date of recieve orders              
				             
					SELECT  @REC_DATE= isnull(max(transactions.suppl_date),null)                     
                
				FROM transactions                      
                
		   		WHERE (( transactions.item_no = @SANF_ID ) AND                       
                
        		( transactions.trans_qty > 0 ) AND                       
                
         		( transactions.trans_val > 0 ) AND                       
                
         		( transactions.tran_cd = '1' )   and  transactions.factor_no =CONVERT(CHAR(2),@FACT) 
 
							/*	AND (ascii(substring(transactions.suppl_name,1,1)) <>198 )       
			   
								AND (ascii(substring(transactions.suppl_name,2,1)) <>165 )                   
				   
								AND (ascii(substring(transactions.suppl_name,3,1)) <>210 )                   
   
								AND (ascii(substring(transactions.suppl_name,4,1)) <>222 )                   
   
								AND (ascii(substring(transactions.suppl_name,5,1)) <>233 )                   
   
 */  
   
   
)                   
                 
	             
	             
			-- step 2 select  recieve orders id based on the above date             
			             
				SELECT  @REC_ID= ISNULL(transactions.suppl_no,"")                       
                
				FROM transactions                      
                
		   		WHERE (( transactions.item_no = @SANF_ID ) AND                       
                
        		( transactions.trans_qty > 0 ) AND                       
                
         		( transactions.trans_val > 0 ) AND                       
                
         		( transactions.tran_cd = '1' ) and                  
                
				(transactions.suppl_date=@REC_DATE) )       and  transactions.factor_no =CONVERT(CHAR(2),@FACT)        
				              
				              
				              
				 -- step 3 Get the supplier name             
				SELECT  @SUP_NAME=isnull( transactions.suppl_name,"")                      
                
				FROM transactions              
                
		   		WHERE (( transactions.item_no = @SANF_ID ) AND                       
                
        		( transactions.trans_qty > 0 ) AND                       
                
         		( transactions.trans_val > 0 ) AND                       
                
         		( transactions.tran_cd = '1' ) and                  
                
				(transactions.suppl_date=@REC_DATE) )             and  transactions.factor_no =CONVERT(CHAR(2),@FACT)    
				             
				             
				             
				-- step 4 Get items price             
				             
				SELECT  @PRICE= isnull(round((isnull(transactions.trans_val,0) / isnull(transactions.trans_qty,0) ),2),0)               
                
				FROM transactions                      
                
		   		WHERE (( transactions.item_no = @SANF_ID ) AND                       
                
        		( transactions.trans_qty > 0 ) AND                       
                
         		( transactions.trans_val > 0 ) AND                       
                
         		( transactions.tran_cd = '1' ) and                  
                
				(transactions.suppl_date=@REC_DATE) )                 and  transactions.factor_no =CONVERT(CHAR(2),@FACT) 
				              
				END              
				              
				             
				BEGIN                  
              
				-- begin block of updating the orders table           
       
       
INSERT INTO DM_ORDER_CALC(FACT_ID,ORD_ID,TYPE,ORD_DATE,SER,ITM_ID,BALANCE,REC_ID,REC_DATE,PRICE,SUP_NAME)        
VALUES (@FACT, @ORD_ID ,@TYPE , @DATE_WRITE,@SER,@SANF_ID,@BALANCE,@REC_ID,@REC_DATE,@PRICE,@SUP_NAME)       
       
							                 
				                 
			              
	         
              
                 
                 
				                 
		  END                   
		 		               
				FETCH CUR_ORDER_ITEMS INTO  @FACT, @ORD_ID , @DATE_WRITE ,@TYPE,@SER,@SANF_ID       
       
				               
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