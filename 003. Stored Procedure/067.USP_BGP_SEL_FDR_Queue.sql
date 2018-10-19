IF OBJECT_ID ('USP_BGP_SEL_FDR_Queue') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_SEL_FDR_Queue]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_SEL_FDR_Queue]    Script Date:  08/10/2017 3:53:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 08/10/2017
-- Modified By: 
-- Modification Date: 
-- Description: get HICN,Last Name,First Name,Contract Number, Record and Get Queue
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_SEL_FDR_Queue]
@GEN_QueueId bigint OUT,
@CMSProcessDate Varchar(50) OUT,
@DispositionCode Varchar(50) OUT,
@DispositionCodeDescription Varchar(1000) OUT,
@TransactionTypeLkup bigint OUT,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
       BEGIN TRY
              BEGIN TRAN   
                              SET @GEN_QueueId = 0      
                              SET @CMSProcessDate = ''
                              SET @DispositionCode  = ''
                              SET @DispositionCodeDescription = ''
                              SET @TransactionTypeLkup = 0
                              SET @ErrorMessage = ''
                                        
                              DECLARE @HIC varchar(50) = ''
                              DECLARE @ContractNumberLkup bigint  = 0                        
                              DECLARE @LastName Varchar(100) = ''
                              DECLARE @FirstName varchar(100) = ''
                              DECLARE @RequestedStartDate Varchar(50) = ''
                              DECLARE @GEN_FDRStagingId bigint = 0  
							  DECLARE @RPRActionRequestedLkup bigint  

							  DECLARE @ActionRequestedGroup TABLE (ID BIGINT)
							  DECLARE @RetDisenrlGroup TABLE (ID BIGINT)
							  DECLARE @PBPGroup TABLE (ID BIGINT)
							  DECLARE @RetEnrlGroup TABLE (ID BIGINT)
							  DECLARE @ReInstmtGroup TABLE (ID BIGINT) 
							  DECLARE @SCCGroup TABLE (ID BIGINT)  
							  
							  --INSERT INTO @RetDisenrlGroup VALUES (14001),(14003),(14009),(14014)  --RetDis 43002
							  --INSERT INTO @PBPGroup VALUES (14005)   ---PBP 43005
							  --INSERT INTO @RetEnrlGroup VALUES (14002),(14004),(14010),(14015)     --RetEnrl 43003
							  --INSERT INTO @ReInstmtGroup VALUES (14006),(14012),(14008),(14007),(14011),(14016)  --43001 --Reinstmt  
							  --INSERT INTO @SCCGroup VALUES (14001),(14002),(14003),(14004),(14005),(14006),(14008),(14007),(14009),(14010),(14012),(14011),(14012),(14017) --43004 --SCC 
							  
							  INSERT INTO @RetDisenrlGroup VALUES (14014)  --RetDis 43002
							  INSERT INTO @PBPGroup VALUES (14005)   ---PBP 43005
							  INSERT INTO @RetEnrlGroup VALUES (14015),(14003)     --RetEnrl 43003
							  INSERT INTO @ReInstmtGroup VALUES (14007),(14011),(14016)  --43001 --Reinstmt  
							  INSERT INTO @SCCGroup VALUES (14017) --43004 --SCC


							   select  top 1 @GEN_FDRStagingId = GEN_FDRStagingId,@HIC = [HIC],@ContractNumberLkup = [ContractNumberLkup],@TransactionTypeLkup = [TransactionTypeLkup],
											 @LastName = [Last Name],@FirstName = [First Name],@RequestedStartDate = format(cast([Requested Start Date] as DATETIME),'yyyyMMdd'),
											 @CMSProcessDate = [CMS Process Date],@DispositionCode = [Disposition Code],@DispositionCodeDescription =[Disposition Code Description]
								       from  GEN_FDRBulkImport WITH(NOLOCK) join GEN_FDRStaging WITH(NOLOCK) on GEN_FDRBulkImportId = GEN_FDRBulkImportRef
								      where  IsProcessed = 0 And ImportStatusLkup = 41003
                   
							  IF(@RPRActionRequestedLkup IN (SELECT ID FROM @RetDisenrlGroup) OR @TransactionTypeLkup = 43002) INSERT INTO @ActionRequestedGroup SELECT ID FROM @RetDisenrlGroup
							  IF(@RPRActionRequestedLkup IN (SELECT ID FROM @PBPGroup) OR @TransactionTypeLkup = 43005) INSERT INTO @ActionRequestedGroup SELECT ID FROM @PBPGroup
							  IF(@RPRActionRequestedLkup IN (SELECT ID FROM @RetEnrlGroup) OR @TransactionTypeLkup = 43003) INSERT INTO @ActionRequestedGroup SELECT ID FROM @RetEnrlGroup
							  IF(@RPRActionRequestedLkup IN (SELECT ID FROM @ReInstmtGroup) OR @TransactionTypeLkup = 43001) INSERT INTO @ActionRequestedGroup SELECT ID FROM @ReInstmtGroup
							  IF(@RPRActionRequestedLkup IN (SELECT ID FROM @SCCGroup) OR @TransactionTypeLkup = 43004) INSERT INTO @ActionRequestedGroup SELECT ID FROM @SCCGroup

						     select @GEN_QueueId = GEN_QueueId from GEN_Queue WITH(NOLOCK)
							  where DiscrepancyCategoryLkup=6007 -- RPR
							    And (MemberCurrentHICN = @HIC OR [MemberMedicareId]=@HIC) And MemberContractIDLkup = @ContractNumberLkup  And RPRRequestedEffectiveDateId =  CONVERT(bigint,@RequestedStartDate) --CONVERT(datetime,@RequestedStartDate ,102)
							    And MostRecentStatusLkup != 20003 And RPRActionRequestedLkup IN (SELECT ID FROM @ActionRequestedGroup)

							if(@GEN_QueueId = 0)
							begin
									Update GEN_FDRStaging set IsProcessed = 1, CustomErrorDescription = 'Not able to find related ERS ID' where  GEN_FDRStagingId = @GEN_FDRStagingId;    
							END
							if(@GEN_QueueId ! = 0)
							begin
									Update GEN_FDRStaging set IsProcessed = 1  where  GEN_FDRStagingId = @GEN_FDRStagingId;    
							END

							if(@TransactionTypeLkup = 0)
							Begin
							  Set @ErrorMessage = 'Process Stop';  
							END

              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
       SET @ErrorMessage = Error_Message();
END CATCH     
END
