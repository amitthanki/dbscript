
-----------------
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_APP_SEL_Case_GEN_QUEUE_REFERENCED_CASES_1' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
       CREATE NONCLUSTERED INDEX ERS_IDX_APP_SEL_Case_GEN_QUEUE_REFERENCED_CASES_1
       ON [dbo].[GEN_Queue] ([ParentQueueRef])
       INCLUDE ([GEN_QueueId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_APP_SEL_GMU_QueueDetails_GEN_QUEUE' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
       CREATE NONCLUSTERED INDEX ERS_IDX_APP_SEL_GMU_QueueDetails_GEN_QUEUE
       ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[MostRecentWorkQueueLkup],[IsCasePended],[IsCaseResolved],[IsActive],[LockedByRef],[UTCCreatedOnId])
       INCLUDE ([GEN_QueueId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[ComplianceStartDate],[DiscrepancyStartDate],[MemberCurrentHICN],[MemberFirstName],[MemberLastName],[UTCCreatedOn])
END 
GO


IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_APP_SEL_GMU_QueueDetails_GEN_QUEUE2' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
CREATE NONCLUSTERED INDEX [ERS_IDX_APP_SEL_GMU_QueueDetails_GEN_QUEUE2]
ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[MostRecentWorkQueueLkup],[IsCasePended],[IsCaseResolved],[IsActive],[LockedByRef],[OOALetterStatusLkup])
INCLUDE ([GEN_QueueId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[ComplianceStartDate],[ComplianceStartDateId],[DiscrepancyStartDate],[MemberCurrentHICN],[MemberFirstName],[MemberLastName],[UTCCreatedOn],[UTCCreatedOnId],[IsRestricted],[CMSTransactionStatusLkup])
END
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='CREATE NONCLUSTERED INDEX [ERS_IDX_APP_SEL_QueueSearch_GEN_QUEUE2]' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
	CREATE NONCLUSTERED INDEX [ERS_IDX_APP_SEL_QueueSearch_GEN_QUEUE2]
	ON [dbo].[GEN_Queue] ([IsActive])
	INCLUDE ([GEN_QueueId],[BusinessSegmentLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[AssignedToRef],[LockedByRef],[UTCLockedOn],[MostRecentWorkQueueLkup],[MostRecentStatusLkup],[DiscrepancySourceLkup],[ComplianceStartDate],[ComplianceStartDateId],[DiscrepancyStartDateId],[MemberSCCCode],[MemberCurrentHICN],[MemberFirstName],[MemberLastName],[MemberContractIDLkup],[MemberPBPLkup],[MemberLOBLkup],[MemberDOBId],[EligGPSContractIDLkup],[EligGPSPBPLkup],[EligGPSCurrentHICN],[EligMMRContractIDLkup],[EligMMRPBPLkup],[EligMMRCurrentHICN],[PendedbyRef],[PeerAuditCompletedDateId],[UTCCreatedOnId],[UTCLastUpdatedOnId],[LastUpdatedByRef],[IsRestricted],[OOALetterStatusLkup])
END
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_APP_SEL_QueueSummary_GEN_QUEUE' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
       CREATE NONCLUSTERED INDEX ERS_IDX_APP_SEL_QueueSummary_GEN_QUEUE
       ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[IsActive],[UTCCreatedOnId])
       INCLUDE ([DiscrepancyCategoryLkup],[MostRecentWorkQueueLkup])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_DiscrepancyCatLkup_Active_TypeLkup_StatusLkup_SourceLkup_LOBLkup_UTCCreatedOn' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
	   CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_DiscrepancyCatLkup_Active_TypeLkup_StatusLkup_SourceLkup_LOBLkup_UTCCreatedOn]
	   ON [dbo].[GEN_Queue] ([DiscrepancyCategoryLkup],[IsActive],[DiscrepancyTypeLkup],[MostRecentStatusLkup],[DiscrepancySourceLkup],
	   [MemberLOBLkup],[UTCCreatedOn])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GenQueue_Categorylkup_Active_TypeLkup' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_GenQueue_Categorylkup_Active_TypeLkup]
	  ON [dbo].[GEN_Queue] ([DiscrepancyCategoryLkup],[IsActive],[DiscrepancyTypeLkup])
	  INCLUDE ([MostRecentStatusLkup],[DiscrepancySourceLkup],[UTCCreatedOn],[UTCCreatedOnId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_Gen_Queue_MostRecentWorkQueueLkup_IsActive' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_Gen_Queue_MostRecentWorkQueueLkup_IsActive]
	  ON [dbo].[GEN_Queue] ([MostRecentWorkQueueLkup],[IsActive])
	  INCLUDE ([GEN_QueueId],[WorkBasketLkup],[MostRecentStatusLkup],[DiscrepancySourceLkup],[ComplianceStartDate],[ComplianceStartDateId],[MemberLOBLkup],
	  [UTCCreatedOn],[UTCCreatedOnId],[UTCLastUpdatedOn],[LastUpdatedByRef],[MemberMedicareId])

END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_Gen_Queue_WBLkup_Active_OOALtrStatusLkup_RecenttStatusLkup' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_Gen_Queue_WBLkup_Active_OOALtrStatusLkup_RecenttStatusLkup]
	  ON [dbo].[GEN_Queue] ([WorkBasketLkup],[IsActive],[OOALetterStatusLkup],[MostRecentStatusLkup])
	  INCLUDE ([GEN_QueueId],[MostRecentWorkQueueLkup],[GPSHouseholdID],[MemberContractIDLkup],[MemberPBPLkup],[UTCCreatedOn],[MemberMedicareId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_WBLkup_IsActive_MostRecentStatusLkup' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_WBLkup_IsActive_MostRecentStatusLkup]
	  ON [dbo].[GEN_Queue] ([WorkBasketLkup],[IsActive],[MostRecentStatusLkup])
	  INCLUDE ([OOALetterStatusLkup])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_Gen_Queue_DiscrepancyCategoryLkup_MostRecenetWorkQueueLkup_IsActive' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_Gen_Queue_DiscrepancyCategoryLkup_MostRecenetWorkQueueLkup_IsActive]
	  ON [dbo].[GEN_Queue] ([DiscrepancyCategoryLkup],[MostRecentWorkQueueLkup],[IsActive])
	  INCLUDE ([GEN_QueueId],[MostRecentStatusLkup],[DiscrepancySourceLkup],[ComplianceStartDate],[MemberLOBLkup],[UTCCreatedOn],
	  [UTCLastUpdatedOn],[LastUpdatedByRef],[TRCLkup],[MemberMedicareId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_Gen_Queue_DiscrepancyTypeLkup_IsActive' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_Gen_Queue_DiscrepancyTypeLkup_IsActive]
	  ON [dbo].[GEN_Queue] ([DiscrepancyTypeLkup],[IsActive])
	  INCLUDE ([GEN_QueueId],[MostRecentWorkQueueLkup],[MostRecentStatusLkup],[DiscrepancySourceLkup],[ComplianceStartDate],[MemberLOBLkup],
	  [UTCCreatedOn],[UTCLastUpdatedOn],[LastUpdatedByRef],[MemberMedicareId])
END 
GO


IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_Gen_Queue_DisCategoryLkup_IsActive_MemberLOBLkup' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_Gen_Queue_DisCategoryLkup_IsActive_MemberLOBLkup]
	  ON [dbo].[GEN_Queue] ([DiscrepancyCategoryLkup],[IsActive],[MemberLOBLkup])
	  INCLUDE ([ComplianceStartDate])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_WorkBasketLkup_IsActive_DiscrepancyCategoryLkup_MostRecentWorkQueueLkup'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_WorkBasketLkup_IsActive_DiscrepancyCategoryLkup_MostRecentWorkQueueLkup]
	ON [dbo].[GEN_Queue] ([WorkBasketLkup],[IsActive],[DiscrepancyCategoryLkup],[MostRecentWorkQueueLkup])
	INCLUDE ([GEN_QueueId],[DiscrepancyTypeLkup],[MostRecentStatusLkup],[MemberCurrentHICN],[CSTCreatedOn],[MemberMedicareId])

END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_BusinessSegmentLkup_MostRecentWorkQueueLkup_IsCasePended_IsCaseResolved_IsActive_LockedByRef'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_BusinessSegmentLkup_MostRecentWorkQueueLkup_IsCasePended_IsCaseResolved_IsActive_LockedByRef]
	  ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[MostRecentWorkQueueLkup],[IsCasePended],[IsCaseResolved],[IsActive],[LockedByRef])
	  INCLUDE ([GEN_QueueId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[ComplianceStartDate],[ComplianceStartDateId],[DiscrepancyStartDate],[MemberFirstName],[MemberLastName],[UTCCreatedOn],[UTCCreatedOnId],[IsRestricted],[OOALetterStatusLkup],[CMSTransactionStatusLkup],[MemberMedicareId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_MostRecentWorkQueueLkup_IsActive_IsFTTMacroProcessed'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_MostRecentWorkQueueLkup_IsActive_IsFTTMacroProcessed]
	ON [dbo].[GEN_Queue] ([MostRecentWorkQueueLkup],[IsActive],[IsFTTMacroProcessed])
	INCLUDE ([GEN_QueueId],[DiscrepancyTypeLkup],[MostRecentActionLkup],[MostRecentStatusLkup],[MemberSCCCode],[MemberID],[MemberCurrentHICN],[GPSHouseholdID],[MemberFirstName],[MemberMiddleName],[MemberLastName],[MemberContractIDLkup],[MemberPBPLkup],[MemberLOBLkup],[MemberDOB],[MemberMedicareId])

END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_BusinessSegmentLkup_WorkBasketLkup_MemberContractIDLkup_MemberPBPLkup_IsActive_GEN_QueueId_MostRecentStatusLkup'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_BusinessSegmentLkup_WorkBasketLkup_MemberContractIDLkup_MemberPBPLkup_IsActive_GEN_QueueId_MostRecentStatusLkup]
	ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[WorkBasketLkup],[MemberContractIDLkup],[MemberPBPLkup],[IsActive],[GEN_QueueId],[MostRecentStatusLkup])
	INCLUDE ([DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[MostRecentWorkQueueLkup],[DiscrepancySourceLkup],[DiscrepancyStartDate],[MemberCurrentHICN],[GPSHouseholdID],[IsParentCase],[IsChildCase],[ParentQueueRef],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[MemberMedicareId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_LockedByRef_UTCLockedOn_IsActive_CMSTransactionStatusLkup'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_LockedByRef_UTCLockedOn_IsActive_CMSTransactionStatusLkup]
	ON [dbo].[GEN_Queue] ([LockedByRef],[UTCLockedOn],[IsActive],[CMSTransactionStatusLkup])
	INCLUDE ([GEN_QueueId],[UTCCreatedOn],[OOALetterStatusLkup])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_MostRecentWorkQueueLkup_IsActive'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_MostRecentWorkQueueLkup_IsActive]
	ON [dbo].[GEN_Queue] ([MostRecentWorkQueueLkup],[IsActive])
	INCLUDE ([GEN_QueueId],[WorkBasketLkup],[MostRecentStatusLkup],[DiscrepancySourceLkup],[ComplianceStartDate],[ComplianceStartDateId],[MemberLOBLkup],[UTCCreatedOn],[UTCCreatedOnId],[UTCLastUpdatedOn],[LastUpdatedByRef],[MemberMedicareId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_LockedByRef_UTCLockedOn_IsActive_OOALetterStatusLkup_MostRecentWorkQueueLkup'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_LockedByRef_UTCLockedOn_IsActive_OOALetterStatusLkup_MostRecentWorkQueueLkup]
	ON [dbo].[GEN_Queue] ([LockedByRef],[UTCLockedOn],[IsActive],[OOALetterStatusLkup],[MostRecentWorkQueueLkup])
	INCLUDE ([GEN_QueueId],[UTCCreatedOn])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_Queue_BusinessSegmentLkup_IsActive'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_GEN_Queue_BusinessSegmentLkup_IsActive]
	ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[IsActive])
	INCLUDE ([GEN_QueueId],[DiscrepancyCategoryLkup],[MostRecentWorkQueueLkup],[ComplianceStartDateId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_APP_SEL_Case_GEN_QUEUE_REFERENCED_CASES_2' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
       CREATE NONCLUSTERED INDEX ERS_IDX_APP_SEL_Case_GEN_QUEUE_REFERENCED_CASES_2
       ON [dbo].[GEN_Queue] ([WorkBasketLkup],[MemberCurrentHICN],[MemberContractIDLkup],[MemberPBPLkup],[IsActive],[GEN_QueueId])
END 
GO



IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CaseId_CMN_RecordsLocked2' AND OBJECT_ID=OBJECT_ID('CMN_RecordsLocked'))
BEGIN 
CREATE NONCLUSTERED INDEX [ERS_IDX_CaseId_CMN_RecordsLocked2]
ON [dbo].[CMN_RecordsLocked] ([ScreenLkup],[IsActive])
INCLUDE ([CaseId])
END
GO



IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_ManageCases' AND OBJECT_ID=OBJECT_ID('GEN_ManageCases'))
BEGIN 
CREATE NONCLUSTERED INDEX [ERS_IDX_GEN_QueueRef_GEN_ManageCases]
ON [dbo].[GEN_ManageCases] ([CurrentUserRef],[IsActive],[UTCCreatedOn])
INCLUDE ([GEN_QueueRef])
END
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_QueueHistory_IsActive_UTCHistoryCreatedOn' AND OBJECT_ID=OBJECT_ID('GEN_QUEUE'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_GEN_QueueHistory_IsActive_UTCHistoryCreatedOn]
	  ON [dbo].[GEN_QueueHistory] ([IsActive],[UTCHistoryCreatedOn])
	  INCLUDE ([GEN_QueueRef],[DiscrepancyCategoryLkup],[MostRecentWorkQueueLkup],[ComplianceStartDate])
END 
GO




IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_Gen_OSTActions_IsActive' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_Gen_OSTActions_IsActive]
	  ON [dbo].[GEN_OSTActions] ([IsActive])
	  INCLUDE ([GEN_QueueRef],[FirstLetterMailDate],[SecondLetterMailDate])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_GEN_ManageCases_CurrentUserRef_IsActive_UTCCreatedOn' AND OBJECT_ID=OBJECT_ID('GEN_ManageCases'))
BEGIN 
      CREATE NONCLUSTERED INDEX [IDX_GEN_ManageCases_CurrentUserRef_IsActive_UTCCreatedOn]
	  ON [dbo].[GEN_ManageCases] ([CurrentUserRef],[IsActive],[UTCCreatedOn])
	  INCLUDE ([GEN_QueueRef])
END 
GO


IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_CMN_BackgroundProcessMaster_UTCCreatedOn'
   AND OBJECT_ID=OBJECT_ID('CMN_BackgroundProcessMaster'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_CMN_BackgroundProcessMaster_UTCCreatedOn]
	ON [dbo].[CMN_BackgroundProcessMaster] ([UTCCreatedOn])
	INCLUDE ([CMN_BackgroundProcessMasterId],[BackgroundProcessTypeLkup],[UTCStartDate],[UTCEndDate],[BGPStatusLkup])
END 
GO


IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='IDX_CMN_RecordsLocked_IsActive'
   AND OBJECT_ID=OBJECT_ID('CMN_RecordsLocked'))
BEGIN 
    CREATE NONCLUSTERED INDEX [IDX_CMN_RecordsLocked_IsActive]
	ON [dbo].[CMN_RecordsLocked] ([IsActive])
	INCLUDE ([CaseId])
END 
GO

IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PP_SEL_PendedRecords_GEN_Queue'
   AND OBJECT_ID=OBJECT_ID('GEN_Queue'))
BEGIN
	CREATE NONCLUSTERED INDEX ERS_IDX_PP_SEL_PendedRecords_GEN_Queue
	ON [dbo].[GEN_Queue] ([BusinessSegmentLkup],[WorkBasketLkup],[IsCasePended],[PendedbyRef],[IsActive])
	INCLUDE ([GEN_QueueId],[DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[MostRecentActionLkup],[MostRecentWorkQueueLkup],[MostRecentStatusLkup],[ComplianceStartDate],[DisenrollmentDate],[DiscrepancyStartDate],[DiscrepancyEndDate],[MemberSCCCode],[MemberID],[GPSHouseholdID],[MemberFirstName],[MemberMiddleName],[MemberLastName],[MemberContractIDLkup],[MemberPBPLkup],[MemberLOBLkup],[MemberVerifiedState],[MemberVerifiedCountyCode],[MemberDOB],[MemberGenderLkup],[UTCPendedOn],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[MemberMedicareId])
END
GO