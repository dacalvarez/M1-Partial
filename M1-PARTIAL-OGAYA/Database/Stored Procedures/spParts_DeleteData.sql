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