USE [master]
GO
/****** Object:  Database [GraphExample]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'GraphExample')
BEGIN
CREATE DATABASE [GraphExample]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GraphExample', FILENAME = N'E:\DATA\MSSQL14.MSSQLSERVER\MSSQL\DATA\GraphExample.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GraphExample_log', FILENAME = N'E:\SQLLog\GraphExample_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE Latin1_General_CI_AS
END
GO
ALTER DATABASE [GraphExample] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GraphExample].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GraphExample] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GraphExample] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GraphExample] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GraphExample] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GraphExample] SET ARITHABORT OFF 
GO
ALTER DATABASE [GraphExample] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GraphExample] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GraphExample] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GraphExample] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GraphExample] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GraphExample] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GraphExample] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GraphExample] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GraphExample] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GraphExample] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GraphExample] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GraphExample] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GraphExample] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GraphExample] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GraphExample] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GraphExample] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GraphExample] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GraphExample] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GraphExample] SET  MULTI_USER 
GO
ALTER DATABASE [GraphExample] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GraphExample] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GraphExample] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GraphExample] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GraphExample] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GraphExample', N'ON'
GO
ALTER DATABASE [GraphExample] SET QUERY_STORE = OFF
GO
USE [GraphExample]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [GraphExample]
GO
/****** Object:  User [NT-AUTORITÄT\IUSR]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'NT-AUTORITÄT\IUSR')
CREATE USER [NT-AUTORITÄT\IUSR] FOR LOGIN [NT-AUTORITÄT\IUSR]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT-AUTORITÄT\IUSR]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT-AUTORITÄT\IUSR]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT-AUTORITÄT\IUSR]
GO
/****** Object:  Schema [Forum]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Forum')
EXEC sys.sp_executesql N'CREATE SCHEMA [Forum]'
GO
/****** Object:  FullTextCatalog [ft_graph_post]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ft_graph_post')
CREATE FULLTEXT CATALOG [ft_graph_post] WITH ACCENT_SENSITIVITY = ON
GO
USE [GraphExample]
GO
/****** Object:  Sequence [dbo].[Seq_Likes]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = N'Seq_Likes' AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
CREATE SEQUENCE [dbo].[Seq_Likes] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
END
GO
USE [GraphExample]
GO
/****** Object:  Sequence [dbo].[Seq_Replay_To]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = N'Seq_Replay_To' AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
CREATE SEQUENCE [dbo].[Seq_Replay_To] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
END
GO
USE [GraphExample]
GO
/****** Object:  Sequence [dbo].[Seq_Written_By]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = N'Seq_Written_By' AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
CREATE SEQUENCE [dbo].[Seq_Written_By] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
END
GO
/****** Object:  UserDefinedFunction [dbo].[udf_Txt_IsEmail]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udf_Txt_IsEmail]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[udf_Txt_IsEmail] (
 @EmailAddr varchar(255) -- Email address to check
)   RETURNS BIT -- 1 if @EmailAddr is a valid email address
/*
* Checks an text string to be sure it''s a valid e-mail address.
* Returns 1 when it is, otherwise 0.
* Example:
SELECT CASE WHEN 1=dbo.udf_Txt_IsEmail(''anovick@NovickSoftware.com'')
    THEN ''Is an e-mail address'' ELSE ''Not an e-mail address'' END
*
* Test:
print case when 1=dbo.udf_txt_isEmail(''anovick@novicksoftware.com'')
       then ''Passes'' else ''Fails'' end + '' test for good addr''
print case when 0=dbo.udf_txt_isEmail(''@novicksoftware.com'')
       then ''Passes'' else ''Fails'' end + '' test for no user''
print case when 0=dbo.udf_txt_isEmail(''anovick@n.com'')
       then ''Passes'' else ''Fails'' end + '' test for 1 char domain''
print case when 1=dbo.udf_txt_isEmail(''anovick@no.com'')
       then ''Passes'' else ''Fails'' end + '' test for 2 char domain''
print case when 0=dbo.udf_txt_isEmail(''anovick@.com'')
       then ''Passes'' else ''Fails'' end + '' test for no domain''
print case when 0=dbo.udf_txt_isEmail(''anov ick@novicksoftware.com'')
       then ''Passes'' else ''Fails'' end + '' test for space in name''
print case when 0=dbo.udf_txt_isEmail(''ano#vick@novicksoftware.com'')
       then ''Passes'' else ''Fails'' end + '' test for # in user''
print case when 0=dbo.udf_txt_isEmail(''anovick@novick*software.com'')
       then ''Passes'' else ''Fails'' end + '' test for * asterisk in domain''
****************************************************************/
AS BEGIN
DECLARE @AlphabetPlus VARCHAR(255)
      , @Max INT -- Length of the address
      , @Pos INT -- Position in @EmailAddr
      , @OK BIT  -- Is @EmailAddr OK
-- Check basic conditions
IF @EmailAddr IS NULL 
   OR NOT @EmailAddr LIKE ''_%@__%.__%'' 
   OR CHARINDEX('' '',LTRIM(RTRIM(@EmailAddr))) > 0
       RETURN(0)
SELECT @AlphabetPlus = ''abcdefghijklmnopqrstuvwxyz01234567890_-.@''
     , @Max = LEN(@EmailAddr)
     , @Pos = 0
     , @OK = 1
WHILE @Pos < @Max AND @OK = 1 BEGIN
    SET @Pos = @Pos + 1
    IF NOT @AlphabetPlus LIKE ''%'' 
                             + SUBSTRING(@EmailAddr, @Pos, 1) 
                             + ''%'' 
        SET @OK = 0
END -- WHILE
RETURN @OK
END



' 
END
GO
/****** Object:  Table [Forum].[ForumOrt]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Forum].[ForumOrt]') AND type in (N'U'))
BEGIN
CREATE TABLE [Forum].[ForumOrt](
	[OrtID] [int] IDENTITY(1,1) NOT NULL,
	[Ort] [varchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
	[PLZ] [int] NOT NULL,
	[Kanton] [char](2) COLLATE Latin1_General_CI_AS NULL,
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[erfasstAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
 CONSTRAINT [PK_ForumOrt] PRIMARY KEY CLUSTERED 
(
	[OrtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
AS NODE ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[v_Ort]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_Ort]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[v_Ort]
AS
SELECT        PLZ, Ort, Kanton
FROM            Forum.ForumOrt
' 
GO
/****** Object:  Table [dbo].[ForumPosts]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ForumPosts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ForumPosts](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[PostTitle] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[PostBody] [varchar](1000) COLLATE Latin1_General_CI_AS NULL,
	[gepostedAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_ForumPosts] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
AS NODE ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ForumMembers]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ForumMembers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ForumMembers](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[MemberName] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[MemberVorname] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[erfasstAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
	[MemberStrasse] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[MemberMail] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[LogIn] [varchar](400) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_ForumMembers] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
AS NODE ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Written_By]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Written_By]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Written_By](
	[writtenByAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL
)
AS EDGE ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Reply_To]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reply_To]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Reply_To](
	[replyedAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL
)
AS EDGE ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[v_PostsAndMembersAndTheirReplies]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_PostsAndMembersAndTheirReplies]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[v_PostsAndMembersAndTheirReplies] AS
SELECT RepliedPost.PostId,RepliedPost.PostTitle,RepliedMember.MemberName,RepliedMember.MemberVorname,RepliedMember.MemberID,
		ReplyPost.PostId as ReplyId, ReplyPost.PostTitle as ReplyTitle, ReplyPost.PostBody, ReplyPost.öffentlicheIPv4
    FROM ForumPosts ReplyPost, Reply_to, ForumPosts RepliedPost, 
		ForumMembers RepliedMember, Written_By RepliedWritten_By
WHERE MATCH(ReplyPost-(Reply_to)->RepliedPost-(RepliedWritten_by)->RepliedMember)
' 
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Likes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Likes](
	[gelikedAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL
)
AS EDGE ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[v_TotalLikesOfEachPost]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_TotalLikesOfEachPost]'))
EXEC dbo.sp_executesql @statement = N'
CREATE view [dbo].[v_TotalLikesOfEachPost] as
 select ForumPosts.PostId, ForumPosts.PostTitle [Post-Title], count(*) [total Likes]
  from ForumPosts, Likes, ForumMembers
   where Match(ForumMembers-(Likes)->ForumPosts)
  group by PostId,PostTitle
' 
GO
/****** Object:  View [dbo].[v_TotalLikesOfEachMember]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_TotalLikesOfEachMember]'))
EXEC dbo.sp_executesql @statement = N'
-- Total likes of each Member
CREATE view [dbo].[v_TotalLikesOfEachMember] as
select Members.MemberId MembersMemberId, Members.MemberName [Members Name], 
		count(*) [total Likes], LikedMembers.MemberId LikedMembersMemberId, LikedMembers.MemberName [Liked Members-Name]
	from dbo.ForumMembers Members,Likes, dbo.ForumMembers LikedMembers
		where Match(Members-(Likes)->LikedMembers)
	group by LikedMembers.MemberId, LikedMembers.MemberName,Members.MemberName, Members.MemberId
' 
GO
/****** Object:  View [dbo].[v_PostGeschriebenVon]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_PostGeschriebenVon]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_PostGeschriebenVon] as
select MemberVorname,MemberName,PostID,PostTitle,PostBody,MemberID,m.erfasstAm,m.geändertAm,m.öffentlicheIPv4
from ForumMembers m, ForumPosts p,Written_By
  Where Match (p-(Written_By)->m)
' 
GO
/****** Object:  View [dbo].[v_Likes]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_Likes]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[v_Likes] AS
SELECT Post.PostID,Post.PostTitle,Member.MemberName,MemberID,Likes.[öffentlicheIPv4], Likes.[gelikedAm]
	FROM dbo.ForumPosts Post, Likes, dbo.ForumMembers Member
		WHERE MATCH(Member-(Likes)->Post)
' 
GO
/****** Object:  View [dbo].[v_CountOfRepliesOfEachPost]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_CountOfRepliesOfEachPost]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[v_CountOfRepliesOfEachPost] AS
-- SELECT * FROM [v_CountOfRepliesOfEachPost] WHERE [Total Replies]>0 
SELECT distinct
	RepliedPost.PostID,
	RepliedPost.PostTitle [Post-Title],
    RepliedPost.PostBody [Post],
    count(ReplyPost.PostID) over(partition by RepliedPost.PostID) as [Total Replies]
FROM ForumPosts ReplyPost, Reply_To, ForumPosts RepliedPost, ForumMembers, Written_By
  WHERE MATCH (ForumMembers<-(Written_By)-ReplyPost-(Reply_To)->RepliedPost ) 
' 
GO
/****** Object:  View [dbo].[v_AllRepliesWithTreeLevel]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_AllRepliesWithTreeLevel]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[v_AllRepliesWithTreeLevel] AS
with [root] as 
(select $node_id as node_id,RootPosts.PostId,
        RootPosts.PostTitle,
        1 as Level, 0 as ReplyTo
    from dbo.ForumPosts RootPosts
      where $node_id not in (select $from_id from dbo.reply_to) 
union all
    select $node_id,ReplyPost.PostId, ReplyPost.PostTitle,
        Level+1 as [Level], [root].PostId as ReplyTo
      from dbo.ForumPosts ReplyPost, reply_to, [root]
        where ReplyPost.$node_id=reply_to.$from_id 
          and [root].node_id=reply_to.$to_id
)
select PostId,PostTitle, Level, ReplyTo from [root]
' 
GO
/****** Object:  Table [dbo].[WohntIn]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WohntIn]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WohntIn](
	[öffentlicheIPv4] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[erfasstAm] [datetime] NULL,
	[geändertAm] [datetime] NULL,
	[seit] [datetime] NULL
)
AS EDGE ON [PRIMARY]
END
GO
/****** Object:  Table [Forum].[ForumMembers]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Forum].[ForumMembers]') AND type in (N'U'))
BEGIN
CREATE TABLE [Forum].[ForumMembers](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[MemberName] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Forum].[ForumPosts]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Forum].[ForumPosts]') AND type in (N'U'))
BEGIN
CREATE TABLE [Forum].[ForumPosts](
	[PostID] [int] NOT NULL,
	[PostTitle] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[PostBody] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[OwnerID] [int] NULL,
	[ReplyTo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Forum].[LikeMember]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Forum].[LikeMember]') AND type in (N'U'))
BEGIN
CREATE TABLE [Forum].[LikeMember](
	[MemberId] [int] NULL,
	[LikedMemberId] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [Forum].[Likes]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Forum].[Likes]') AND type in (N'U'))
BEGIN
CREATE TABLE [Forum].[Likes](
	[MemberId] [int] NULL,
	[PostId] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Index [GRAPH_UNIQUE_INDEX_31C9F7A9140B4E349FAAAB2C0AFC6817]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ForumMembers]') AND name = N'GRAPH_UNIQUE_INDEX_31C9F7A9140B4E349FAAAB2C0AFC6817')
CREATE UNIQUE NONCLUSTERED INDEX [GRAPH_UNIQUE_INDEX_31C9F7A9140B4E349FAAAB2C0AFC6817] ON [dbo].[ForumMembers]
(
	$node_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20180325-154238]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ForumMembers]') AND name = N'NonClusteredIndex-20180325-154238')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20180325-154238] ON [dbo].[ForumMembers]
(
	[MemberName] ASC
)
INCLUDE ( 	[MemberID],
	[MemberVorname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20180403-102350]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ForumMembers]') AND name = N'NonClusteredIndex-20180403-102350')
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20180403-102350] ON [dbo].[ForumMembers]
(
	[MemberMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [GRAPH_UNIQUE_INDEX_EE3CEBBF843649A68EDC5989926DD751]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ForumPosts]') AND name = N'GRAPH_UNIQUE_INDEX_EE3CEBBF843649A68EDC5989926DD751')
CREATE UNIQUE NONCLUSTERED INDEX [GRAPH_UNIQUE_INDEX_EE3CEBBF843649A68EDC5989926DD751] ON [dbo].[ForumPosts]
(
	$node_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [GRAPH_UNIQUE_INDEX_C081DEB12E59432DB9F593C38002D92C]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Likes]') AND name = N'GRAPH_UNIQUE_INDEX_C081DEB12E59432DB9F593C38002D92C')
CREATE UNIQUE NONCLUSTERED INDEX [GRAPH_UNIQUE_INDEX_C081DEB12E59432DB9F593C38002D92C] ON [dbo].[Likes]
(
	$edge_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IndexEdge1]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Likes]') AND name = N'IX_IndexEdge1')
CREATE UNIQUE NONCLUSTERED INDEX [IX_IndexEdge1] ON [dbo].[Likes]
(
	$from_id,
	$to_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [GRAPH_UNIQUE_INDEX_2FAF636AEC5A426BA8DBEFBF53CFCA5E]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Reply_To]') AND name = N'GRAPH_UNIQUE_INDEX_2FAF636AEC5A426BA8DBEFBF53CFCA5E')
CREATE UNIQUE NONCLUSTERED INDEX [GRAPH_UNIQUE_INDEX_2FAF636AEC5A426BA8DBEFBF53CFCA5E] ON [dbo].[Reply_To]
(
	$edge_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IndexEdge1]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Reply_To]') AND name = N'IX_IndexEdge1')
CREATE UNIQUE NONCLUSTERED INDEX [IX_IndexEdge1] ON [dbo].[Reply_To]
(
	$from_id,
	$to_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_fromid]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WohntIn]') AND name = N'ix_fromid')
CREATE NONCLUSTERED INDEX [ix_fromid] ON [dbo].[WohntIn]
(
	$from_id,
	$to_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_graphid]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WohntIn]') AND name = N'ix_graphid')
CREATE UNIQUE NONCLUSTERED INDEX [ix_graphid] ON [dbo].[WohntIn]
(
	$edge_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IndexEdge1]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WohntIn]') AND name = N'IX_IndexEdge1')
CREATE UNIQUE NONCLUSTERED INDEX [IX_IndexEdge1] ON [dbo].[WohntIn]
(
	$from_id,
	$to_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_toid]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WohntIn]') AND name = N'ix_toid')
CREATE NONCLUSTERED INDEX [ix_toid] ON [dbo].[WohntIn]
(
	$to_id,
	$from_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [GRAPH_UNIQUE_INDEX_6B90960590324411BEC9C2C7B4EBA0B1]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Written_By]') AND name = N'GRAPH_UNIQUE_INDEX_6B90960590324411BEC9C2C7B4EBA0B1')
CREATE UNIQUE NONCLUSTERED INDEX [GRAPH_UNIQUE_INDEX_6B90960590324411BEC9C2C7B4EBA0B1] ON [dbo].[Written_By]
(
	$edge_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IndexEdge1]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Written_By]') AND name = N'IX_IndexEdge1')
CREATE UNIQUE NONCLUSTERED INDEX [IX_IndexEdge1] ON [dbo].[Written_By]
(
	$from_id,
	$to_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [GRAPH_UNIQUE_INDEX_27A8CBD463B344B4A03CB9624EB35442]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Forum].[ForumOrt]') AND name = N'GRAPH_UNIQUE_INDEX_27A8CBD463B344B4A03CB9624EB35442')
CREATE UNIQUE NONCLUSTERED INDEX [GRAPH_UNIQUE_INDEX_27A8CBD463B344B4A03CB9624EB35442] ON [Forum].[ForumOrt]
(
	$node_id
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20180325-173221]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Forum].[ForumOrt]') AND name = N'NonClusteredIndex-20180325-173221')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20180325-173221] ON [Forum].[ForumOrt]
(
	[PLZ] ASC,
	$node_id
)
INCLUDE ( 	[OrtID],
	[Ort]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20180325-173246]    Script Date: 05.04.2018 10:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Forum].[ForumOrt]') AND name = N'NonClusteredIndex-20180325-173246')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20180325-173246] ON [Forum].[ForumOrt]
(
	[Ort] ASC,
	$node_id
)
INCLUDE ( 	[OrtID],
	[PLZ]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  FullTextIndex     Script Date: 05.04.2018 10:30:33 ******/
IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[ForumMembers]'))
CREATE FULLTEXT INDEX ON [dbo].[ForumMembers](
[LogIn] LANGUAGE 'German', 
[MemberMail] LANGUAGE 'German', 
[MemberName] LANGUAGE 'German', 
[MemberStrasse] LANGUAGE 'German', 
[MemberVorname] LANGUAGE 'German')
KEY INDEX [PK_ForumMembers]ON ([ft_graph_post], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)

GO
/****** Object:  FullTextIndex     Script Date: 05.04.2018 10:30:33 ******/
IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[ForumPosts]'))
CREATE FULLTEXT INDEX ON [dbo].[ForumPosts](
[PostBody] LANGUAGE 'German', 
[PostTitle] LANGUAGE 'German')
KEY INDEX [PK_ForumPosts]ON ([ft_graph_post], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ForumMembers_replyedAm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ForumMembers] ADD  CONSTRAINT [DF_ForumMembers_replyedAm]  DEFAULT (getdate()) FOR [erfasstAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ForumPosts_PostTitle]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ForumPosts] ADD  CONSTRAINT [DF_ForumPosts_PostTitle]  DEFAULT ('-') FOR [PostTitle]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ForumPosts_PostBody]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ForumPosts] ADD  CONSTRAINT [DF_ForumPosts_PostBody]  DEFAULT ('-') FOR [PostBody]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ForumPosts_gepostedAm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ForumPosts] ADD  CONSTRAINT [DF_ForumPosts_gepostedAm]  DEFAULT (getdate()) FOR [gepostedAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Likes_gepostedAm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Likes] ADD  CONSTRAINT [DF_Likes_gepostedAm]  DEFAULT (getdate()) FOR [gelikedAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Reply_To_gelikedAm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Reply_To] ADD  CONSTRAINT [DF_Reply_To_gelikedAm]  DEFAULT (getdate()) FOR [replyedAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WohntIn_erfasstAm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WohntIn] ADD  CONSTRAINT [DF_WohntIn_erfasstAm]  DEFAULT (getdate()) FOR [erfasstAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Written_By_replyedAm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Written_By] ADD  CONSTRAINT [DF_Written_By_replyedAm]  DEFAULT (getdate()) FOR [writtenByAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Forum].[DF_ForumOrt_erfasstAm]') AND type = 'D')
BEGIN
ALTER TABLE [Forum].[ForumOrt] ADD  CONSTRAINT [DF_ForumOrt_erfasstAm]  DEFAULT (getdate()) FOR [erfasstAm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_ForumPosts_ForumMembers]') AND parent_object_id = OBJECT_ID(N'[Forum].[ForumPosts]'))
ALTER TABLE [Forum].[ForumPosts]  WITH CHECK ADD  CONSTRAINT [FK_ForumPosts_ForumMembers] FOREIGN KEY([OwnerID])
REFERENCES [Forum].[ForumMembers] ([MemberId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_ForumPosts_ForumMembers]') AND parent_object_id = OBJECT_ID(N'[Forum].[ForumPosts]'))
ALTER TABLE [Forum].[ForumPosts] CHECK CONSTRAINT [FK_ForumPosts_ForumMembers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_ForumPosts_ForumPosts]') AND parent_object_id = OBJECT_ID(N'[Forum].[ForumPosts]'))
ALTER TABLE [Forum].[ForumPosts]  WITH CHECK ADD  CONSTRAINT [FK_ForumPosts_ForumPosts] FOREIGN KEY([PostID])
REFERENCES [Forum].[ForumPosts] ([PostID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_ForumPosts_ForumPosts]') AND parent_object_id = OBJECT_ID(N'[Forum].[ForumPosts]'))
ALTER TABLE [Forum].[ForumPosts] CHECK CONSTRAINT [FK_ForumPosts_ForumPosts]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_LikeMember_ForumMembers]') AND parent_object_id = OBJECT_ID(N'[Forum].[LikeMember]'))
ALTER TABLE [Forum].[LikeMember]  WITH CHECK ADD  CONSTRAINT [FK_LikeMember_ForumMembers] FOREIGN KEY([MemberId])
REFERENCES [Forum].[ForumMembers] ([MemberId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_LikeMember_ForumMembers]') AND parent_object_id = OBJECT_ID(N'[Forum].[LikeMember]'))
ALTER TABLE [Forum].[LikeMember] CHECK CONSTRAINT [FK_LikeMember_ForumMembers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_LikeMember_ForumMembers1]') AND parent_object_id = OBJECT_ID(N'[Forum].[LikeMember]'))
ALTER TABLE [Forum].[LikeMember]  WITH CHECK ADD  CONSTRAINT [FK_LikeMember_ForumMembers1] FOREIGN KEY([LikedMemberId])
REFERENCES [Forum].[ForumMembers] ([MemberId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_LikeMember_ForumMembers1]') AND parent_object_id = OBJECT_ID(N'[Forum].[LikeMember]'))
ALTER TABLE [Forum].[LikeMember] CHECK CONSTRAINT [FK_LikeMember_ForumMembers1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_Likes_ForumMembers]') AND parent_object_id = OBJECT_ID(N'[Forum].[Likes]'))
ALTER TABLE [Forum].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_Likes_ForumMembers] FOREIGN KEY([MemberId])
REFERENCES [Forum].[ForumMembers] ([MemberId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_Likes_ForumMembers]') AND parent_object_id = OBJECT_ID(N'[Forum].[Likes]'))
ALTER TABLE [Forum].[Likes] CHECK CONSTRAINT [FK_Likes_ForumMembers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_Likes_ForumPosts]') AND parent_object_id = OBJECT_ID(N'[Forum].[Likes]'))
ALTER TABLE [Forum].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_Likes_ForumPosts] FOREIGN KEY([PostId])
REFERENCES [Forum].[ForumPosts] ([PostID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Forum].[FK_Likes_ForumPosts]') AND parent_object_id = OBJECT_ID(N'[Forum].[Likes]'))
ALTER TABLE [Forum].[Likes] CHECK CONSTRAINT [FK_Likes_ForumPosts]
GO
/****** Object:  StoredProcedure [dbo].[sp_AllPostRepliedByXY]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AllPostRepliedByXY]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_AllPostRepliedByXY] AS' 
END
GO
ALTER PROC [dbo].[sp_AllPostRepliedByXY] (@Member varchar(100)) AS
-- All Post replied by Müller
   SELECT distinct RepliedPost.PostID,RepliedPost.PostTitle,
           RepliedPost.PostBody, Members.MemberID
   FROM dbo.ForumPosts ReplyPost, Reply_To, dbo.ForumPosts RepliedPost,
        dbo.ForumMembers Members,Written_By
   WHERE MATCH(Members<-(Written_By)-ReplyPost-(Reply_To)->RepliedPost)
   and Members.MemberName=@Member

GO
/****** Object:  StoredProcedure [dbo].[sp_AllRepliesMadeByXY]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AllRepliesMadeByXY]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_AllRepliesMadeByXY] AS' 
END
GO
ALTER PROC [dbo].[sp_AllRepliesMadeByXY] (@Member varchar(100)) AS
  -- All replies made by Müller
   SELECT ReplyPost.PostID,ReplyPost.PostTitle,ReplyPost.PostBody, 
          RepliedPost.PostId ReplyTo, Members.MemberID
   FROM dbo.ForumPosts ReplyPost, Reply_To, dbo.ForumPosts RepliedPost,
        dbo.ForumMembers Members,Written_By
   WHERE MATCH(Members<-(Written_By)-ReplyPost-(Reply_To)->RepliedPost)
   and Members.MemberName=@Member
GO
/****** Object:  StoredProcedure [dbo].[sp_AllRepliesOfaSinglePost]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AllRepliesOfaSinglePost]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_AllRepliesOfaSinglePost] AS' 
END
GO
-- All replies of a single post
ALTER proc [dbo].[sp_AllRepliesOfaSinglePost] (@PostId integer) as
-- sp_AllRepliesOfaSinglePost 81
with [root] as 
(select $node_id as node_id, RootPosts.PostId, RootPosts.PostTitle,
        1 as [Level], 0 as ReplyTo
    from ForumPosts RootPosts where PostId=@PostId  
union all
    select $node_id, ReplyPost.PostId, ReplyPost.PostTitle,
        [Level]+1 as [Level], [root].PostId as ReplyTo
    from ForumPosts ReplyPost, reply_to, [root]
      where ReplyPost.$node_id=reply_to.$from_id and [root].node_id=reply_to.$to_id
)
select PostId,PostTitle, [Level], ReplyTo from [root]

GO
/****** Object:  StoredProcedure [dbo].[sp_AllTheParentsOfaSinglePost_WithReferenceToTheirParents]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AllTheParentsOfaSinglePost_WithReferenceToTheirParents]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_AllTheParentsOfaSinglePost_WithReferenceToTheirParents] AS' 
END
GO
ALTER proc [dbo].[sp_AllTheParentsOfaSinglePost_WithReferenceToTheirParents] (@PostId integer) as
-- sp_AllTheParentsOfaSinglePost_WithReferenceToTheirParents 82
with [root] as 
(select LeafPost.$node_id as node_id,LeafPost.PostId,
        LeafPost.PostTitle
    from ForumPosts LeafPost
		where LeafPost.PostId=@PostId  -- Single post
union all
    select RepliedPost.$node_id as node_id,RepliedPost.PostId, 
        RepliedPost.PostTitle
    from ForumPosts RepliedPost, Reply_to, [root]
		where [root].node_id=Reply_to.$from_id 
			and Reply_to.$to_id=RepliedPost.$node_id
)
select root.PostId,[root].PostTitle, RepliedPost.PostId ParentPostId
 from [root]
	left join reply_to 
	    on [root].node_id=reply_to.$from_id
	left join ForumPosts RepliedPost 
		on reply_to.$to_id=RepliedPost.$node_id


GO
/****** Object:  StoredProcedure [dbo].[sp_insertLike]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_insertLike]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_insertLike] AS' 
END
GO
ALTER PROC [dbo].[sp_insertLike] (@MemberID integer, @PostID integer, @oeffentlicheIP varchar(100)) AS
begin
	insert into Likes ($to_id,$from_id,[öffentlicheIPv4])
		values(	(select $node_id from ForumPosts where PostID=@PostID),
				(select $node_id from ForumMembers where MemberID=@MemberID),
				@oeffentlicheIP
			  );
end
GO
/****** Object:  StoredProcedure [dbo].[sp_insertLikeToMember]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_insertLikeToMember]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_insertLikeToMember] AS' 
END
GO
ALTER PROC [dbo].[sp_insertLikeToMember] (@MemberID integer, @ToMemberID integer, @oeffentlicheIP varchar(100)) AS
begin
	insert into Likes ($to_id, $from_id,[öffentlicheIPv4])
		values(	(select $node_id from ForumMembers where MemberID=@ToMemberID),
				(select $node_id from ForumMembers where MemberID=@MemberID),
				@oeffentlicheIP
			  );
end



GO
/****** Object:  StoredProcedure [dbo].[sp_insertPost]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_insertPost]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_insertPost] AS' 
END
GO
ALTER PROC [dbo].[sp_insertPost] (@Post varchar(1000), @iMemberID integer)
as
begin
	declare @iPostID integer;
	insert into ForumPosts (öffentlicheIPv4) Values (@Post);
	set @iPostID=@@IDENTITY;

	Insert into Written_By ($to_id, $from_id)
		values(	(select $node_id from ForumMembers where MemberId=@iMemberID ),
				(select $node_id from ForumPosts where PostID=@@IDENTITY )
			  );

	select @iPostID PostID;
end

GO
/****** Object:  StoredProcedure [dbo].[sp_insertReplay]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_insertReplay]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_insertReplay] AS' 
END
GO
ALTER PROC [dbo].[sp_insertReplay] (@PostID integer, @iMemberID integer, @oeffentlicheIP varchar(100)) AS
begin
declare @iPostID integer;

	insert into ForumPosts (öffentlicheIPv4) Values (@oeffentlicheIP);
	set @iPostID=@@IDENTITY;

	insert into Reply_To ($from_id, $to_id,[öffentlicheIPv4]) 
		values(	(select $node_id from ForumPosts where PostID=@iPostID),
				(select $node_id from ForumPosts where PostID=@PostID),
				@oeffentlicheIP
			   );

	Insert into Written_By ($to_id, $from_id,[öffentlicheIPv4])
		values(	(select $node_id from ForumMembers where MemberId=@iMemberID),
				(select $node_id from ForumPosts where PostID=@iPostID),
				@oeffentlicheIP
			  );

	select @iPostID RPostID;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SearchFullText]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SearchFullText]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_SearchFullText] AS' 
END
GO

ALTER PROC [dbo].[sp_SearchFullText] (@s varchar(100))
-- https://www.microsoftpressstore.com/articles/article.aspx?p=2201634&seqNum=3
-- sp_SearchFullText 'gmx'
AS
DECLARE @ss varchar(130)
SET @ss='FORMSOF(INFLECTIONAL,'+@s+')'

SELECT PostID ID, 'Post' Art, PostTitle Inhalt, gepostedAm Datum FROM ForumPosts WHERE CONTAINS ((PostBody,PostTitle), @ss)
	UNION
SELECT MemberID ID, 'Member' Art, ISNULL(MemberVorname,'')+' '+ISNULL(MemberName,'') Inhalt, erfasstAm FROM ForumMembers WHERE CONTAINS ((MemberName,MemberVorname,MemberMail), @ss)
	UNION
SELECT PostID ID, 'Post' Art, PostTitle Inhalt, gepostedAm Datum FROM ForumPosts WHERE FREETEXT ((PostBody,PostTitle), @s)
	UNION
SELECT MemberID ID, 'Member' Art, ISNULL(MemberVorname,'')+' '+ISNULL(MemberName,'') Inhalt, erfasstAm Datum FROM ForumMembers WHERE FREETEXT ((MemberName,MemberVorname,MemberMail), @s)
GO
/****** Object:  Trigger [dbo].[tr_pw_Member]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pw_Member]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_pw_Member]
   ON  [dbo].[ForumMembers]
   FOR INSERT, UPDATE
AS 
--CREATE MASTER KEY ENCRYPTION BY PASSWORD = ''789Pass456word123'';
--CREATE CERTIFICATE Certificate1 WITH SUBJECT = ''Protect Data''
--CREATE SYMMETRIC KEY SymmetricKey1 WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Certificate1

BEGIN
	SET NOCOUNT ON;

	DECLARE @id integer;
	DECLARE @pw varchar(400);
	DECLARE @valid bit;

	select @valid=dbo.udf_Txt_IsEmail(MemberMail) from inserted;
	if (@valid<=0)  
		begin
			raiserror(''Falsches E-Mailformat!'', 16, 1)
		end
	else
	begin
		update [ForumMembers] set  [geändertAm]=GETDATE() WHERE [MemberID] in (select [MemberID] FROM INSERTED )

		SELECT @id=MemberID, @pw=[Login] FROM inserted;

		IF LEN(@PW)<=15 AND LEN(@PW)>=3
		BEGIN
			OPEN SYMMETRIC KEY SymmetricKey1 DECRYPTION BY CERTIFICATE Certificate1;
			IF @pw<>''''
				UPDATE [dbo].[ForumMembers] SET [Login]=EncryptByKey(Key_GUID(''SymmetricKey1''), @pw) WHERE ForumMembers.MemberID=@id
			CLOSE SYMMETRIC KEY SymmetricKey1;
		END
	end
END
' 
GO
ALTER TABLE [dbo].[ForumMembers] ENABLE TRIGGER [tr_pw_Member]
GO
/****** Object:  Trigger [dbo].[chkNotOrphanReply]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[chkNotOrphanReply]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[chkNotOrphanReply] on [dbo].[ForumPosts]
for delete as
if exists(select 1 from deleted where (SELECT count(*) FROM Reply_To WHERE $to_id=deleted.$node_id)>0)
begin
	raiserror(''This message can''''t be deleted because it has replies'',13,1)
	rollback transaction
end' 
GO
ALTER TABLE [dbo].[ForumPosts] ENABLE TRIGGER [chkNotOrphanReply]
GO
/****** Object:  Trigger [dbo].[TR_UPDATE_Posts]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TR_UPDATE_Posts]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[TR_UPDATE_Posts]
   ON  [dbo].[ForumPosts]
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	update ForumPosts set  [geändertAm]=GETDATE() WHERE PostID in (select PostID FROM INSERTED )
END
' 
GO
ALTER TABLE [dbo].[ForumPosts] ENABLE TRIGGER [TR_UPDATE_Posts]
GO
/****** Object:  Trigger [dbo].[chkLikeType]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[chkLikeType]'))
EXEC dbo.sp_executesql @statement = N'Create trigger [dbo].[chkLikeType] on [dbo].[Likes]
for Insert,Update as
if exists (select 1 from inserted where json_value($from_id, ''$.schema'')<>''dbo'' or json_value($from_id, ''$.table'')<>''ForumMembers'')
begin
	raiserror(''Only forum members can like a post or another member'',13,1)
	rollback transaction
end' 
GO
ALTER TABLE [dbo].[Likes] ENABLE TRIGGER [chkLikeType]
GO
/****** Object:  Trigger [dbo].[chkReplies]    Script Date: 05.04.2018 10:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[chkReplies]'))
EXEC dbo.sp_executesql @statement = N'CREATE trigger [dbo].[chkReplies] on [dbo].[Reply_To]
for insert,update
as
begin
    if exists( select 1 from inserted where (SELECT count(*)FROM dbo.ForumPosts ReplyPost, Reply_To, dbo.ForumPosts RepliedPost
				WHERE MATCH(ReplyPost-(Reply_To)->RepliedPost) and ReplyPost.$node_id=inserted.$from_id)>1
			 )
	begin
		raiserror(''One message can only be reply to another single message'',13,1)
		rollback transaction
	end
end' 
GO
ALTER TABLE [dbo].[Reply_To] ENABLE TRIGGER [chkReplies]
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'v_Ort', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ForumOrt (Forum)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 365
               Right = 381
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Ort'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'v_Ort', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Ort'
GO
USE [master]
GO
ALTER DATABASE [GraphExample] SET  READ_WRITE 
GO
