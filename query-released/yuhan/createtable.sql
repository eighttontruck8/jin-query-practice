-- 1. vwselecttypemodel 
CREATE VIEW [DBO].[VWSELECTTYPEMODEL]
AS

SELECT
	STM.IPSIYEAR
	, STM.IPSIGUBUN, II.IpsiName
	, STM.SMIDX
	, STM.ModelName
	, IG.GunID, IG.GunName
	, IC.CampusID, IC.CampusName
	, IST.SelTypeGubun, C25.CodeName as SelTypeGubunName
	, IST.StdSelTypeCode, C47.CodeName as StdSelTypeName
	, IST.SelTypeCode, IST.SelTypeName
	, STM.ApplyScope
	, IMA.MajorAreaCode, IMA.MajorAreaName
	, IM.MajorCode, IM.MajorName

	, IM.Department, C22.CodeName AS DepartmentName

	, IM.College, C100.CodeName AS CollegeName
	, STM.Personnel, STM.OldPersonnel
	, STM.StepMethod, C48.CodeName as StepMethodName
	, STM.CompareScoreGubun, C91.CodeName as CompareScoreName
	, IST.DisplayOrder as SelTypeOrder
	, IMA.DisplayOrder as MajorAreaOrder
	, IMA.MAPERSONNELYA, IMA.MAFIXEDNUMYA
	, IMA.MaPersonnel, IMA.MaFixedNum
	, IM.DisplayOrder as MajorOrder
	, STM.DisplayOrder
	, STM.PRIORITYORDERGUBUN, STM.PRIORITYORDER
	, STMM.MAJORPERSONNEL   
  , STMM.MAJORPERSONNELADD
	, STM.IsPassAll
	, STM.LastPersonnel
FROM SELECTTYPEMODEL STM
INNER JOIN SELECTTYPEMODELMAJOR STMM ON STMM.SMIDX = STM.SMIDX
Inner Join InfoIpsi II on STM.IpsiYear = II.IpsiYear And STM.IpsiGubun = II.IpsiGubun 
Inner Join InfoGun IG on STM.GunID = IG.GunID
Inner Join InfoCampus IC on STM.CampusID = IC.CampusID
Inner Join InfoSelectType IST on STM.IpsiYear = IST.IpsiYear And STM.IpsiGubun = IST.IpsiGubun 
	And STM.SelTypeCode = IST.SelTypeCode
Inner Join InfoMajor IM on STM.IpsiYear = IM.IpsiYear And STM.IpsiGubun = IM.IpsiGubun 
	And STMM.MajorCode = IM.MajorCode
Inner Join InfoMajorArea IMA on IMA.IpsiYear = IM.MacYear And IMA.MajorAreaCode = IM.MajorAreaCode
Inner Join Code C25 ON C25.CodeGubun = '25' And C25.CodeIdx = IST.SelTypeGubun
Left Join Code C47 on C47.CodeGubun = '47' And C47.CodeIdx = IST.StdSelTypeCode
Left Join Code C22 on C22.CodeGubun = '22' And C22.CodeIdx = IM.Department
Left Join CodeYear C100 on C100.IpsiYear = IST.IpsiYear
	And C100.CodeGubun = '100' And C100.CodeIdx = IM.College
LEFT JOIN CODE C48 ON C48.CODEGUBUN = '48' AND STM.StepMethod = C48.CODEIDX	
LEFT JOIN CODE C91 ON C91.CODEGUBUN = '91' AND STM.COMPARESCOREGUBUN = C91.CODEIDX

-- 2. SELECTTYPEMODEL
USE [JEMSv4]
GO

/****** 개체: Table [dbo].[SelectTypeModel] 스크립트 날짜: 2026-09-01 오전 9:38:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SelectTypeModel](
	[SmIdx] [int] IDENTITY(1,1) NOT NULL,
	[ModelName] [varchar](100) NULL,
	[IpsiYear] [smallint] NOT NULL,
	[IpsiGubun] [tinyint] NOT NULL,
	[CampusID] [smallint] NULL,
	[GunID] [smallint] NULL,
	[SelTypeCode] [varchar](10) NULL,
	[Personnel] [smallint] NULL,
	[OldPersonnel] [smallint] NULL,
	[StepMethod] [varchar](10) NULL,
	[CompareScoreGubun] [varchar](10) NULL,
	[PriorityOrderGubun] [varchar](10) NULL,
	[PriorityOrder] [smallint] NULL,
	[ApplyScope] [varchar](5) NULL,
	[PercentMajor] [tinyint] NULL,
	[ReportMajorName] [varchar](100) NULL,
	[ModelCharge] [int] NULL,
	[Commission] [int] NULL,
	[DisplayOrder] [smallint] NULL,
	[IsPassAll] [char](1) NULL,
	[subMajorCode] [varchar](10) NULL,
	[BIGO1] [varchar](50) NULL,
	[BIGO2] [varchar](50) NULL,
	[LastPersonnel] [smallint] NULL,
	[ExSmIdx] [int] NULL,
 CONSTRAINT [PK_SelectTypeModel] PRIMARY KEY CLUSTERED 
(
	[SmIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SelectTypeModel] ADD  CONSTRAINT [DF_SelectTypeModel_IsPassAll]  DEFAULT ('0') FOR [IsPassAll]
GO

ALTER TABLE [dbo].[SelectTypeModel]  WITH CHECK ADD  CONSTRAINT [FK_SelectTypeModel_InfoCampus] FOREIGN KEY([CampusID])
REFERENCES [dbo].[InfoCampus] ([CampusID])
GO

ALTER TABLE [dbo].[SelectTypeModel] CHECK CONSTRAINT [FK_SelectTypeModel_InfoCampus]
GO

ALTER TABLE [dbo].[SelectTypeModel]  WITH CHECK ADD  CONSTRAINT [FK_SelectTypeModel_InfoGun] FOREIGN KEY([GunID])
REFERENCES [dbo].[InfoGun] ([GunID])
GO

ALTER TABLE [dbo].[SelectTypeModel] CHECK CONSTRAINT [FK_SelectTypeModel_InfoGun]
GO

ALTER TABLE [dbo].[SelectTypeModel]  WITH CHECK ADD  CONSTRAINT [FK_SelectTypeModel_InfoIpsi] FOREIGN KEY([IpsiYear], [IpsiGubun])
REFERENCES [dbo].[InfoIpsi] ([IpsiYear], [IpsiGubun])
GO

ALTER TABLE [dbo].[SelectTypeModel] CHECK CONSTRAINT [FK_SelectTypeModel_InfoIpsi]
GO

ALTER TABLE [dbo].[SelectTypeModel]  WITH CHECK ADD  CONSTRAINT [FK_SelectTypeModel_InfoSelectType] FOREIGN KEY([IpsiYear], [IpsiGubun], [SelTypeCode])
REFERENCES [dbo].[InfoSelectType] ([IpsiYear], [IpsiGubun], [SelTypeCode])
GO

ALTER TABLE [dbo].[SelectTypeModel] CHECK CONSTRAINT [FK_SelectTypeModel_InfoSelectType]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전형모델관리_Master' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SelectTypeModel'
GO



-- 3. SELECTTYPEMODELMAJOR(STMM)
CREATE TABLE [dbo].[SelectTypeModelMajor](
	[SmIdx] [int] NOT NULL,
	[MajorCode] [varchar](10) NOT NULL,
	[MajorPersonnel] [smallint] NULL,
	[IpsiYear] [smallint] NOT NULL,
	[IpsiGubun] [tinyint] NOT NULL,
	[MajorPersonnelAdd] [int] NOT NULL,
 CONSTRAINT [PK_SelectTypeModelMajor] PRIMARY KEY CLUSTERED 
(
	[SmIdx] ASC,
	[MajorCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SelectTypeModelMajor] ADD  CONSTRAINT [DF_SelectTypeModelMajor_MajorPersonnelAdd]  DEFAULT ((0)) FOR [MajorPersonnelAdd]
GO

ALTER TABLE [dbo].[SelectTypeModelMajor]  WITH CHECK ADD  CONSTRAINT [FK_SelectTypeModelMajor_InfoMajor] FOREIGN KEY([IpsiYear], [IpsiGubun], [MajorCode])
REFERENCES [dbo].[InfoMajor] ([IpsiYear], [IpsiGubun], [MajorCode])
GO

ALTER TABLE [dbo].[SelectTypeModelMajor] CHECK CONSTRAINT [FK_SelectTypeModelMajor_InfoMajor]
GO

ALTER TABLE [dbo].[SelectTypeModelMajor]  WITH CHECK ADD  CONSTRAINT [FK_SelectTypeModelMajor_SelectTypeModel] FOREIGN KEY([SmIdx])
REFERENCES [dbo].[SelectTypeModel] ([SmIdx])
GO

ALTER TABLE [dbo].[SelectTypeModelMajor] CHECK CONSTRAINT [FK_SelectTypeModelMajor_SelectTypeModel]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전형모델관리_Detail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SelectTypeModelMajor'
GO

-- 3. APPLYINFO
USE [JEMSv4]
GO

/****** 개체: Table [dbo].[ApplyInfo] 스크립트 날짜: 2026-09-01 오전 9:39:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ApplyInfo](
	[IpsiYear] [smallint] NOT NULL,
	[IpsiGubun] [tinyint] NOT NULL,
	[SuhumNo] [varchar](20) NOT NULL,
	[CampusID] [smallint] NULL,
	[GunID] [smallint] NOT NULL,
	[SelTypeCode] [varchar](10) NULL,
	[MajorCode] [varchar](10) NULL,
	[StuKorName] [varchar](50) NULL,
	[StuHanName] [varchar](30) NULL,
	[StuEngName] [varchar](50) NULL,
	[StuEngLastName] [varchar](30) NULL,
	[MemSSN] [varchar](20) NULL,
	[Gender] [varchar](2) NULL,
	[StuTypeCode] [varchar](10) NULL,
	[UseHSB] [char](1) NULL,
	[GraduateDate] [varchar](30) NULL,
	[NEISCode] [char](10) NULL,
	[GraduateName] [varchar](100) NULL,
	[HighType] [varchar](10) NULL,
	[Zip] [varchar](7) NULL,
	[Address1] [varchar](200) NULL,
	[Address2] [varchar](200) NULL,
	[Tel] [varchar](30) NULL,
	[Mobile] [varchar](30) NULL,
	[Email] [varchar](100) NULL,
	[ApplyTime] [datetime] NULL,
	[SATNo] [varchar](10) NULL,
	[SATOnLine] [char](1) NULL,
	[RefundBank] [varchar](10) NULL,
	[RefundAccNo] [varchar](30) NULL,
	[RefundName] [varchar](50) NULL,
	[RefundRelation] [varchar](20) NULL,
	[ApplyGubun] [varchar](10) NULL,
	[Nationality] [varchar](10) NULL,
	[Reception] [varchar](10) NULL,
	[CrDate] [datetime] NULL,
	[MdDate] [datetime] NULL,
	[RefundReturnType] [varchar](10) NULL,
	[IsSMS] [char](1) NULL,
	[IsPersonalInfo] [char](1) NULL,
	[IsBanMultiNDuple] [char](1) NULL,
	[IsOneSelf] [char](1) NULL,
	[ApplyPrice] [int] NULL,
	[Commission] [int] NULL,
	[EncMemSSN] [varbinary](148) NULL,
	[HashMemSSN] [varbinary](32) NULL,
	[EncRefundAccNo] [varbinary](148) NULL,
	[MajorCode2] [varchar](10) NULL,
	[SubMajorCode] [varchar](10) NULL,
	[MinorCode] [varchar](10) NULL,
	[GEDNo] [varchar](18) NULL,
	[UserID] [varchar](50) NULL,
	[UserIP] [varchar](23) NULL,
	[GEDOnLine] [char](1) NULL,
	[ADDCONTACT1] [varchar](30) NULL,
	[ADDCONTACT2] [varchar](30) NULL,
	[ADDCONTACT3] [varchar](30) NULL,
	[ADDCONTACT4] [varchar](30) NULL,
	[ADDCONTACT5] [varchar](30) NULL,
	[ADDCONTACT6] [varchar](30) NULL,
 CONSTRAINT [PK_ApplyInfo] PRIMARY KEY CLUSTERED 
(
	[IpsiYear] ASC,
	[IpsiGubun] ASC,
	[SuhumNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ApplyInfo] ADD  CONSTRAINT [DF_ApplyInfo_CampusID]  DEFAULT ((1)) FOR [CampusID]
GO

ALTER TABLE [dbo].[ApplyInfo] ADD  CONSTRAINT [DF_ApplyInfo_GunID]  DEFAULT ((0)) FOR [GunID]
GO

ALTER TABLE [dbo].[ApplyInfo] ADD  CONSTRAINT [DF_ApplyInfo_CrDate]  DEFAULT (getdate()) FOR [CrDate]
GO

ALTER TABLE [dbo].[ApplyInfo]  WITH CHECK ADD  CONSTRAINT [FK_ApplyInfo_InfoCampus] FOREIGN KEY([CampusID])
REFERENCES [dbo].[InfoCampus] ([CampusID])
GO

ALTER TABLE [dbo].[ApplyInfo] CHECK CONSTRAINT [FK_ApplyInfo_InfoCampus]
GO

ALTER TABLE [dbo].[ApplyInfo]  WITH CHECK ADD  CONSTRAINT [FK_ApplyInfo_InfoGun] FOREIGN KEY([GunID])
REFERENCES [dbo].[InfoGun] ([GunID])
GO

ALTER TABLE [dbo].[ApplyInfo] CHECK CONSTRAINT [FK_ApplyInfo_InfoGun]
GO

ALTER TABLE [dbo].[ApplyInfo]  WITH CHECK ADD  CONSTRAINT [FK_ApplyInfo_InfoMajor] FOREIGN KEY([IpsiYear], [IpsiGubun], [MajorCode])
REFERENCES [dbo].[InfoMajor] ([IpsiYear], [IpsiGubun], [MajorCode])
GO

ALTER TABLE [dbo].[ApplyInfo] CHECK CONSTRAINT [FK_ApplyInfo_InfoMajor]
GO

ALTER TABLE [dbo].[ApplyInfo]  WITH CHECK ADD  CONSTRAINT [FK_ApplyInfo_InfoSelectType] FOREIGN KEY([IpsiYear], [IpsiGubun], [SelTypeCode])
REFERENCES [dbo].[InfoSelectType] ([IpsiYear], [IpsiGubun], [SelTypeCode])
GO

ALTER TABLE [dbo].[ApplyInfo] CHECK CONSTRAINT [FK_ApplyInfo_InfoSelectType]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입학연도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'IpsiYear'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'모집시기' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'IpsiGubun'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수험번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'SuhumNo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캠퍼스' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'CampusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'모집군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'GunID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전형구분코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'SelTypeCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'모집단위코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'MajorCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성명(한글)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'StuKorName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성명(한자)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'StuHanName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성명(영문)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'StuEngName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성명(영문성)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'StuEngLastName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주민등록번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'MemSSN'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'남여구분' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Gender'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자구분' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'StuTypeCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학생부사용동의' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'UseHSB'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'졸업년도(합격년도)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'GraduateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출신고교코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'NEISCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출신고교명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'GraduateName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자집 우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Zip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자집 주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Address1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자집 상세주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Address2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자 자택전화' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Tel'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자 휴대전화' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Mobile'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자 E-Mail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Email'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'접수일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'ApplyTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수능사용동의' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'SATOnLine'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'환불은행코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'RefundBank'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'환불계좌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'RefundAccNo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'환불계좌 예금주명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'RefundName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'실기고사코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'ApplyGubun'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'국적' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'Nationality'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'개인정보제3자 제공에 대한 동의' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'IsPersonalInfo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검정고시제공동의 확인번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'GEDNo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검정고시 동의여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo', @level2type=N'COLUMN',@level2name=N'GEDOnLine'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지원자 기본정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplyInfo'
GO


-- 4. CODEFORMATION(CF)
CREATE TABLE [dbo].[CodeFormation](
	[IpsiYear] [smallint] NOT NULL,
	[IpsiGubun] [tinyint] NOT NULL,
	[OrganizationCode] [varchar](20) NOT NULL,
	[CourseCode] [varchar](10) NOT NULL,
	[SubjectCode] [varchar](10) NOT NULL,
	[OrganizationName] [varchar](90) NULL,
	[CourseName] [varchar](50) NULL,
	[SubjectName] [varchar](150) NULL,
	[VersionCode] [smallint] NULL,
	[CourseGubun] [char](1) NULL,
	[IsCourse] [char](1) NULL,
	[CdIdx] [varchar](10) NULL,
 CONSTRAINT [PK_CodeFormation] PRIMARY KEY CLUSTERED 
(
	[IpsiYear] ASC,
	[IpsiGubun] ASC,
	[OrganizationCode] ASC,
	[CourseCode] ASC,
	[SubjectCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CodeFormation]  WITH CHECK ADD  CONSTRAINT [FK_CodeFormation_InfoIpsi] FOREIGN KEY([IpsiYear], [IpsiGubun])
REFERENCES [dbo].[InfoIpsi] ([IpsiYear], [IpsiGubun])
GO

ALTER TABLE [dbo].[CodeFormation] CHECK CONSTRAINT [FK_CodeFormation_InfoIpsi]
GO

-- 5. HSBSUBJECTSCORE(HSS)
CREATE TABLE [dbo].[HsbSubjectScore](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[IpsiGubun] [tinyint] NOT NULL,
	[IpsiYear] [smallint] NOT NULL,
	[SuhumNo] [varchar](20) NOT NULL,
	[NEISCode] [char](10) NOT NULL,
	[Grade] [int] NULL,
	[Term] [int] NULL,
	[MemSSN] [varchar](14) NULL,
	[OrganizationCode] [varchar](30) NULL,
	[OrganizationName] [varchar](90) NULL,
	[CourseCode] [varchar](10) NULL,
	[CourseName] [varchar](60) NULL,
	[SubjectCode] [varchar](30) NULL,
	[SubjectName] [varchar](150) NULL,
	[IsuUnit] [decimal](6, 1) NULL,
	[Assessment] [varchar](20) NULL,
	[HsbRank] [smallint] NULL,
	[StudentCount] [smallint] NULL,
	[OriginalScore] [int] NULL,
	[AvgScore] [numeric](4, 1) NULL,
	[StandardDeviation] [varchar](10) NULL,
	[RankingGrade] [varchar](10) NULL,
	[IsDirect] [char](1) NULL,
	[CrDate] [datetime] NULL,
	[MdDate] [datetime] NULL,
	[Year] [char](4) NULL,
	[IsCalc] [smallint] NULL,
	[SameRank] [smallint] NULL,
	[SeqNumber] [smallint] NOT NULL,
	[RankingScore] [decimal](6, 2) NULL,
	[StdRankingGrade] [varchar](10) NULL,
	[RankingGradeCode] [varchar](20) NULL,
	[Achievement] [varchar](20) NULL,
	[AchievementCode] [varchar](20) NULL,
	[IdentifyNumber] [varchar](255) NULL,
	[AchievementRatio] [varchar](600) NULL,
	[SubjectSeparationCode] [varchar](10) NULL,
	[CalcRank] [int] NULL,
 CONSTRAINT [PK_HsbSubjectScore] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY],
 CONSTRAINT [IX_HsbSubjectScore] UNIQUE NONCLUSTERED 
(
	[IpsiYear] ASC,
	[IpsiGubun] ASC,
	[SuhumNo] ASC,
	[NEISCode] ASC,
	[Grade] ASC,
	[Term] ASC,
	[OrganizationCode] ASC,
	[CourseCode] ASC,
	[SubjectCode] ASC,
	[Year] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO


--6. INFOMAJOR(IM)
CREATE TABLE [dbo].[InfoMajor](
	[IpsiYear] [smallint] NOT NULL,
	[IpsiGubun] [tinyint] NOT NULL,
	[MajorCode] [varchar](10) NOT NULL,
	[MajorType] [varchar](5) NULL,
	[MajorName] [varchar](50) NOT NULL,
	[College] [varchar](5) NULL,
	[Department] [varchar](5) NOT NULL,
	[MacYear] [smallint] NOT NULL,
	[MajorAreaCode] [varchar](10) NOT NULL,
	[FlagJuYa] [char](1) NULL,
	[IsUse] [char](1) NOT NULL,
	[DisplayOrder] [smallint] NULL,
	[ERPCode] [varchar](20) NULL,
	[ERPCode1] [varchar](20) NULL,
	[ERPCode2] [varchar](20) NULL,
	[etc1] [varchar](50) NULL,
	[etc2] [varchar](50) NULL,
	[SubMajorCode] [varchar](10) NULL,
	[KosafCode] [varchar](20) NULL,
 CONSTRAINT [PK_InfoMajor] PRIMARY KEY CLUSTERED 
(
	[IpsiYear] ASC,
	[IpsiGubun] ASC,
	[MajorCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[InfoMajor]  WITH CHECK ADD  CONSTRAINT [FK_InfoMajor_InfoIpsi] FOREIGN KEY([IpsiYear], [IpsiGubun])
REFERENCES [dbo].[InfoIpsi] ([IpsiYear], [IpsiGubun])
GO

ALTER TABLE [dbo].[InfoMajor] CHECK CONSTRAINT [FK_InfoMajor_InfoIpsi]
GO

ALTER TABLE [dbo].[InfoMajor]  WITH CHECK ADD  CONSTRAINT [FK_InfoMajor_InfoMajorArea] FOREIGN KEY([MacYear], [MajorAreaCode])
REFERENCES [dbo].[InfoMajorArea] ([IpsiYear], [MajorAreaCode])
GO

ALTER TABLE [dbo].[InfoMajor] CHECK CONSTRAINT [FK_InfoMajor_InfoMajorArea]
GO

-- 7. INFOMAJORAREA(IMA)
CREATE TABLE [dbo].[InfoMajorArea](
	[IpsiYear] [smallint] NOT NULL,
	[MajorAreaCode] [varchar](10) NOT NULL,
	[MajorAreaName] [varchar](50) NOT NULL,
	[MajorType] [varchar](5) NOT NULL,
	[MaPersonnel] [smallint] NOT NULL,
	[MaFixedNum] [smallint] NULL,
	[IsUse] [char](1) NOT NULL,
	[DisplayOrder] [smallint] NULL,
	[StdMajorCode] [varchar](20) NULL,
	[ERPCode] [varchar](20) NULL,
	[ERPOrder] [int] NULL,
	[ERPCode2] [varchar](20) NULL,
	[Bigo1] [varchar](100) NULL,
	[Bigo2] [varchar](100) NULL,
	[DtpRegCode] [varchar](20) NULL,
	[DtpSclCode] [varchar](20) NULL,
	[CampusID] [varchar](10) NULL,
	[DptKCUE] [varchar](20) NULL,
	[DptRegCode] [varchar](20) NULL,
	[DptSclCode] [varchar](20) NULL,
	[MajorAreaEngName] [varchar](50) NULL,
	[MAPERSONNELYA] [smallint] NULL,
	[MAFIXEDNUMYA] [smallint] NULL,
	[HAKJE] [varchar](10) NULL,
 CONSTRAINT [PK_InfoMajorArea] PRIMARY KEY CLUSTERED 
(
	[IpsiYear] ASC,
	[MajorAreaCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[InfoMajorArea] ADD  CONSTRAINT [DF_InfoMajorArea_IsUse]  DEFAULT ('1') FOR [IsUse]
GO