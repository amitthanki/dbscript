IF OBJECT_ID ('USP_BGP_UPD_RPR_Queue') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_UPD_RPR_Queue]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_UPD_FDR_Queue]    Script Date: 8/10/2017 11:51:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 08/10/2017
-- Modified By: 
-- Modification Date: 
-- Description: Update RPR Action Based on Queue.
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_UPD_RPR_Queue]
@GEN_QueueId bigint,
@CMSProcessDate Varchar(50),
@DispositionCode Varchar(50),
@DispositionCodeDescription Varchar(1000),
@TransactionTypeLkup  Varchar(10),
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN 
       BEGIN TRY
              BEGIN TRAN  
			                  DECLARE @PreviousActionLkup bigint
                              DECLARE @PreviousWorkQueueLkup bigint

					 --select cast(@DispositionCode as int)
					 IF (@DispositionCode = '123' OR @DispositionCode = '128'  OR @DispositionCode = '501' OR @DispositionCode = '503')
                         BEGIN
					           SET @DispositionCode = 26005  ---- FDR Status - Other					
				           END 
			        ELSE IF(@DispositionCode = '100' OR  (CONVERT(INT,@DispositionCode) >= 200 AND CONVERT(INT,@DispositionCode) <= 400) OR @DispositionCode ='515' OR  @DispositionCode ='516')
                         BEGIN
					           SET @DispositionCode = 26001  ---- FDR Status - Approved					
				           END 
					
				   ELSE IF (@DispositionCode = '401' OR @DispositionCode = '524' OR @DispositionCode = '500' OR  @DispositionCode = '504' OR @DispositionCode = '627' OR @DispositionCode = '505' OR @DispositionCode ='551' OR @DispositionCode = '506' OR @DispositionCode = '508' 
							OR @DispositionCode = '517' OR @DispositionCode = '527' OR @DispositionCode = '609' OR @DispositionCode = '529' OR @DispositionCode = '544' OR @DispositionCode =  '530' OR @DispositionCode = '532' OR @DispositionCode =  '533' 
							OR @DispositionCode =  '536' OR @DispositionCode = '603' OR @DispositionCode = '610' OR @DispositionCode = '537' OR @DispositionCode = '538' OR @DispositionCode = '539' OR @DispositionCode = '557'
							OR @DispositionCode = '541' OR @DispositionCode = '542' OR @DispositionCode = '543'
							OR @DispositionCode = '545' OR @DispositionCode = '554' OR @DispositionCode = '546' OR @DispositionCode = '605' OR @DispositionCode ='608' OR @DispositionCode = '612' OR @DispositionCode = '613' OR @DispositionCode = '625')
                         BEGIN
					           SET @DispositionCode = 26002  ---- FDR Status - Rejected					
				           END 
					Else
					     If(@DispositionCode != '' OR @DispositionCode IS NOT null)
						  BEGIN
					           SET @DispositionCode = 26005  ---- FDR Status - Other					
				           END 	
						   
						   Select @PreviousWorkQueueLkup = MostRecentWorkQueueLkup, @PreviousActionLkup = MostRecentActionLkup  from Gen_Queue Where GEN_QueueId =  @GEN_QueueId; 

                             Update GEN_RPRActions 
							 set   FDRStatusLkup   = @DispositionCode,
								   FDRCodeReceived = (select LookupValue from CMN_LookupMaster where CMN_LookupMasterId = @DispositionCode),
								   FDRDescription  = @DispositionCodeDescription,
								   CMSProcessDate  = CONVERT(datetime,@CMSProcessDate ,102),
								   TransactionType = (select LookupValue from CMN_LookupMaster where CMN_LookupMasterId = @TransactionTypeLkup),	
								   FDRReceivedDate = getutcDate()
							 Where GEN_QueueRef = @GEN_QueueId 
							 IF(@TransactionTypeLkup = 'SCC')  --SCC
							 BEGIN
							     Update Gen_Queue set MostRecentWorkQueueLkup = 10082 ,--- SCC RPR FDR Received
							                      MostRecentActionLkup    = 28044									
							 Where GEN_QueueId =  @GEN_QueueId 	

							 INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											   ([GEN_QueueRef]
											   ,[RoleLkup]
											   ,[WorkBasketLkup]
											   ,[DiscrepancyCategoryLkup]
											   ,[PreviousActionLkup]
											   ,[PreviousWorkQueuesLkup]
											   ,[PreviousStatusLkup]
											   ,[CurrentActionLkup]
											   ,[CurrentWorkQueuesLkup]
											   ,[CurrentStatusLkup]
											   ,[IsActive]
											   ,[UTCCreatedOn]
											   ,[CreatedByRef]
											   ,[GEN_WorkFlowMasterRef])
										 VALUES
											   (@GEN_QueueId
											   ,2001 ---RoleLkup Admin
											   ,3003  ---WorkBasketLkup RPR
											   ,6007  ---DiscrepancyCategoryLkup RPR
											   ,@PreviousActionLkup
											   ,@PreviousWorkQueueLkup
											   ,20002 ---CurrentActionLkup In Progress
											   ,28044 ---CurrentWorkQueuesLkup  Received RPC FDR
											   ,10082  --CurrentStatusLkup  SCC RPR FDR Received
											   ,20002  --CurrentStatusLkup In Progress
											   ,1
											   ,getutcDate()
											   ,4
											   ,0)  
							 END
							 ELSE --RetEnrl,REInstment,PBP,Ret Discenroll
							 BEGIN
							 Update Gen_Queue set MostRecentWorkQueueLkup = 10071 ,--- Received RPC FDR	10071
							                      MostRecentActionLkup    = 28044									
							 Where GEN_QueueId =  @GEN_QueueId 	

							 INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											   ([GEN_QueueRef]
											   ,[RoleLkup]
											   ,[WorkBasketLkup]
											   ,[DiscrepancyCategoryLkup]
											   ,[PreviousActionLkup]
											   ,[PreviousWorkQueuesLkup]
											   ,[PreviousStatusLkup]
											   ,[CurrentActionLkup]
											   ,[CurrentWorkQueuesLkup]
											   ,[CurrentStatusLkup]
											   ,[IsActive]
											   ,[UTCCreatedOn]
											   ,[CreatedByRef]
											   ,[GEN_WorkFlowMasterRef])
										 VALUES
											   (@GEN_QueueId
											   ,2001 ---RoleLkup Admin
											   ,3003  ---WorkBasketLkup RPR
											   ,6007  ---DiscrepancyCategoryLkup RPR
											   ,@PreviousActionLkup
											   ,@PreviousWorkQueueLkup
											   ,20002 ---CurrentActionLkup In Progress
											   ,28044 ---CurrentWorkQueuesLkup  Received RPC FDR
											   ,10071  --CurrentStatusLkup  Received RPC FDR
											   ,20002  --CurrentStatusLkup In Progress
											   ,1
											   ,getutcDate()
											   ,4
											   ,0)
							 END
							 --End

              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
	   INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES( 4,'[dbo].[USP_BGP_UPD_RPR_Queue]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
        SET @ErrorMessage = Error_Message();
END CATCH     
END