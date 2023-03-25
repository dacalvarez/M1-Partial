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
