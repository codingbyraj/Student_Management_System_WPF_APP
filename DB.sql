USE [master]
GO
/****** Object:  Database [demo]    Script Date: 13-08-2018 12:37:00 ******/
CREATE DATABASE [demo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'demo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\demo.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'demo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\demo_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [demo] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [demo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [demo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [demo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [demo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [demo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [demo] SET ARITHABORT OFF 
GO
ALTER DATABASE [demo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [demo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [demo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [demo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [demo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [demo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [demo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [demo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [demo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [demo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [demo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [demo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [demo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [demo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [demo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [demo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [demo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [demo] SET RECOVERY FULL 
GO
ALTER DATABASE [demo] SET  MULTI_USER 
GO
ALTER DATABASE [demo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [demo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [demo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [demo] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [demo] SET DELAYED_DURABILITY = DISABLED 
GO
USE [demo]
GO
/****** Object:  UserDefinedTableType [dbo].[TT_Subject_INTER_TABLE]    Script Date: 13-08-2018 12:37:01 ******/
CREATE TYPE [dbo].[TT_Subject_INTER_TABLE] AS TABLE(
	[IID] [nvarchar](100) NOT NULL,
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SubjectCategoryId] [int] NOT NULL,
	[Status] [bit] NOT NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fncIID]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fncIID]()
RETURNS VARCHAR(50)
AS
BEGIN

DECLARE @returnValue CHAR(8)
DECLARE @IID VARCHAR(50)
DECLARE @wkMonth CHAR(2)
DECLARE @wkDay CHAR(2)
DECLARE @wkYear CHAR(4)
DECLARE @wkHour CHAR(2)
DECLARE @wkMin CHAR(2)
DECLARE @wkSec CHAR(2)
DECLARE @wkHr VARCHAR(50)


SELECT @wkYear = CONVERT(CHAR(4), DATEPART(yyyy, GETDATE())) 
 IF CONVERT(INT, DATEPART(mm, GETDATE())) < 10
  BEGIN
  SELECT @wkMonth = '0' + CONVERT(CHAR(1), DATEPART(mm, GETDATE())) 
  END
 ELSE
  BEGIN
  SELECT @wkMonth = CONVERT(CHAR(2), DATEPART(mm, GETDATE())) 
  END
 IF CONVERT(INT, DATEPART(dd, GETDATE())) < 10
  BEGIN
  SELECT @wkDay = '0' + CONVERT(CHAR(1), DATEPART(dd, GETDATE())) 
  END
 ELSE
  BEGIN
  SELECT @wkDay = CONVERT(CHAR(2), DATEPART(dd, GETDATE())) 
  END
 IF CONVERT(INT, DATEPART(hh, GETDATE())) < 10
  BEGIN
  SELECT @wkHour = '0' + CONVERT(CHAR(1), DATEPART(hh, GETDATE())) 
  END
 ELSE
  BEGIN
  SELECT @wkHour = CONVERT(CHAR(2), DATEPART(hh, GETDATE())) 
  END
 IF CONVERT(INT, DATEPART(mi, GETDATE())) < 10
  BEGIN
  SELECT @wkMin = '0' + CONVERT(CHAR(1), DATEPART(mi, GETDATE())) 
  END
 ELSE
  BEGIN
  SELECT @wkMin = CONVERT(CHAR(2), DATEPART(mi, GETDATE())) 
  END
 IF CONVERT(INT, DATEPART(ss, GETDATE())) < 10
  BEGIN
  SELECT @wkSec = '0' + CONVERT(CHAR(1), DATEPART(ss, GETDATE())) 
  END
 ELSE
  BEGIN
  SELECT @wkSec = CONVERT(CHAR(2), DATEPART(ss, GETDATE())) 
  END
  
 SELECT @wkHR  = CONVERT(VARCHAR(3), DATEPART(ms, GETDATE()))
 
 IF CONVERT(INT, @wkHR) < 10
  BEGIN
  SELECT @wkHR  = '00' + @wkHR 
  END
 ELSE IF CONVERT(INT, @wkHR) < 100
  BEGIN
  SELECT @wkHR  = '0' + @wkHR 
  END 

 SELECT @IID = @wkYear + @wkMonth + @wkDay + @wkHour + @wkMin + @wkSec + @wkHR
ExitFunction:
 RETURN(@IID)
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetHighestMarks]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetHighestMarks](@StudID INT)
RETURNS INT
AS
BEGIN

DECLARE @Marks INT = 0
SELECT TOP 1 @Marks= MARKS FROM STUDENTMARKS WHERE StudID=@StudID

RETURN @Marks
END




GO
/****** Object:  UserDefinedFunction [dbo].[GetNameByRoll]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetNameByRoll](@StudID INT)
RETURNS varchar(50)
AS
BEGIN

DECLARE @Name varchar(50) = ''
SELECT TOP 1 @Name= name FROM Student WHERE Id=@StudID

RETURN @Name
END


GO
/****** Object:  Table [dbo].[JobOrderRelease]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOrderRelease](
	[RID] [int] IDENTITY(201,1) NOT NULL,
	[JobOrderId] [int] NOT NULL,
	[ReleaseNo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobOrderSpecCom]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOrderSpecCom](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[JobOrderId] [int] NOT NULL,
	[JobOrderReleaseId] [int] NOT NULL,
	[X] [nvarchar](50) NOT NULL,
	[Y] [nvarchar](50) NOT NULL,
	[Z] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JobOrderSpecCom] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Stream] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentMarks]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentMarks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[Marks] [int] NOT NULL,
 CONSTRAINT [PK_StudentMarks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentSubjectMarks]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentSubjectMarks](
	[StudentId] [int] NULL,
	[SubjectId] [int] NULL,
	[Marks] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Subject_Inter_Table]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject_Inter_Table](
	[IID] [nvarchar](100) NOT NULL,
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SubjectCategoryId] [int] NOT NULL,
	[Status] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubjectMaster]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubjectMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[SubjectCategoryId] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubjectStreamMaster]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubjectStreamMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[JobOrderSpecCom]  WITH CHECK ADD  CONSTRAINT [FK_JobOrderSpecCom_JobOrderRelease] FOREIGN KEY([JobOrderReleaseId])
REFERENCES [dbo].[JobOrderRelease] ([RID])
GO
ALTER TABLE [dbo].[JobOrderSpecCom] CHECK CONSTRAINT [FK_JobOrderSpecCom_JobOrderRelease]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_SubjectStreamMaster] FOREIGN KEY([Stream])
REFERENCES [dbo].[SubjectStreamMaster] ([Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_SubjectStreamMaster]
GO
ALTER TABLE [dbo].[StudentMarks]  WITH CHECK ADD  CONSTRAINT [FK_StudentMarks_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[StudentMarks] CHECK CONSTRAINT [FK_StudentMarks_Student]
GO
ALTER TABLE [dbo].[StudentMarks]  WITH CHECK ADD  CONSTRAINT [FK_StudentMarks_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SubjectMaster] ([Id])
GO
ALTER TABLE [dbo].[StudentMarks] CHECK CONSTRAINT [FK_StudentMarks_Subject]
GO
ALTER TABLE [dbo].[StudentSubjectMarks]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[StudentSubjectMarks]  WITH CHECK ADD FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SubjectMaster] ([Id])
GO
ALTER TABLE [dbo].[SubjectStreamMaster]  WITH CHECK ADD  CONSTRAINT [FK_SubjectStreamMaster_SubjectStreamMaster] FOREIGN KEY([Id])
REFERENCES [dbo].[SubjectStreamMaster] ([Id])
GO
ALTER TABLE [dbo].[SubjectStreamMaster] CHECK CONSTRAINT [FK_SubjectStreamMaster_SubjectStreamMaster]
GO
ALTER TABLE [dbo].[StudentSubjectMarks]  WITH CHECK ADD CHECK  (([Marks]>=(0) AND [Marks]<=(100)))
GO
/****** Object:  StoredProcedure [dbo].[CheckUserLogin]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckUserLogin]
@UserName NVARCHAR(50),
@Password NVARCHAR(50)	
AS
DECLARE @Id INT = 0
BEGIN
	SELECT @Id = Id FROM Users WHERE Username = @UserName AND Password = @Password
	SELECT @Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetMarks]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- this procedure is not used in the applicaiton.
-- for getting marks of student go to GetStudentMarks store procedure

CREATE PROCEDURE [dbo].[GetMarks]
@StudentId INT
AS
DECLARE @StudentName NVARCHAR(50)
DECLARE @StreamId INT
DECLARE @Id INT
BEGIN					
	SELECT @Id = Id FROM Student WHERE Id = @StudentId	
	IF (@ID > 0)
	BEGIN
		-- get stream of student
		SELECT @StreamId = Stream, @StudentName = Name from Student WHERE Id = @StudentId	

		
		IF EXISTS
		(
		SELECT stdm.SubjectId SubjectId, subm.Name SubjectName, stdm.Marks Marks		
		FROM StudentMarks stdm		
		INNER JOIN SubjectMaster subm
		ON stdm.SubjectId = subm.Id
		WHERE 
		StudentId = @StudentId AND 
		stdm.SubjectId IN (SELECT sm.Id FROM SubjectMaster sm WHERE sm.SubjectCategoryId = @StreamId)			
		)
		BEGIN
		
			SELECT stdm.SubjectId SubjectId, subm.Name SubjectName, stdm.Marks Marks		
			FROM StudentMarks stdm		
			INNER JOIN SubjectMaster subm
			ON stdm.SubjectId = subm.Id
			WHERE 
			StudentId = @StudentId AND 
			stdm.SubjectId IN (SELECT sm.Id FROM SubjectMaster sm WHERE sm.SubjectCategoryId = @StreamId)			
			
		END
		else
		begin
			SELECT subm.Id SubjectId, subm.Name SubjectName, -1 AS Marks
			FROM SubjectMaster subm			
			WHERE 			
			subm.Id IN (SELECT sm.Id FROM SubjectMaster sm WHERE sm.SubjectCategoryId = @StreamId)				
		end
	END			
END

GO
/****** Object:  StoredProcedure [dbo].[GetStudentMarks]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStudentMarks]
@StudentId INT
AS
DECLARE @Id INT
BEGIN
SELECT @Id = Id FROM Student WHERE Id = @StudentId	
	IF (@ID > 0)
	BEGIN
		SELECT st.Id as StudentId, st.Name StudentName, sbm.id as SubjectId, sbm.Name SubjectName, 
		ISNULL(stm.Marks,0) AS StudentMarks 
		FROM Student st 
		INNER JOIN SubjectMaster sbm ON st.Stream=sbm.SubjectCategoryId
		LEFT JOIN StudentMarks stm ON st.Id=stm.StudentId AND sbm.Id=stm.SubjectId
		WHERE st.Id= @StudentId
	END
	ELSE
	BEGIN
		SELECT NULL
	END
END

GO
/****** Object:  StoredProcedure [dbo].[GetStudents]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetStudents]
AS
BEGIN
	SELECT s.Id Id, s.Name Name, s.Address Address, s.Mobile Mobile, s.Stream Stream,
	ssm.Name StreamName
	FROM Student s
	INNER JOIN SubjectStreamMaster ssm
	ON
	s.Stream = ssm.Id
END


GO
/****** Object:  StoredProcedure [dbo].[GetSubjectMaster]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSubjectMaster]
AS
BEGIN

SELECT Id, Name FROM SubjectStreamMaster AS SubjectMaster

END
GO
/****** Object:  StoredProcedure [dbo].[GetSubjects]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSubjects]
AS
BEGIN
	SELECT sm.Id Id, sm.Name SubjectName, sm.SubjectCategoryId SubjectCategoryId , 
	sm.Status Status, scm.Name SubjectCategoryName
	FROM SubjectMaster sm
	INNER JOIN SubjectStreamMaster scm
	ON
	sm.SubjectCategoryId = scm.Id
END
GO
/****** Object:  StoredProcedure [dbo].[Merge_SubjectMaster_SubjectInterTable]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Merge_SubjectMaster_SubjectInterTable]
(
@IID NVARCHAR(50)
)
AS
BEGIN

CREATE TABLE #TEMP_SOURCE
(
IID NVARCHAR(50),
Id INT,
Name NVARCHAR(50),
SubjectCategoryId INT,
Status BIT
)

INSERT INTO #TEMP_SOURCE SELECT * FROM Subject_Inter_Table WHERE IID = @IID

MERGE SubjectMaster AS TARGET
USING #TEMP_SOURCE AS SOURCE
ON (TARGET.Id = SOURCE.Id)

WHEN MATCHED AND (SOURCE.IId = @IID) AND (TARGET.Id = SOURCE.Id) AND (TARGET.Name <> SOURCE.Name OR 
				 TARGET.SubjectCategoryId <> SOURCE.SubjectCategoryId OR
				 TARGET.Status <> SOURCE.Status)
	THEN	
	UPDATE SET TARGET.Name = SOURCE.Name, TARGET.SubjectCategoryId = SOURCE.SubjectCategoryId,
			   TARGET.Status = SOURCE.Status

WHEN NOT MATCHED BY TARGET AND (SOURCE.IId = @IID ) THEN
	INSERT (Name, SubjectCategoryId, Status) VALUES (SOURCE.Name, SOURCE.SubjectCategoryId, SOURCE.Status)		

WHEN NOT MATCHED BY SOURCE 		 
	THEN
	DELETE;

SELECT @@ROWCOUNT;
END
GO
/****** Object:  StoredProcedure [dbo].[SaveDataToInterTable]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaveDataToInterTable]
(
@IID NVARCHAR(50),
@Id INT,
@Name NVARCHAR(50),
@SubjectCategoryId INT,
@Status BIT
)
AS
BEGIN

INSERT INTO Subject_Inter_Table (IID, Id, Name, SubjectCategoryId, Status) 
	VALUES (@IID, @Id, @Name, @SubjectCategoryId, @Status)

END
GO
/****** Object:  StoredProcedure [dbo].[SaveToInterTable]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaveToInterTable]
(
 @tblInterTable TT_Subject_INTER_TABLE READONLY
)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO Subject_Inter_Table (IID, Id, Name, SubjectCategoryId, Status)
	SELECT IID, Id, Name, SubjectCategoryId, Status FROM @tblInterTable
END


GO
/****** Object:  StoredProcedure [dbo].[SelfJoinExample]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelfJoinExample]
(
@JobOrderId INT,
@ReleaseNo INT
)
AS
DECLARE @JobOrderReleaseId INT,
@LastRID INT
BEGIN
	SELECT @JobOrderReleaseId = RID FROM JobOrderRelease
		WHERE ReleaseNo = 0
	INSERT INTO JobOrderRelease VALUES (@JobOrderId, @ReleaseNo)
	SELECT @LastRID = SCOPE_IDENTITY()
	  
	INSERT INTO JobOrderSpecCom (JobOrderId, JobOrderReleaseId, X, Y ,Z)
	select JobOrderId ,@LastRID, X, Y ,Z from JobOrderSpecCom
	where JobOrderReleaseId = @JobOrderReleaseId
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateMarks]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMarks]
@StudentId INT,
@SubjectId INT,
@Marks INT
AS
BEGIN

 
 IF EXISTS(SELECT * FROM StudentMarks WHERE StudentId = @StudentId AND SubjectId = @SubjectId)
 BEGIN
	UPDATE StudentMarks SET Marks = @Marks 
	WHERE StudentId = @StudentId AND SubjectId = @SubjectId
 END
 
 ELSE  -- If marks is not already given 
 BEGIN
	INSERT INTO StudentMarks (StudentId, SubjectId, Marks) VALUES (@StudentId, @SubjectId, @Marks)
 END

 

 SELECT st.Id as StudentId, st.Name StudentName, sbm.id as SubjectId, sbm.Name SubjectName, 
		ISNULL(stm.Marks,0) AS StudentMarks 
		FROM Student st 
		INNER JOIN SubjectMaster sbm ON st.Stream=sbm.SubjectCategoryId
		LEFT JOIN StudentMarks stm ON st.Id=stm.StudentId AND sbm.Id=stm.SubjectId
		WHERE st.Id= @StudentId

END


GO
/****** Object:  StoredProcedure [dbo].[UpdateStudent]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStudent]
(
@Id INT,
@Name VARCHAR(100),
@Address VARCHAR(100),
@Mobile VARCHAR(100),
@Stream INT,
@IsDelete BIT
)
AS
DECLARE @Result INT = 0;
BEGIN
	IF(@IsDelete = 1 and @Id > 0) -- DELETE
	BEGIN
		DELETE FROM Student WHERE Id = @Id
		SET @Result = @Id
	END
	ELSE IF(@Id = 0) -- INSERT
	BEGIN
		INSERT INTO Student (Name, Mobile, Address, Stream) VALUES(@Name, @Mobile, @Address, @Stream)
		SET @Result = SCOPE_IDENTITY()
	END
	ELSE IF(@Id <> 0) -- UPDATE
	BEGIN
		UPDATE Student SET Name = @Name, Address = @Address, Mobile = @Mobile, Stream = @Stream 
		WHERE Id = @Id
		SET @Result = @Id
	END			
	SELECT @Result AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSubjects]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSubjects]
AS
BEGIN
	SELECT SubjectMaster.Id, SubjectMaster.Name, SubjectMaster.Status, SubjectCategoryMaster.Name
	FROM SubjectMaster
	INNER JOIN SubjectCategoryMaster
	ON
	SubjectMaster.SubjectCategoryId = SubjectCategoryMaster.Id
END

--insert into SubjectMaster values('Chem', 1, 1)
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 13-08-2018 12:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]	
@Id INT = 0,
@Username NVARCHAR(50),
@Password NVARCHAR(50),
@Type NVARCHAR(50),
@IsDelete BIT = FALSE
AS
DECLARE @Result INT = 0
BEGIN
	IF(@IsDelete = 1 AND @Id > 0)
	BEGIN
		DELETE FROM Users WHERE Id = @Id
		SET @Result = @Id
	END
	ELSE IF(@Id = 0)
	BEGIN
		INSERT INTO Users VALUES(@Username, @Password, @Type)
		SET @Result = SCOPE_IDENTITY()
	END

	ELSE IF(@Id > 0)
	BEGIN
		UPDATE Users SET Username = @Username, Password = @Password, TYPE = @Type 
		WHERE Id = @Id
		SET @Result = @Id
	END
	RETURN @Result
END
GO
USE [master]
GO
ALTER DATABASE [demo] SET  READ_WRITE 
GO
