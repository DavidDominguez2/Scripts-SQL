CREATE PROCEDURE SP_INSERT_SERIE
(@NOMBRE NVARCHAR(50), @IMAGEN NVARCHAR(MAX), @ANYO INT)
AS
	DECLARE @ID INT;
	SELECT @ID = MAX(IDSERIE)+1 FROM SERIES;

	INSERT INTO SERIES VALUES(@ID, @NOMBRE, @IMAGEN, 10 , @ANYO)
GO


EXEC SP_INSERT_SERIE  @NOMBRE = 'YOU', @IMAGEN='https://media.revistagq.com/photos/616d3352115cec0315ba5edf/master/pass/you.jpeg',@ANYO= 2018
