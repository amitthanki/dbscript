IF OBJECT_ID ('USP_BGP_SEL_FDRValidation') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_SEL_FDRValidation]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_SEL_FDRValidation]    Script Date: 8/9/2017 8:51:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 08/09/2017
-- Modified By: 
-- Modification Date: 
-- Description: Validate import record for FDR Response
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_SEL_FDRValidation] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_BGP_SEL_FDRValidation]
@FDRImportId bigint,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
       BEGIN Try

       --If record is considered(Invalid, Duplicate or after import success) the import the set IsProcessed = 1.

       --If HICN missing, then record is invalid
       Update GEN_FDRStaging Set IsInvalid = 1, IsProcessed = 1, [CustomErrorDescription] = 'HICN Missing.' Where IsProcessed = 0  And ([HIC] Is NULL Or [HIC]='') And GEN_FDRBulkImportRef = @FDRImportId

       --If Requested Start(Effective) Date missing, then record is invalid
       Update GEN_FDRStaging Set IsInvalid = 1, IsProcessed = 1, [CustomErrorDescription] = 'Requested Start(Effective) Date Missing.' Where IsProcessed = 0 And ([Requested Start Date] Is NULL Or [Requested Start Date]='') And GEN_FDRBulkImportRef = @FDRImportId

       --If CMS Process Date missing, then record is invalid
       Update GEN_FDRStaging Set IsInvalid = 1, IsProcessed = 1, [CustomErrorDescription] = 'CMS Process Date Missing.' Where  IsProcessed = 0 And ([CMS Process Date] Is NULL Or [CMS Process Date]='') And GEN_FDRBulkImportRef = @FDRImportId

       --If Disposition Code missing, then record is invalid
       Update GEN_FDRStaging Set IsInvalid = 1, IsProcessed = 1, [CustomErrorDescription] = 'Disposition Code Missing.' Where  IsProcessed = 0 And ([Disposition Code] Is NULL Or [Disposition Code]='') And GEN_FDRBulkImportRef = @FDRImportId

       --If Disposition Code Description missing, then record is invalid
       Update GEN_FDRStaging Set IsInvalid = 1, IsProcessed = 1, [CustomErrorDescription] = 'Disposition Code Description Missing.' Where  IsProcessed = 0 And ([Disposition Code Description] Is NULL Or [Disposition Code Description]='') And GEN_FDRBulkImportRef = @FDRImportId

       --Make duplicate record in staging table if same combination existing multiple time in stagging table itself with Same BulkImport File.
       BEGIN
              ;With CTE_Dup
              As
              (
                     Select [HIC],[Requested Start Date],IsDuplicate,IsProcessed,[CustomErrorDescription],Row_Number() OVER (PARTITION BY [HIC],[Requested Start Date] ORDER BY [HIC],[Requested Start Date]) RowNum
                     FROM GEN_FDRStaging WITH(NOLOCK) Where GEN_FDRBulkImportRef = @FDRImportId AND IsInvalid=0 and  IsProcessed = 0
              )
              Update CTE_Dup SET IsDuplicate=1,IsProcessed = 1,CustomErrorDescription= 'Duplicate HICN & Requested Start Date found in staging table for same Excel file Import.' Where RowNum>1
       END

	   --Make duplicate record in staging table if same combination existing multiple time in stagging table itself
       BEGIN
              ;With CTE_Dup
              As
              (
                     Select [HIC],[Requested Start Date],IsDuplicate,IsProcessed,[CustomErrorDescription],Row_Number() OVER (PARTITION BY [HIC],[Requested Start Date] ORDER BY [HIC],[Requested Start Date]) RowNum
                     FROM GEN_FDRStaging WITH(NOLOCK) Where  IsInvalid=0 and  IsProcessed = 0
              )
              Update CTE_Dup SET IsDuplicate=1,IsProcessed = 1,CustomErrorDescription= 'Duplicate HICN & Requested Start Date found in staging table.' Where RowNum>1
       END

	  -- If record already process in Queue table, identify those records in Staging table as Duplicate
      --- All Ready Process Receive RPC FDR Duplicate Queue ID Identify from GEN_FDRStaging table based on HICN,MemberContractIDLkup and RPRRequestedEffectiveDateID.
	  --10087 RPR Vs RPR - Sent to RPC
	  --10078 RPR Vs RPR - Re-Submission
	  --10084 RPR Vs RPR - SCC RPR Sent
	  --10083 RPR Vs RPR - SCC RPR Re-Submission
	  Update stg
	  Set Stg.IsDuplicate=1,Stg.IsProcessed = 1,Stg.CustomErrorDescription= 'FDR Response already process. GEN_QueueId = '+Cast(Q.GEN_QueueId As Varchar(100))
	  from GEN_FDRStaging Stg WITH(NOLOCK)
	   Join GEN_FDRBulkImport BI WITH(NOLOCK) On BI.GEN_FDRBulkImportId = Stg.GEN_FDRBulkImportRef
	   Join GEN_Queue Q WITH(NOLOCK) On (Q.MemberCurrentHICN = Stg.HIC OR Q.[MemberMedicareId] = Stg.HIC) And Q.MemberContractIDLkup = BI.ContractNumberLkup  And Q.RPRRequestedEffectiveDateId = format(cast([Requested Start Date] as DATETIME),'yyyyMMdd') --CONVERT(datetime,@RequestedStartDate ,102)
							  where stg.IsProcessed = 0 And Q.DiscrepancyCategoryLkup=6007 -- RPR
							    And Q.MostRecentStatusLkup != 20003 And Q.MostRecentWorkQueueLkup Not In (10087,10078,10084,10083)
																							  
       END Try

       BEGIN CATCH
	    INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES( 4,'[dbo].[USP_BGP_SEL_FDRValidation]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
              Set @ErrorMessage = Error_Message()
       END CATCH
END
