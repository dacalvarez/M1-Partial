CREATE PROCEDURE [dbo].[spParts_SearchFilter]
    @SearchString NVARCHAR(50) = NULL,
    @Category NVARCHAR(50) = NULL,
    @Brand NVARCHAR(50) = NULL,
    @MinPrice DECIMAL(10, 2) = NULL,
    @MaxPrice DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 'CASES' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[CASES]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'CASE' = @SearchString OR 'CASEs' = @SearchString OR 'TOWER' = @SearchString OR 'TOWERS' = @SearchString)
        AND (@Category IS NULL OR 'CASE' = @Category  OR 'CASES' = @Category OR 'TOWER' = @Category OR 'TOWERS' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'FANS' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[FANS]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'FAN' = @SearchString OR 'FANs' = @SearchString OR 'CASE FAN' = @SearchString OR 'CASE FANs' = @SearchString)
        AND (@Category IS NULL OR 'FAN' = @Category  OR 'FANS' = @Category OR 'CASE FAN' = @Category OR 'CASE FANS' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'CPU' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[CPU]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'CPU' = @SearchString OR 'CPUs' = @SearchString OR 'PROCESSOR' = @SearchString OR 'PROCESSORs' = @SearchString)
        AND (@Category IS NULL OR 'CPU' = @Category OR 'CPUs' = @Category OR 'PROCESSOR' = @Category OR 'PROCESSORs' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'GPU' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[GPU]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'GPU' = @SearchString OR 'GPUs' = @SearchString OR 'GRAPHICS CARD' = @SearchString OR 'GRAPHICS CARDs' = @SearchString)
        AND (@Category IS NULL OR 'GPU' = @Category OR 'GPUs' = @Category OR 'GRAPHICS CARD' = @Category OR 'GRAPHICS CARDs' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'RAM' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[RAM]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'RAM' = @SearchString OR 'RAMs' = @SearchString  OR 'MEMORY' = @SearchString OR 'MEMORIES' = @SearchString)
        AND (@Category IS NULL OR 'RAM' = @Category OR 'RAMs' = @Category OR 'MEMORY' = @Category OR 'MEMORIES' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'SSD' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[SSD]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'SSD' = @SearchString OR 'SSDs' = @SearchString OR 'STORAGE' = @SearchString OR 'STORAGES' = @SearchString)
        AND (@Category IS NULL OR 'SSD' = @Category OR 'SSDs' = @Category OR 'STORAGE' = @Category OR 'STORAGES' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'PSU' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[PSU]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'PSU' = @SearchString OR 'PSUs' = @SearchString OR 'POWER SUPPLY' = @SearchString OR 'POWER SUPPLIES' = @SearchString)
        AND (@Category IS NULL OR 'PSU' = @Category OR 'PSUS' = @Category OR 'POWER SUPPLY' = @Category OR 'POWER SUPPLIES' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice)
    UNION
    SELECT 'MOBO' AS [Category], [Id], [Name], [Code], [Brand], [UnitPrice]
    FROM [dbo].[MOBO]
    WHERE (@SearchString IS NULL OR [Name] LIKE '%' + @SearchString + '%' OR [Code] LIKE '%' + @SearchString + '%' OR [Brand] LIKE '%' + @SearchString + '%' OR 'MOBO' = @SearchString OR 'MOBOS' = @SearchString OR 'MOTHERBOARD' = @SearchString OR 'MOTHERBOARDS' = @SearchString)
        AND (@Category IS NULL OR 'MOBO' = @Category OR 'MOBOS' = @Category OR 'MOTHERBOARD' = @Category OR 'MOTHERBOARDS' = @Category)
        AND (@Brand IS NULL OR [Brand] = @Brand)
        AND (@MinPrice IS NULL OR [UnitPrice] >= @MinPrice)
        AND (@MaxPrice IS NULL OR [UnitPrice] <= @MaxPrice);
    END
GO