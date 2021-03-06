IF OBJECT_ID ('USP_BGP_INS_FDR_Staging') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_INS_FDR_Staging]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_FDR_Staging]    Script Date: 8/11/2017 10:44:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[USP_BGP_INS_FDR_Staging]
@GEN_FDRBulkImportId bigint,
@IsActive BIT = 1,
@XMLData   NVARCHAR(MAX),
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
       BEGIN TRY
              BEGIN TRAN 
                     --Set Current UTC Datetime
                     DECLARE @UTCDATE datetime
                     SET @UTCDATE = GETUTCDATE()              
                     DECLARE @Xml INT
                                 ----------Parsing------------
                                  EXEC sp_xml_preparedocument @Xml OUTPUT,@XMLData

                                         SELECT *
                                           INTO #Temp
                                           FROM OPENXML(@Xml,'//Table1',0)
                                  WITH
                                  (
                                         [HIC]  VARCHAR(1000)  'HIC'
                                         ,[Last Name] VARCHAR(1000) 'Last_x0020_Name'
                                         ,[First Name] VARCHAR(1000) 'First_x0020_Name'
                                         ,[Requested Start Date] VARCHAR(1000) 'Requested_x0020_Start_x0020_Date'
                                         ,[Requested End Date] VARCHAR(1000) 'Requested_x0020_End_x0020_Date'
                                         ,[Requested CMS Segment] VARCHAR(1000) 'Requested_x0020_CMS_x0020_Segment'
                                         ,[Requested PBP] VARCHAR(1000) 'Requested_x0020_PBP'
                                         ,[Requested Election Period] VARCHAR(1000) 'Requested_x0020_Election_x0020_Period'
                                         ,[Application Receipt Date] VARCHAR(1000) 'Application_x0020_Receipt_x0020_Date'
                                         ,[Received Date] VARCHAR(1000) 'Received_x0020_Date'
                                         ,[CMS Process Date] VARCHAR(1000) 'CMS_x0020_Process_x0020_Date'
                                         ,[Disposition Code] VARCHAR(1000) 'Disposition_x0020_Code'
                                         ,[Disposition Code Description] VARCHAR(1000) 'Disposition_x0020_Code_x0020_Description'
                                         ,[Requested SCC] VARCHAR(1000) 'Requested_x0020_SCC'
                                         ,[Requested ZIP] VARCHAR(1000) 'Requested_x0020_ZIP'
                                  )

                   EXEC sp_xml_removedocument @Xml
                                         
                     /************* Insert Gen_FDRStaging *********************/

                     INSERT INTO [dbo].[GEN_FDRStaging]
                                         ([GEN_FDRBulkImportRef],[HIC],[Last Name],[First Name],[Requested Start Date],[Requested End Date],[Requested CMS Segment],[Requested PBP],[Requested Election Period],[Application Receipt Date]
                                         ,[Received Date],[CMS Process Date],[Disposition Code],[Disposition Code Description],[Requested SCC],[Requested ZIP],[IsActive],[UTCCreatedOn])               
                     SELECT @GEN_FDRBulkImportId, [HIC],[Last Name],[First Name],[Requested Start Date],[Requested End Date],[Requested CMS Segment],[Requested PBP],[Requested Election Period],[Application Receipt Date]
                                  ,[Received Date],[CMS Process Date],[Disposition Code],[Disposition Code Description],[Requested SCC],[Requested ZIP],@IsActive,@UTCDATE
                       FROM #Temp 
                           
              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
       SET @ErrorMessage = Error_Message();
END CATCH     
END
