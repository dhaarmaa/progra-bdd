--caso2
set SERVEROUTPUT ON
DECLARE
v_mes_anno vARCHAR2(7);
v_run NUMBER(10);
v_drun VARCHAR2(1);
v_nombre_completo VARCHAR2(50);
v_nombre_usuario VARCHAR2(40);
v_clave_usuario VARCHAR2(100);
BEGIN

    SELECT
         PNOMBRE_EMP|| ' ' ||SNOMBRE_EMP||' '||APPATERNO_EMP||' ' ||APMATERNO_EMP,
         NUMRUN_EMP,DVRUN_EMP,
         to_char(SYSDATE,'MMYYYY')
    INTO
        v_nombre_completo,
        v_run,
        v_drun,
        v_mes_anno
    FROM empleado
    WHERE NUMRUN_EMP = 12648200;
    
    --CREACION DE NOMBRE DE USUARIO
    SELECT
        SUBSTR(PNOMBRE_EMP, 1,3)||LENGTH(PNOMBRE_EMP)||'*'|| SUBSTR(TO_CHAR(SUELDO_BASE), -1)||
        DVRUN_EMP|| ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_CONTRATO)/12) ||
        CASE
            WHEN ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_CONTRATO)/12) < 10 THEN 'X'
            WHEN ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_CONTRATO)/12) >=10 THEN ''
        END
    
    INTO
        v_nombre_usuario
   FROM empleado
     WHERE NUMRUN_EMP = 12260812;
     
     DBMS_OUTPUT.PUT_LINE(v_nombre_usuario);
     DBMS_OUTPUT.PUT_LINE(v_mes_anno);
     
     --creacion de clave de usuario
     SELECT 
        SUBSTR(TO_CHAR(e.NUMRUN_EMP),3,1)||to_char(e.fecha_nac,'YYYY')+2||
        SUBSTR(TO_CHAR(e.SUELDO_BASE), -3,3)-1||
        CASE
            WHEN ID_ESTADO_CIVIL = 10  OR ID_ESTADO_CIVIL = 60 THEN SUBSTR(LOWER(APPATERNO_EMP),1,2)
            WHEN ID_ESTADO_CIVIL = 20 OR ID_ESTADO_CIVIL = 30 THEN SUBSTR(LOWER(APPATERNO_EMP),1,1)||SUBSTR(LOWER(APPATERNO_EMP),-1,1)
            WHEN ID_ESTADO_CIVIL = 40 THEN SUBSTR(LOWER(APPATERNO_EMP),-3,2)--LA ANTEPENULTIMA Y PENULTIMA
            WHEN ID_ESTADO_CIVIL = 50 THEN SUBSTR(LOWER(APPATERNO_EMP),-2,2)--DOS ULTIMAS
        END||
        to_char(SYSDATE,'MMYYYY')||
        SUBSTR(c.nombre_comuna,1,1)
        
        INTO v_clave_usuario
        FROM empleado e
        JOIN COMUNA c ON(e.id_comuna = c.id_comuna)
        WHERE NUMRUN_EMP = 12260812;
        DBMS_OUTPUT.put_line(v_run);
    
    INSERT INTO USUARIO_CLAVE VALUES(v_mes_anno, v_run, v_drun, v_nombre_completo, v_nombre_usuario, v_clave_usuario);

END;

