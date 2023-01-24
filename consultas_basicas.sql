--COMENTARIOS
/* VARIAS LINEAS */
--UNA MISMA CONSULTA PUEDE DEVOLVER LOS MISMOS REGISTROS
--PERO EXISTEN CONSULTAS MAS EFICIENTES
--CONSULTA SIMPLE
select * from DEPT
--COLUMNA A COLUMNA ES MAS EFICIENTE
select DEPT_NO, DNOMBRE, LOC from DEPT
--ORDENACION DE DATOS
--SIEMPRE AL FINAL DE LA CONSULTA
--order by columna
----order by columna1, columna2 ASC/DESC
select * from EMP order by salario DESC
select * from EMP order by oficio, salario DESC
--FILTRADO DE DATOS: where
--SOLAMENTE UN where en la consulta
/*OPERADORES DE COMPARACION
    > MAYOR
    >= MAYOR O IGUAL
    < MENOR
    <= MENOR O IGUAL
    = IGUAL
    <> DISTINTO
*/
--TODO LO QUE NO SEA UN NUMERO IRA ENTRE COMILLAS SIMPLES
--SQL SERVER NO DIFERENCIA MAYUSCULAS MINUSCULAS EN SUS DATOS
--TODOS LOS EMPLEADOS DEL DEPARTAMENTO 10
select * from EMP where EMP.DEPT_NO=10
--TODOS LOS EMPLEADOS CON OFICIO 'VENDEDOR'
select * from EMP where OFICIO='VENDEDOR'
--SI DESEAMOS APLICAR MAS UN FILTRO NECESITAMOS LOS 
--OPERADORES RELACIONALES
--AND: TODOS LOS FILTROS DEBEN CUMPLIRSE
--OR: RECUPERA CADA FILTRO DE LA CONSULTA
--NOT: NEGAMOS LA CONSULTA (NO UTILIZAR)
--ESTA BASE DE DATOS ES DE ORACLE DE HACE UN MONTON
--A�OS.  LOS SALARIOS ESTAN EN MENSUALIDADES
--MOSTRAR TODOS LOS ANALISTAS QUE COBREN MAS DE 300.000 AL MES
select * from EMP where OFICIO='ANALISTA' AND SALARIO > 300000
--MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10 Y DEL DEPARTAMENTO 20
select * from EMP where DEPT_NO=10 OR DEPT_NO=20
--QUEREMOS TODOS LOS EMPLEADOS QUE NO SEAN DIRECTOR
--OPERADOR NOT ANTES DE LA CONDICION
select * from EMP where NOT OFICIO='DIRECTOR'
--SIEMPRE CON OPERADORES <>
select * from EMP where OFICIO <> 'DIRECTOR'
--OTROS OPERADORES
--BETWEEN: BUSCA ENTRE DOS CAMPOS INCLUSIVE
select * from EMP where SALARIO BETWEEN 208000 AND 300000
--SON IGUALES
select * from EMP where SALARIO >= 208000 AND SALARIO <= 300000
--OPERADOR IN
--BUSCA COINCIDENCIAS CON DISTINTOS VALORES PARA UN CAMPO
--MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10 Y 20, 40, 55, 66
SELECT * FROM EMP WHERE DEPT_NO=10 OR DEPT_NO=20
OR DEPT_NO=40 OR DEPT_NO=55 OR DEPT_NO=66
--OPERADOR IN ES IGUAL DE EFICIENTE A UN OR
select * from EMP where DEPT_NO IN (10,20,40,55,66)
--OPERADOR NOT IN
--MOSTRAR LOS EMPLEADOS QUE NO SEAN DEL DEPARTAMENTO 10 Y 20
select * from EMP where NOT DEPT_NO IN (10,20) --NO EFICIENTE
select * from EMP where DEPT_NO NOT IN (10,20) --OPERADOR
--OPERADOR LIKE
--SIRVE PARA BUSCAR COINCIDENCIAS DENTRO DE CADENA DE CARACTERES
--UTILIZA COMODINES PARA SUS BUSQUEDAS
--  _ UN CARACTER CUALQUIERA
--  ? UN CARACTER NUMERICO
--  % CUALQUIER CARACTER Y LONGITUD
--MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO COMIENCE POR A
select * from EMP where APELLIDO LIKE 'A%'
--MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO CONTENGA LA LETRA A
select * from EMP where APELLIDO LIKE '%A%'
--MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO SEA DE 4 LETRAS
select * from EMP where APELLIDO LIKE '____'
--CAMPOS CALCULADOS
--SON CAMPOS QUE SE CALCULAN A PARTIR DE DATOS DE LA TABLA
--NO EXISTEN EN LA TABLA
--UN CURSOR NUNCA PUEDE TENER NOMBRES DE COLUMNAS REPETIDOS
--NI TAMPOCO COLUMNAS SIN NOMBRE
--SIEMPRE DEBEMOS INDICAR UN ALIAS
--MOSTRAR EL APELLIDO Y EL SALARIO TOTAL (SALARIO + COMISION)
--DE LOS EMPLEADOS
SELECT APELLIDO, SALARIO + COMISION AS TOTAL FROM EMP
--NO PODEMOS APLICAR FILTROS A LOS CAMPOS CALCULADOS
--WHERE SOLAMENTE FILTRA SOBRE CAMPOS DE LA TABLA
--SI DESEAMOS FILTRAR, DEBEMOS VOLVER A REALIZAR EL CALCULO
--EN EL FILTRO WHERE
--MOSTRAR APELLIDO Y SALARIO TOTAL PERO SOLO LOS EMPLEADOS
--QUE COBRAN DE SALARIO TOTAL MAS DE 370.000
SELECT APELLIDO, SALARIO + COMISION AS TOTAL FROM EMP
WHERE SALARIO + COMISION > 370000
--NO ES UN ESTANDAR ANSI SQL
--CONCATENAR
--MOSTRAR EL APELLIDO Y OFICIO EN UNA SOLA COLUMNA LLAMADA DESCRIPCION
SELECT APELLIDO + OFICIO AS DESCRIPCION FROM EMP
--CLAUSULA DISTINCT
--QUITA LOS RESULTADOS REPETIDOS DE UNA COLUMNA
--SE UTILIZA EN EL SELECT
SELECT DISTINCT OFICIO FROM EMP