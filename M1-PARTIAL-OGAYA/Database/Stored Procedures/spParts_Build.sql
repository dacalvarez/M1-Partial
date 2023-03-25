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