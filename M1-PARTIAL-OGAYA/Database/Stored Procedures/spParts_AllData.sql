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