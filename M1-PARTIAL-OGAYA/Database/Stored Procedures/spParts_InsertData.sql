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