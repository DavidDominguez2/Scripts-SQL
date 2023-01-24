--MOSTRAR EL APELLIDO Y EL NOMBRE DEL DEPARTAMENTO
--DE LOS EMPLEADOS
SELECT EMP.APELLIDO, DEPT.DNOMBRE
FROM EMP
INNER JOIN DEPT
ON EMP.DEPT_NO = DEPT.DEPT_NO
--PODEMOS UTILIZAR ALIAS PARA LAS TABLAS EN LA CONSULTA
--SI UTILIZAMOS ALIAS SE LLAMARA ASI PARA TODA LA CONSULTA
SELECT e.APELLIDO, d.DNOMBRE
FROM EMP e
INNER JOIN DEPT d
ON e.DEPT_NO = d.DEPT_NO
--TAMBIEN PODEMOS OMITIR EL NOMBRE DE LAS TABLAS
--EN LA CONSULTA SELECT (MALA PRAXIS)
SELECT APELLIDO, DNOMBRE
FROM EMP
INNER JOIN DEPT
ON EMP.DEPT_NO = DEPT.DEPT_NO