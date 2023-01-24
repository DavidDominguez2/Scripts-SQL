--CONTAR EL NUMERO DE REGISTROS DE DEPARTAMENTO
SELECT COUNT(*) AS NUMEROREGISTROS FROM DEPT
SELECT COUNT(DEPT_NO) AS NUMEROREGISTROS FROM DEPT
--PODEMOS COMBINAR MAS DE UNA FUNCION DENTRO DE LA MISMA CONSULTA
--MOSTRAR EL MAXIMO SALARIO Y MINIMOS SALARIO DE LOS EMPLEADOS
SELECT MAX(SALARIO) AS MAXIMOSALARIO, 
MIN(SALARIO) AS MINIMOSALARIO FROM EMP
--LAS AGRUPACIONES PUEDEN REALIZARSE POR UNO O MAS CAMPOS
--EJEMPLO: MOSTRAR EL NUMERO DE EMPLEADOS POR CADA OFICIO
--SE UTILIZA LA CLAUSULA GROUP BY CON CADA CAMPO QUE 
--DESEEMOS AGRUPAR.
--TRUCO: PONER EN EL GROUP BY CADA COLUMNA QUE NO SEA
--UNA FUNCION DE AGRUPACION EN EL SELECT
select COUNT(*) AS NUMEROEMPLEADOS, OFICIO 
FROM EMP
GROUP BY OFICIO
--MOSTRAR EL MAXIMO SALARIO POR CADA OFICIO
SELECT MAX(SALARIO) AS MAXIMOSALARIO, OFICIO
FROM EMP
GROUP BY OFICIO
--MOSTRAR EL MAXIMO SALARIO POR CADA OFICIO Y DEPARTAMENTO
SELECT MAX(SALARIO) AS MAXIMOSALARIO, OFICIO, DEPT_NO
FROM EMP
GROUP BY OFICIO, DEPT_NO
--FILTROS EN COLUMNAS DE AGRUPACION
--WHERE: SE APLICA A COLUMNAS DE LA TABLA.  ANTES DE GROUP BY
--HAVING: SE APLICA A COLUMNAS DE LA TABLA Y TAMBIEN A FUNCIONES
--DESPUES DEL GROUP BY
--HAVING ES MAS EFICIENTE SI FILTRAMOS POR CAMPOS DEL SELECT
--MOSTRAR EL NUMERO DE PERSONAS POR DEPARTAMENTO.  
--SOLAMENTE CONTAR LOS QUE SEAN DIRECTORES
SELECT COUNT(*) AS PERSONAS, DEPT_NO
FROM EMP WHERE OFICIO='DIRECTOR'
GROUP BY DEPT_NO
--MOSTRAR EL NUMERO DE PERSONAS POR DEPARTAMENTO.  
--SOLAMENTE CONTAR LOS DEPARTAMENTOS 10 Y 20
SELECT COUNT(*) AS PERSONAS, DEPT_NO
FROM EMP WHERE DEPT_NO IN (10, 20)
GROUP BY DEPT_NO
--MAS EFICIENTE CON EL FILTRO DEL GROUP BY
SELECT COUNT(*) AS PERSONAS, DEPT_NO
FROM EMP
GROUP BY DEPT_NO
HAVING DEPT_NO IN (10,20)
--MOSTRAR EL NUMERO DE PERSONAS POR DEPARTAMENTO.  
--SOLAMENTE MOSTRAR AQUELLOS DEPARTAMENTOS CON 2 O MAS PERSONAS 
--TRABAJANDO
SELECT COUNT(*) AS PERSONAS, DEPT_NO
FROM EMP 
GROUP BY DEPT_NO
HAVING COUNT(*) >= 2