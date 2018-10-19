IF OBJECT_ID ('USP_UPD_NOT_Macro') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_UPD_NOT_Macro]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UPD_NOT_Macro]    Script Date: 8/10/2017 11:51:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 01/29/2018
-- Modified By: 
-- Modification Date: 
-- Description: For Update NOT Macro for OOA.
-- =============================================
CREATE PROCEDURE [dbo].[USP_UPD_NOT_Macro]
@GEN_QueueId bigint,
@Status Varchar(50),
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN 
	DECLARE @CurrentUser BigInt
	Set     @CurrentUser = 23
	DECLARE @CurrentUTCDate datetime
	Set     @CurrentUTCDate = getutcDate()
	DECLARE @PreviousActionLkup bigint
    DECLARE @PreviousWorkQueueLkup bigint
	DECLARE @ActionLkup bigint
	DECLARE @MostRecentQueueLkup bigint
	Set     @MostRecentQueueLkup = 10012   --- OOA - Pending FTT
	BEGIN TRY	         
			BEGIN TRAN    
			         Select @PreviousWorkQueueLkup = MostRecentWorkQueueLkup, @PreviousActionLkup = MostRecentActionLkup  from Gen_Queue  WITH(NOLOCK) Where GEN_QueueId =  @GEN_QueueId;
					 IF (@Status = 'Completed')
                     BEGIN
					 Set    @ActionLkup = 28014  --Send Notification of Termination Letter
					     Update GEN_OSTActions 
						 set    SecondLetterMailDate  = @CurrentUTCDate,
						        SecondLetterMailDateId = FORMAT(@CurrentUTCDate, 'yyyyMMdd'),
						        ActionLkup             = @ActionLkup,
						        [UTCLastUpdatedOn]=@CurrentUTCDate,
                                [LastUpdatedByRef]=@CurrentUser
					      Where GEN_QueueRef = @GEN_QueueId 
						 Update GEN_Queue 
						    set IsNOTMacroProcessed  = 1
						        ,MostRecentWorkQueueLkup = @MostRecentQueueLkup --- OOA - Pending FTT,
								,MostRecentActionLkup    = @ActionLkup
								,NOTMacroStatusLkup = 59001
							    ,NOTMacroUpdatedOn = @CurrentUTCDate
							    ,NOTMacroUpdatedByRef = @CurrentUser
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUser
					      Where  GEN_QueueId = @GEN_QueueId
		  --- Insert record into Manage cases
					     INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])											 
						 VALUES
								(@GEN_QueueId
								,@ActionLkup    --Action  
								,@CurrentUser  --Current User
								,'NOT Macro Processed' ---Comments								
								,@CurrentUser  --- Reassign User  
								,1              --Is Active
								,@CurrentUTCDate  ---UTC Created On
								,@CurrentUser     ---Created ByRef 
								,@CurrentUTCDate  --UTC Last Updated On
								,@CurrentUser    ----Last Updated ByRef
								)
								 INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])											 
						 VALUES
								(@GEN_QueueId
								,'NOT Macro Processed' ---Comments
								,@ActionLkup  --Action  
								,1  --Is Active
								,@CurrentUTCDate   ---UTC Created On
								,@CurrentUser     -----Created ByRef 
								,@CurrentUTCDate  --UTC Last Updated On
								,@CurrentUser -----Last Updated ByRef  
								,38006  --- Source System - ERS
								)
         --- Insert record into Gen_Queue Workflow correlation
                           INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
                                                                            [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
                            VALUES
							      (@GEN_QueueId  -- Gen Queue ID
							      ,2001  --  Admin Role 
								  ,3001   --- WorkBasket OST
								  ,6001   --- Discrepancy Category OOA
								  ,@PreviousActionLkup      --- Previous Action
								  ,@PreviousWorkQueueLkup   --- Previous Work Queue 
								  ,20002        ---- Previous Status In Progress
								  ,@ActionLkup  --- Action Send Notification of Termination Letter
								  ,@MostRecentQueueLkup --- OOA - Pending FTT,  ---- Current Work Queue
								  ,20002         ---- Current Status  In Progress                                 
								  ,1               -- Is Active
								  ,@CurrentUTCDate
								  ,@CurrentUser)
				     END
					 ELSE  -- Not Completed
					 BEGIN
					 Set   @ActionLkup = 28076    -----NOT Macro Failed
				           Update GEN_OSTActions 
						   Set    ActionLkup       =@ActionLkup,
						         [UTCLastUpdatedOn]=@CurrentUTCDate,
                                 [LastUpdatedByRef]=@CurrentUser
					      Where GEN_QueueRef = @GEN_QueueId 
						 Update GEN_Queue 
						    set  MostRecentActionLkup = @ActionLkup
								,[UTCLastUpdatedOn]   = @CurrentUTCDate
								,IsNOTMacroProcessed  = 1
								,NOTMacroStatusLkup = 59002
							    ,NOTMacroUpdatedOn = @CurrentUTCDate
							    ,NOTMacroUpdatedByRef = @CurrentUser
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUser
					      Where  GEN_QueueId = @GEN_QueueId
					     INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])											 
						 VALUES
								(@GEN_QueueId
								,'Macro unable to complete, refer to NOT Macro Processed report for further details' ---Comments
								,@ActionLkup  --Action  
								,1  --Is Active
								,@CurrentUTCDate   ---UTC Created On
								,@CurrentUser     -----Created ByRef 
								,@CurrentUTCDate  --UTC Last Updated On
								,@CurrentUser -----Last Updated ByRef  
								,38006  --- Source System - ERS
								)
		--- Insert record into Manage cases
					     INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])											 
						 VALUES
								(@GEN_QueueId
								,@ActionLkup   --Action  
								,@CurrentUser  --Current User
								,'Macro unable to complete, refer to NOT Macro Processed report for further details' ---Comments							
								,@CurrentUser  --- Reassign User  
								,1  --Is Active
								,@CurrentUTCDate   ---UTC Created On
								,@CurrentUser     -----Created ByRef 
								,@CurrentUTCDate  --UTC Last Updated On
								,@CurrentUser -----Last Updated ByRef
								)
        --- Insert record into Gen_Queue Workflow correlation
                           INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
                                                                            [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
                            VALUES
							      (@GEN_QueueId  -- Gen Queue ID
							      ,2001  --  Admin Role 
								  ,3001   --- WorkBasket OST
								  ,6001   --- Discrepancy Category OOA
								  ,@PreviousActionLkup      --- Previous Action
								  ,@PreviousWorkQueueLkup   --- Previous Work Queue 
								  ,20002   ---- Previous Status In Progress
								  ,@ActionLkup   --- Current Action 
								  ,@PreviousWorkQueueLkup    --- Current Work Queue
								  ,20002   ---- Current Status  In Progress                                 
								  ,1  -- Is Active
								  ,@CurrentUTCDate
								  ,@CurrentUser)

					END	
              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
	   INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES( @CurrentUser,'[dbo].[USP_UPD_NOT_Macro]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
        SET @ErrorMessage = Error_Message();
END CATCH     
END