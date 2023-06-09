﻿/*
Deployment script for PCPartsDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PCPartsDB"
:setvar DefaultFilePrefix "PCPartsDB"
:setvar DefaultDataPath "C:\Users\user\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\user\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating Table [dbo].[CASES]...';


GO
CREATE TABLE [dbo].[CASES] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[CPU]...';


GO
CREATE TABLE [dbo].[CPU] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[FANS]...';


GO
CREATE TABLE [dbo].[FANS] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[GPU]...';


GO
CREATE TABLE [dbo].[GPU] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[MOBO]...';


GO
CREATE TABLE [dbo].[MOBO] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[PC]...';


GO
CREATE TABLE [dbo].[PC] (
    [ID]        INT             IDENTITY (1, 1) NOT NULL,
    [PC Part]   NVARCHAR (MAX)  NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating Table [dbo].[PSU]...';


GO
CREATE TABLE [dbo].[PSU] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[RAM]...';


GO
CREATE TABLE [dbo].[RAM] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[SSD]...';


GO
CREATE TABLE [dbo].[SSD] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (MAX)  NOT NULL,
    [Code]      NVARCHAR (MAX)  NOT NULL,
    [Brand]     NVARCHAR (MAX)  NOT NULL,
    [UnitPrice] DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [UserName]  NVARCHAR (16) NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [LastName]  NVARCHAR (50) NOT NULL,
    [Password]  NVARCHAR (16) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Procedure [dbo].[spParts_AllData]...';


GO
CREATE PROCEDURE [dbo].[spParts_AllData]
	@tableName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
        IF @tableName = 'CASES'
        SELECT * FROM dbo.CASES;
    ELSE IF @tableName = 'CPU'
        SELECT * FROM dbo.CPU;
    ELSE IF @tableName = 'FANS'
        SELECT * FROM dbo.FANS;
    ELSE IF @tableName = 'GPU'
        SELECT * FROM dbo.GPU;
    ELSE IF @tableName = 'MOBO'
        SELECT * FROM dbo.MOBO;
    ELSE IF @tableName = 'PSU'
        SELECT * FROM dbo.PSU;
    ELSE IF @tableName = 'RAM'
        SELECT * FROM dbo.RAM;
    ELSE IF @tableName = 'SSD'
        SELECT * FROM dbo.SSD;
    ELSE
        RAISERROR('Invalid table name', 16, 1);
END
GO
PRINT N'Creating Procedure [dbo].[spParts_Build]...';


GO
CREATE PROCEDURE [dbo].[spParts_Build]
    @CaseId INT,
    @FanId INT,
    @CpuId INT,
    @GpuId INT,
    @RamId INT,
    @MoboId INT,
    @PsuId INT,
    @SsdId INT,
    @TotalPrice DECIMAL(10, 2) OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PartTable TABLE ( [Name] NVARCHAR(MAX), [UnitPrice] DECIMAL(10, 2), [Table] NVARCHAR(MAX));

    SET @TotalPrice = 0;

    DELETE FROM PC;

    IF @CaseId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT  [Name], [UnitPrice], 'CASES' FROM [dbo].[CASES] WHERE [Id] = @CaseId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[CASES] WHERE [Id] = @CaseId);
    END

    IF @FanId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT [Name], [UnitPrice], 'FANS' FROM [dbo].[FANS] WHERE [Id] = @FanId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[FANS] WHERE [Id] = @FanId);
    END

    IF @CpuId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT [Name], [UnitPrice], 'CPU' FROM [dbo].[CPU] WHERE [Id] = @CpuId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[CPU] WHERE [Id] = @CpuId);
    END

    IF @GpuId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT [Name], [UnitPrice], 'GPU' FROM [dbo].[GPU] WHERE [Id] = @GpuId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[GPU] WHERE [Id] = @GpuId);
    END

    IF @RamId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT [Name], [UnitPrice], 'RAM' FROM [dbo].[RAM] WHERE [Id] = @RamId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[RAM] WHERE [Id] = @RamId);
    END

    IF @MoboId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT [Name], [UnitPrice], 'MOBO' FROM [dbo].[MOBO] WHERE [Id] = @MoboId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[MOBO] WHERE [Id] = @MoboId);
    END

    IF @PsuId IS NOT NULL
    BEGIN
        INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
        SELECT [Name], [UnitPrice], 'PSU' FROM [dbo].[PSU] WHERE [Id] = @PsuId;
        SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[PSU] WHERE [Id] = @PsuId);
    END

IF @SsdId IS NOT NULL
BEGIN
    INSERT INTO @PartTable ([Name], [UnitPrice], [Table])
    SELECT [Name], [UnitPrice], 'SSD' FROM [dbo].[SSD] WHERE [Id] = @SsdId;
    SET @TotalPrice += (SELECT [UnitPrice] FROM [dbo].[SSD] WHERE [Id] = @SsdId);
END

SELECT [Name], [UnitPrice], [Table] FROM @PartTable;
END
GO
PRINT N'Creating Procedure [dbo].[spParts_DeleteData]...';


GO
CREATE PROCEDURE [dbo].[spParts_DeleteData]
	@tableName NVARCHAR(50),
	@id INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @sql NVARCHAR(200);
    
    IF @tableName = 'CASES'
        SET @sql = 'DELETE FROM dbo.CASES WHERE Id = @id';
    ELSE IF @tableName = 'CPU'
        SET @sql = 'DELETE FROM dbo.CPU WHERE Id = @id';
    ELSE IF @tableName = 'FANS'
        SET @sql = 'DELETE FROM dbo.FANS WHERE Id = @id';
    ELSE IF @tableName = 'GPU'
        SET @sql = 'DELETE FROM dbo.GPU WHERE Id = @id';
    ELSE IF @tableName = 'MOBO'
        SET @sql = 'DELETE FROM dbo.MOBO WHERE Id = @id';
    ELSE IF @tableName = 'PSU'
        SET @sql = 'DELETE FROM dbo.PSU WHERE Id = @id';
    ELSE IF @tableName = 'RAM'
        SET @sql = 'DELETE FROM dbo.RAM WHERE Id = @id';
    ELSE IF @tableName = 'SSD'
        SET @sql = 'DELETE FROM dbo.SSD WHERE Id = @id';
    ELSE
        RAISERROR('Invalid table name', 16, 1);

    EXEC sp_executesql @sql, N'@id INT', @id;
END
GO
PRINT N'Creating Procedure [dbo].[spParts_InsertData]...';


GO
CREATE PROCEDURE [dbo].[spParts_InsertData]
	@tableName NVARCHAR(50),
	@name NVARCHAR(MAX),
	@code NVARCHAR(MAX),
	@brand NVARCHAR(MAX),
	@unitPrice DECIMAL(10, 2)
AS
BEGIN
	SET	NOCOUNT ON;
    DECLARE @sql NVARCHAR(MAX);
    
    SET @sql = N'INSERT INTO ' + QUOTENAME(@tableName) + N' (Name, Code, Brand, UnitPrice) ' +
               N'VALUES (@name, @code, @brand, @unitPrice)';
               
    EXEC sp_executesql @sql, 
                       N'@name NVARCHAR(MAX), @code NVARCHAR(MAX), @brand NVARCHAR(MAX), @unitPrice DECIMAL(10, 2)', 
                       @name, @code, @brand, @unitPrice;
END
GO
PRINT N'Creating Procedure [dbo].[spParts_UpdateData]...';


GO
CREATE PROCEDURE [dbo].[spParts_UpdateData]
    @tableName NVARCHAR(50),
    @id INT,
    @name NVARCHAR(MAX),
    @code NVARCHAR(MAX),
    @brand NVARCHAR(MAX),
    @unitPrice DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(200);

    IF @tableName = 'CASES'
        SET @sql = 'UPDATE dbo.CASES SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'CPU'
        SET @sql = 'UPDATE dbo.CPU SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'FANS'
        SET @sql = 'UPDATE dbo.FANS SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'GPU'
        SET @sql = 'UPDATE dbo.GPU SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'MOBO'
        SET @sql = 'UPDATE dbo.MOBO SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'PSU'
        SET @sql = 'UPDATE dbo.PSU SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'RAM'
        SET @sql = 'UPDATE dbo.RAM SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE IF @tableName = 'SSD'
        SET @sql = 'UPDATE dbo.SSD SET Name = @name, Code = @code, Brand = @brand, UnitPrice = @unitPrice WHERE Id = @id';
    ELSE
        RAISERROR('Invalid table name', 16, 1);

    EXEC sp_executesql @sql, N'@id INT, @name NVARCHAR(MAX), @code NVARCHAR(MAX), @brand NVARCHAR(MAX), @unitPrice DECIMAL(10, 2)', @id, @name, @code, @brand, @unitPrice;
END
GO
PRINT N'Creating Procedure [dbo].[spUsers_Authenticate]...';


GO
CREATE PROCEDURE [dbo].[spUsers_Authenticate]
	@username nvarchar(16),
	@password nvarchar(16)
AS
begin
	set nocount on;

	SELECT [Id], [UserName], [FirstName], [LastName], [Password]
	FROM dbo.Users
	WHERE UserName = @username
	AND Password = @password;

end
GO
PRINT N'Creating Procedure [dbo].[spUsers_Register]...';


GO
CREATE PROCEDURE [dbo].[spUsers_Register]
@userName nvarchar(16),
@firstName nvarchar(50),
@lastName nvarchar(50),
@password nvarchar(16)

AS
begin
	set nocount on;

	INSERT INTO dbo.Users(UserName, FirstName, LastName, Password)
	VALUES (@userName, @firstName, @lastName, @password)
end
GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '80da39fe-717f-4543-9079-268b363a632f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('80da39fe-717f-4543-9079-268b363a632f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6fbb8ccb-d188-4d3c-aa3b-64cd4cb2ec33')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6fbb8ccb-d188-4d3c-aa3b-64cd4cb2ec33')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '812c8a0c-cd7f-4686-a095-6edac66f7755')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('812c8a0c-cd7f-4686-a095-6edac66f7755')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8fe3e4b1-7ee5-4c5e-baa1-90fd6ce38891')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8fe3e4b1-7ee5-4c5e-baa1-90fd6ce38891')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e55280c0-02cf-483e-939b-511cab7e4bd0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e55280c0-02cf-483e-939b-511cab7e4bd0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a0362f25-c887-43e1-904c-92b219c2a9dc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a0362f25-c887-43e1-904c-92b219c2a9dc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '445c9df1-ab01-4bcb-be2b-3f0e18558ce3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('445c9df1-ab01-4bcb-be2b-3f0e18558ce3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0e93b599-0aa8-48b7-b110-dc0b7f6ff28e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0e93b599-0aa8-48b7-b110-dc0b7f6ff28e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6900630a-69c8-498c-9d44-4264eafb0f19')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6900630a-69c8-498c-9d44-4264eafb0f19')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
