SET SERVEROUTPUT ON
VAR b_anno_proceso NUMBER;
--var b_run NUMBER;
DECLARE
v_nombre VARCHAR2(30);
v_run NUMBER(10);
v_drun VARCHAR2(1);
v_sueldoBase NUMBER(10);
v_porc_movil proy_movilizacion.porc_movil_normal%TYPE;
v_valor_movil_normal proy_movilizacion.valor_movil_normal%TYPE;
v_valor_movil_adic proy_movilizacion.valor_movil_extra%type;
v_valor_total_movil proy_movilizacion.valor_total_movil%TYPE;
v_rut_empleado number(10):=11846972;

BEGIN

    :b_anno_proceso := &anno;
    SELECT  
        PNOMBRE_EMP|| ' ' ||SNOMBRE_EMP||' '||APPATERNO_EMP||' ' ||APMATERNO_EMP,
        NUMRUN_EMP,DVRUN_EMP,SUELDO_BASE
    INTO
        v_nombre,
        v_run,
        v_drun,
        v_sueldobase
    FROM EMPLEADO
    WHERE numrun_emp = v_rut_empleado; 
    
    SELECT ROUND(sueldo_base/100000),((sueldo_base/100)*ROUND(sueldo_base/100000)),
        CASE 
            WHEN id_comuna = 117 THEN 20000
            WHEN id_comuna = 118 THEN 25000
            WHEN id_comuna = 119 THEN 30000
            WHEN id_comuna = 120 THEN 35000
            WHEN id_comuna = 121 THEN 40000
            WHEN id_comuna < 117 or id_comuna > 121 THEN 0
            
        END
        INTO 
            v_porc_movil,
            v_valor_movil_normal,
            v_valor_movil_adic
            
    FROM EMPLEADO
    WHERE numrun_emp =v_rut_empleado; 
    
    v_valor_total_movil :=  v_valor_movil_normal + v_valor_movil_adic;
   
    
    --INSERT INTO proy_movilizacion VALUES(1,v_run,v_drun,v_nombre,v_sueldobase,1,1,1,1);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('RUN: ' ||v_run);
    DBMS_OUTPUT.PUT_LINE('DRUN:' || v_drun);
    DBMS_OUTPUT.PUT_LINE('NOMBRE:'||v_nombre);
    DBMS_OUTPUT.PUT_LINE('SUELDO BASE: '||v_sueldobase); 
    DBMS_OUTPUT.PUT_LINE('PORCENTAJE MOVIL:' || v_porc_movil);
    DBMS_OUTPUT.PUT_LINE('VALOR NORMAL: '||v_valor_movil_normal);
    DBMS_OUTPUT.PUT_LINE('VALOR MOVIL ADICIONAL: '||v_valor_movil_adic);
    
    INSERT INTO proy_movilizacion VALUES(:b_anno_proceso,v_run,v_drun,v_nombre,v_sueldobase, v_porc_movil, v_valor_movil_normal, v_valor_movil_adic, v_valor_total_movil);
    
END;

--TRUNCATE TABLE PROY_MOVILIZACION;
--SELECT * FROM proy_movilizacion;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--caso2
set SERVEROUTPUT ON
DECLARE
v_mes_anno vARCHAR2(7);
v_run NUMBER(10);
v_drun VARCHAR2(1);
v_nombre_completo VARCHAR2(50);
v_nombre_usuario VARCHAR2(40);
v_sueldo_en_caracter VARCHAR2(10);
v_clave_usuario VARCHAR2(100);
BEGIN
    SELECT
         PNOMBRE_EMP|| ' ' ||SNOMBRE_EMP||' '||APPATERNO_EMP||' ' ||APMATERNO_EMP,
         NUMRUN_EMP,DVRUN_EMP
    INTO
        v_nombre_completo,
        v_run,
        v_drun
    FROM empleado
    WHERE NUMRUN_EMP = 12648200;
    
    SELECT
        SUBSTR(PNOMBRE_EMP, 0,1,2)--||LENGTH(PNOMBRE_EMP)||'*'||
   -- CASE
       -- WHEN  LENGTH(PNOMBRE_EMP) = 5 THEN SUBSTR(PNOMBRE_EMP, 5)
       -- WHEN  LENGTH(PNOMBRE_EMP) = 6 THEN SUBSTR(PNOMBRE_EMP, 6)
   -- END ||
    --DVRUN_EMP|| ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_CONTRATO)/12) 
    
    INTO
        v_nombre_usuario
    FROM empleado
     WHERE NUMRUN_EMP = 12648200;
     
     DBMS_OUTPUT.PUT_LINE(v_nombre_usuario);
    
--INSERT INTO USUARIO_CLAVE VALUES(v_mes_anno, v_run, v_drun, v_nombre_completo, v_nombre_usuario, v_clave_usuario);

END;

DECLARE
--v_nombre_usuario VARCHAR2(40);
v_sueldo_en_caracter VARCHAR2(10);

BEGIN

SELECT TO_CHAR(SUELDO_BASE)
INTO v_sueldo_en_caracter
FROM empleado
WHERE  NUMRUN_EMP = 12260812;
DBMS_OUTPUT.put_line(v_sueldo_en_caracter);
 --SELECT
        --SUBSTR(PNOMBRE_EMP, 1,3)||LENGTH(PNOMBRE_EMP)||'*'|| SUBSTR(TO_CHAR, )
  
    --DVRUN_EMP|| ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_CONTRATO)/12) 
    
   -- INTO
       -- v_nombre_usuario
 --  FROM empleado
     --WHERE NUMRUN_EMP = 12260812;
     
     --DBMS_OUTPUT.PUT_LINE(v_nombre_usuario);
     
END;