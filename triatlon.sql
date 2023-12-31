USE [master]
GO
/****** Object:  Database [triatlon]    Script Date: 3/8/2023 11:09:01 AM ******/
CREATE DATABASE [triatlon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'triatlon', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\triatlon.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'triatlon_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\triatlon_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [triatlon] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [triatlon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [triatlon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [triatlon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [triatlon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [triatlon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [triatlon] SET ARITHABORT OFF 
GO
ALTER DATABASE [triatlon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [triatlon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [triatlon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [triatlon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [triatlon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [triatlon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [triatlon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [triatlon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [triatlon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [triatlon] SET  DISABLE_BROKER 
GO
ALTER DATABASE [triatlon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [triatlon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [triatlon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [triatlon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [triatlon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [triatlon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [triatlon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [triatlon] SET RECOVERY FULL 
GO
ALTER DATABASE [triatlon] SET  MULTI_USER 
GO
ALTER DATABASE [triatlon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [triatlon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [triatlon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [triatlon] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [triatlon] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'triatlon', N'ON'
GO
USE [triatlon]
GO
/****** Object:  Table [dbo].[cluburi]    Script Date: 3/8/2023 11:09:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cluburi](
	[id] [int] IDENTITY(1, 1) NOT NULL,
	[Denumire] [varbinary](50) NOT NULL,
 CONSTRAINT [PK_Cluburi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[competitii]    Script Date: 3/8/2023 11:09:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[competitii](
	[id] [int] IDENTITY(1, 1) NOT NULL,
	[denumire] [varchar](50) NOT NULL,
	[localiate] [varchar](50) NOT NULL,
	[data_desf] [datetime] NOT NULL,
 CONSTRAINT [PK_competitii] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[competitii-discipline]    Script Date: 3/8/2023 11:09:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[competitii-discipline](
	[id] [int] IDENTITY(1, 1) NOT NULL,
	[id_concurs] [int] NOT NULL,
	[id_disciplina] [int] NOT NULL,
 CONSTRAINT [PK_competitii-discipline] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[discipline]    Script Date: 3/8/2023 11:09:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[discipline](
	[id] [int] IDENTITY(1, 1) NOT NULL,
	[Denumire] [varchar](50) NOT NULL,
	[descriere] [varchar](50) NOT NULL,
 CONSTRAINT [PK_discipline] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[participari-rezultate]    Script Date: 3/8/2023 11:09:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[participari-rezultate](
	[id] [int] IDENTITY(1, 1) NOT NULL,
	[id_sportiv] [int] NOT NULL,
	[id_participare] [int] NOT NULL,
	[p1] [time](7) NULL,
	[p2] [time](7) NULL,
	[p3] [time](7) NULL,
	[total] [time](7) NULL,
 CONSTRAINT [PK_participari-rezultate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sportivi]    Script Date: 3/8/2023 11:09:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sportivi](
	[id] [int] IDENTITY(1, 1) NOT NULL,
	[Nume] [varchar](50) NOT NULL,
	[Prenume] [varchar](50) NOT NULL,
	[Data_nasterii] [date] NOT NULL,
	[Sex] [char](1) NOT NULL,
	[id_club] [int] NOT NULL,
 CONSTRAINT [PK_sportivi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[competitii-discipline]  WITH CHECK ADD  CONSTRAINT [FK_competitii-discipline_competitii] FOREIGN KEY([id])
REFERENCES [dbo].[competitii] ([id])
GO
ALTER TABLE [dbo].[competitii-discipline] CHECK CONSTRAINT [FK_competitii-discipline_competitii]
GO
ALTER TABLE [dbo].[competitii-discipline]  WITH CHECK ADD  CONSTRAINT [FK_competitii-discipline_discipline] FOREIGN KEY([id])
REFERENCES [dbo].[discipline] ([id])
GO
ALTER TABLE [dbo].[competitii-discipline] CHECK CONSTRAINT [FK_competitii-discipline_discipline]
GO
ALTER TABLE [dbo].[participari-rezultate]  WITH CHECK ADD  CONSTRAINT [FK_participari-rezultate_competitii-discipline] FOREIGN KEY([id])
REFERENCES [dbo].[competitii-discipline] ([id])
GO
ALTER TABLE [dbo].[participari-rezultate] CHECK CONSTRAINT [FK_participari-rezultate_competitii-discipline]
GO
ALTER TABLE [dbo].[participari-rezultate]  WITH CHECK ADD  CONSTRAINT [FK_participari-rezultate_sportivi] FOREIGN KEY([id_sportiv])
REFERENCES [dbo].[sportivi] ([id])
GO
ALTER TABLE [dbo].[participari-rezultate] CHECK CONSTRAINT [FK_participari-rezultate_sportivi]
GO
ALTER TABLE [dbo].[sportivi]  WITH CHECK ADD  CONSTRAINT [FK_sportivi_cluburi] FOREIGN KEY([id_club])
REFERENCES [dbo].[cluburi] ([id])
GO
ALTER TABLE [dbo].[sportivi] CHECK CONSTRAINT [FK_sportivi_cluburi]
GO
USE [master]
GO
ALTER DATABASE [triatlon] SET  READ_WRITE 
GO
