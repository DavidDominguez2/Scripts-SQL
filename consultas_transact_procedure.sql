--UTILIZAR TRANSACT DENTRO DE STORED PROCEDURES
CREATE PROCEDURE SP_EVALUAR_SUELDO_EMP
(@APELLIDO NVARCHAR(50)) AS
DECLARE @SUELDO INT
SELECT @SUELDO = SALARIO FROM EMP WHERE APELLIDO = @APELLIDO
IF(@SUELDO < 150000)
BEGIN
	UPDATE EMP SET SALARIO+=10000 WHERE APELLIDO = @APELLIDO
	PRINT 'SUBIDA DE SUELDO DE ' + @APELLIDO + ': ' + CAST(@SUELDO AS NVARCHAR)
END
ELSE IF(@SUELDO > 250000)
BEGIN
	UPDATE EMP SET SALARIO-=2000 WHERE APELLIDO = @APELLIDO
	PRINT 'BAJADA DE SUELDO DE '  + @APELLIDO + ': ' + CAST(@SUELDO AS NVARCHAR)
END
ELSE
BEGIN 
	PRINT 'SALARIO SIN MODIFICACIONES: ' + CAST(@SUELDO AS NVARCHAR)
END
GO
EXEC SP_EVALUAR_SUELDO_EMP 'SANCHA'

--CREAR UN PROCEDIMIENTO PARA INSERTAR UN DOCTOR
--DEBEMOS GENERAR EL ID AUTOMATICAMENTE
--ENVIAMOS EL NOMBRE DEL HOSPITAL
--SI EL HOSPITAL NO EXISTE, NO INSERTAMOS
CREATE PROCEDURE SP_INSERT_DOCTOR
(@APELLIDO NVARCHAR(50), @ESPECIALIDAD NVARCHAR(50),
@SALARIO INT, @NOMBREHOSPITAL NVARCHAR(50))
AS
	DECLARE @IDDOCTOR INT
	DECLARE @IDHOSPITAL INT
	
	SELECT @IDHOSPITAL = HOSPITAL_COD FROM HOSPITAL
	WHERE NOMBRE = @NOMBREHOSPITAL

	IF(@IDHOSPITAL IS NULL)
		BEGIN
			PRINT 'NO EXISTE EL HOSPITAL ' + @NOMBREHOSPITAL
		END
	ELSE
		BEGIN
			SELECT @IDDOCTOR = MAX(DOCTOR_NO) +1
			FROM DOCTOR
			INSERT INTO DOCTOR VALUES
			(@IDHOSPITAL, @IDDOCTOR, @APELLIDO, @ESPECIALIDAD, @SALARIO)
			SELECT * FROM DOCTOR
		END
GO
EXEC SP_INSERT_DOCTOR 'DOMINGUEZ', 'DIAGNOSTICO', 10000000, 'LA PAZZ'

--PROCEDURE DE OUT
CREATE PROCEDURE SP_EMPLEADOS_DEPT_OUT
(@IDDEPT INT, @SUMASALARIAL INT OUT)
AS
	SELECT * FROM EMP
	WHERE DEPT_NO =  @IDDEPT
	--ASIGNAR ALGUN VALOR AL PARAMETRO DE SALIDA 
	--PARA DEVOLVERLO CON VALOR EN LA PETICION
	SELECT @SUMASALARIAL = SUM(SALARIO) FROM EMP
	WHERE DEPT_NO = @IDDEPT
GO
--PARA LA LLAMADA A UN PROCEDIMIENTO ALMACENADO CON
--PARAMETROS DE SALIDA ES NECESARIO UTILIZAR VARIABLES EN
--LA PETICION
DECLARE @RESPUESTA INT
EXEC SP_EMPLEADOS_DEPT_OUT 10, @RESPUESTA OUTPUT
PRINT @RESPUESTA


CREATE PROCEDURE SP_HOSPITALES
AS
	SELECT * FROM HOSPITAL
GO

ALTER PROCEDURE SP_UPDATESALARIOSHOSPITAL
(@NOMBRE NVARCHAR(50), @INCREMENTO INT = 1000) 
AS
	DECLARE @MASASALARIAL INT
	DECLARE @HOSPITAL INT

	SELECT @HOSPITAL = HOSPITAL_COD FROM HOSPITAL WHERE NOMBRE = @NOMBRE
	SELECT @MASASALARIAL = SUM(CAST(SALARIO AS INT)) FROM PLANTILLA WHERE HOSPITAL_COD = @HOSPITAL

	IF(@MASASALARIAL > 1000000)
	BEGIN
		UPDATE PLANTILLA SET SALARIO-=@INCREMENTO WHERE HOSPITAL_COD = @HOSPITAL
		PRINT 'BAJADA DE SUELDO'
	END
	ELSE
	BEGIN
		UPDATE PLANTILLA SET SALARIO+=@INCREMENTO WHERE HOSPITAL_COD = @HOSPITAL
		PRINT 'SUBIDA DE SUELDO'
	END
	SELECT * FROM PLANTILLA WHERE HOSPITAL_COD = @HOSPITAL
GO


CREATE PROCEDURE SP_DEPARTAMENTOS
AS
	SELECT * FROM DEPT
GO

ALTER PROCEDURE SP_INSERT_DEPARTAMENTO
(@IDDEPT INT, @DNOMBRE NVARCHAR(50), @LOCALIDAD NVARCHAR(50))
AS
	--NO QUEREMOS LOCALIDADES EN TERUEL
	IF(@LOCALIDAD = 'TERUEL')
		BEGIN
			PRINT 'TERUEL NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO DEPT VALUES(@IDDEPT, @DNOMBRE, @LOCALIDAD)
		END
GO

ALTER PROCEDURE SP_FIND_EMPLOYEES_BY_DEPT
(@DNOMBRE NVARCHAR(50), @SUMA INT OUT, @MEDIA INT OUT, @PERSONAS INT OUT)
AS
	DECLARE @IDDEPARTAMENTO INT
	SELECT @IDDEPARTAMENTO = DEPT_NO FROM DEPT
	WHERE DNOMBRE = @DNOMBRE
	SELECT * FROM EMP WHERE DEPT_NO=@IDDEPARTAMENTO

	SELECT @SUMA = SUM(SALARIO), @MEDIA = AVG(SALARIO), @PERSONAS = COUNT(EMP_NO) 
	FROM EMP
	WHERE DEPT_NO = @IDDEPARTAMENTO
GO


ALTER PROCEDURE SP_ALL_HOSPITALS_EMPLOYEES
(@NHOSPITAL NVARCHAR(50), @SUMA INT OUT, @MEDIA INT OUT, @PERSONAS INT OUT)
AS
	DECLARE @CODHOSP INT
	SELECT @CODHOSP = HOSPITAL.HOSPITAL_COD FROM HOSPITAL
	WHERE NOMBRE = @NHOSPITAL

	SELECT APELLIDO, SALARIO, DOCTOR_NO AS EMPLEADOS FROM DOCTOR WHERE HOSPITAL_COD = @CODHOSP UNION
	SELECT APELLIDO, SALARIO, EMPLEADO_NO FROM PLANTILLA WHERE HOSPITAL_COD = @CODHOSP

	SELECT @SUMA = ISNULL(SUM(SALARIO),0), @MEDIA = ISNULL(AVG(SALARIO),0), @PERSONAS = COUNT(EMPLEADOS) FROM (
			SELECT APELLIDO, SALARIO, DOCTOR_NO AS EMPLEADOS FROM DOCTOR WHERE HOSPITAL_COD = @CODHOSP UNION
			SELECT APELLIDO, SALARIO, EMPLEADO_NO FROM PLANTILLA WHERE HOSPITAL_COD = @CODHOSP
	) QUERY 
GO


--EMPLEADOSOFICIO
CREATE PROCEDURE SP_ALL_OFICIOS
AS
	SELECT DISTINCT OFICIO FROM EMP 
GO

CREATE PROCEDURE SP_ALL_EMPLEADOS
AS
	SELECT EMP_NO, APELLIDO, OFICIO, DIR, FECHA_ALT, COMISION, DEPT_NO,
	CASE 
		WHEN SALARIO IS NULL THEN -1
		ELSE SALARIO END AS SALARIO
	FROM EMP 
GO


CREATE PROCEDURE SP_EMPLEADOS_OFICIO
(@OFICIO NVARCHAR(50))
AS
	SELECT EMP_NO, APELLIDO, OFICIO, DIR, FECHA_ALT, COMISION, DEPT_NO,CASE 
		WHEN SALARIO IS NULL THEN -1
		ELSE SALARIO END AS SALARIO
	FROM EMP WHERE OFICIO = @OFICIO
GO

CREATE PROCEDURE SP_INCREMENTO_SALARIOS_OFICIO
(@INCREMENTO INT, @OFICIO NVARCHAR(50))
AS
	UPDATE EMP SET SALARIO+=@INCREMENTO WHERE OFICIO = @OFICIO
GO

