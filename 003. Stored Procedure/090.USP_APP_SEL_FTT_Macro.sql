IF OBJECT_ID ('USP_APP_SEL_FTT_Macro') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_FTT_Macro]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_FTT_Macro]    Script Date: 01/29/2018 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Amit Thanki
-- Create date: 01/29/2018
-- Description: Get OOA Pending FTT Status the queue for Macro
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_FTT_Macro] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_FTT_Macro]
@HouseholdID VARCHAR(100) = NULL,
@HICN VARCHAR(100) = NULL,
@Contract VARCHAR(100) = NULL,
@PBP  VARCHAR(100) = NULL,
@EffectiveDate VARCHAR(100) = NULL,
@DiscrepancyType VARCHAR(100) = NULL,
@ErrorMessage varchar(2000) OUTPUT
AS
BEGIN  

BEGIN TRY

    DECLARE @ContractIDLkup bigint = NULL
    DECLARE @PBPLkup bigint = NULL
    DECLARE @DiscrepancyTypeLkup bigint  = NULL     
                     
    select @ContractIDLkup = CMN_LookupMasterID  from CMN_LookupMaster with(nolock) where CMN_LookupTypeRef = 11 And LookupValue = @Contract;
    select @PBPLkup = CMN_LookupMasterID  from CMN_LookupMaster with(nolock) where CMN_LookupTypeRef = 12 And LookupValue = @PBP;
    select @DiscrepancyTypeLkup = CMN_LookupMasterID  from CMN_LookupMaster with(nolock) where CMN_LookupTypeRef = 7 And LookupValue = @DiscrepancyType;

                     Select GEN_QueueId as WorkItemID, 
                            GQ.MemberSCCCode as MemberSCCCode,
                            GQ.MemberID as MemberID,
                            GQ.MemberMedicareId as MemberCurrentHICN,
                            GQ.GPSHouseholdID as GPSHouseholdID,
                            GQ.MemberFirstName as MemberFirstName,
                            GQ.MemberMiddleName as MemberMiddleName,
                            GQ.MemberLastName as MemberLastName,
                            LMContractId.LookupValue as MemberContractID,
                            GQ.MemberDOB as MemberDOB,
                            LMPBPId.LookupValue as MemberPBP,
                            LMLOBId.LookupValue as MemberLOB,
                            NULL as MemberGender,
                            LMDiscType.LookupValue as DiscrepancyType,
                            GQ.MostRecentStatusLkup,
                            LMStatus.LookupValue as MostRecentStatus,
                            GQ.MostRecentWorkQueueLkup,
                            LMQueue.LookupValue as MostRecentQueue,
                            LMAction.LookupValue as MostRecentAction 
                            From GEN_Queue GQ with(nolock)
                            LEFT JOIN GEN_OSTActions GOST WITH(NOLOCK) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
                            LEFT JOIN CMN_LookupMaster LMDiscType WITH(NOLOCK) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And      LMDiscType.CMN_LookupTypeRef = 7  
                            LEFT JOIN CMN_LookupMaster LMStatus WITH(NOLOCK) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
                            LEFT JOIN CMN_LookupMaster LMQueue WITH(NOLOCK) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
                            LEFT JOIN CMN_LookupMaster LMAction WITH(NOLOCK) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28 
                            LEFT JOIN CMN_LookupMaster LMContractId WITH(NOLOCK) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
                            LEFT JOIN CMN_LookupMaster LMPBPId WITH(NOLOCK) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
                            LEFT JOIN CMN_LookupMaster LMLOBId WITH(NOLOCK) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31    
                      Where                                           
                            GQ.IsActive=1
                            AND (@HouseholdID Is Null OR GQ.GPSHouseholdID = @HouseholdID)
                            AND (@HICN Is Null OR GQ.MemberCurrentHICN = @HICN OR GQ.[MemberMedicareId]= @HICN)   
                            AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup)
                            AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup)
                            AND (@EffectiveDate Is Null OR GOST.EffectiveDate = CONVERT(date,@EffectiveDate))
                            AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)                                         
                            AND (GQ.MostRecentWorkQueueLkup = 10008)  ---OOA - Open Disenroll 
							AND (GQ.IsFTTMacroProcessed = 0 or IsFTTMacroProcessed IS NULL)
END TRY 

BEGIN CATCH

SET @ErrorMessage= ERROR_MESSAGE();

END CATCH 

END
