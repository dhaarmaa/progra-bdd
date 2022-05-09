
--CASO 1
VAR b_runEmp varchar2(11);
DECLARE
  v_nombreEmp VARCHAR2(20);
  v_sueldo NUMBER(8);
  v_bonificacion number(10);

BEGIN

    :b_runEmp := &ingresoRun1;

    SELECT NOMBRE_EMP || ' ' || APPATERNO_EMP || ' ' || APMATERNO_EMP,
           NUMRUT_EMP || '-'||DVRUT_EMP, sueldo_emp, sueldo_emp*0.4

        INTO
           v_nombreEmp,   
           :b_runEmp,   
           v_sueldo,   
           v_bonificacion
    FROM empleado
    WHERE numrut_emp = :b_runEmp;



     DBMS_OUTPUT.put_line('datos calculo bonificacion del 40% del sueldo');
     DBMS_OUTPUT.put_line('Nombre empleado: ' || v_nombreEmp);
     DBMS_OUTPUT.put_line('Rut empleado: ' || :b_runEmp);
     DBMS_OUTPUT.put_line('Sueldo empleado: ' || v_sueldo);
     DBMS_OUTPUT.put_line('bonificacion empleado: ' || v_bonificacion);

 --secuencia 2

    :b_runEmp := &ingresoRun2;

    SELECT NOMBRE_EMP || ' ' || APPATERNO_EMP || ' ' || APMATERNO_EMP,
           NUMRUT_EMP || '-'||DVRUT_EMP, sueldo_emp, sueldo_emp*0.4
        INTO
           v_nombreEmp,   
           :b_runEmp,  
           v_sueldo,   
           v_bonificacion

    FROM empleado
    WHERE numrut_emp = :b_runEmp;


    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.put_line('datos calculo bonificacion del 40% del sueldo');
    DBMS_OUTPUT.put_line('Nombre empleado: ' || v_nombreEmp);
    DBMS_OUTPUT.put_line('Rut: ' || :b_runEmp);
    DBMS_OUTPUT.put_line('Sueldo: ' || v_sueldo);
    DBMS_OUTPUT.put_line('bonificacion extra: ' || v_bonificacion);

END;

--caso 2

VAR b_runCliente VARCHAR2(12);
DECLARE

  v_nombreCliente VARCHAR2(30);
  v_estadoCliente VARCHAR(100);
  v_rentaCliente NUMBER(10);



BEGIN

    :b_runCliente := &ingresoRut;
    
    SELECT c.NOMBRE_CLI || ' ' || c.APPATERNO_CLI || ' ' || c.APMATERNO_CLI, ec.DESC_ESTCIVIL,
    
          c.NUMRUT_CLI || '-' || c.DVRUT_CLI, 
    
          CASE
          WHEN ec.desc_estcivil = 'Separado' AND c.renta_Cli >= 800000 THEN c.renta_Cli
          WHEN ec.desc_estcivil = 'Separado' AND c.renta_Cli <= 800000 THEN 0
          WHEN ec.desc_estcivil = 'Divorciado' AND c.renta_Cli >= 800000 THEN c.renta_Cli
          WHEN ec.desc_estcivil = 'Divorciado' AND c.renta_Cli <= 800000 THEN 0
          WHEN ec.desc_estcivil = 'Soltero' AND c.renta_Cli <= 800000 THEN c.renta_Cli
          WHEN ec.desc_estcivil = 'Soltero' AND c.renta_Cli >= 800000 THEN c.renta_Cli
          END
          
          INTO
              v_nombreCliente,
              v_estadoCliente,
              :b_runCliente,
              v_rentacliente
    
    FROM cliente c
    JOIN estado_civil ec ON(ec.id_estcivil = c.id_estcivil)
    WHERE numrut_cli = :b_runCliente;


    DBMS_OUTPUT.put_line('DATOS DEL CLIENTE');   
    DBMS_OUTPUT.put_line('-----------------');   
    DBMS_OUTPUT.put_line('NOMBRE: ' || v_nombreCliente);   
    DBMS_OUTPUT.put_line('RUN: ' || :b_runCliente);  
    DBMS_OUTPUT.put_line('ESTADO: ' || v_estadoCliente);   
    DBMS_OUTPUT.put_line('RENTA: ' || v_rentaCliente);

END;
--------------------------------------------------------------------
--caso 3
SET SERVEROUTPUT ON

VAR b_runEmp VARCHAR2(20)
VAR b_porcentaje NUMBER(10)
EXEC : b_porcentaje:=&ingresoPorcentaje

DECLARE

  v_nombreEmp VARCHAR(30);
  v_sueldoActual number(20);
  v_sueldoReajustado number(20);
  v_reajuste number(20);
  v_porcentaje number(10) := :b_porcentaje;

BEGIN

    :b_runEmp := &INGRESORUN;
   -- :b_porcentaje := &ingresoPorcentaje;
    
    SELECT NOMBRE_EMP || ' ' || APPATERNO_EMP || ' ' || APMATERNO_EMP,
           NUMRUT_EMP || '-'||DVRUT_EMP, sueldo_emp --sueldo_emp * :b_porcentaje, (sueldo_emp * :b_porcentaje)-sueldo_emp
           INTO
            v_nombreEmp,
            :b_runEmp,
            v_sueldoActual
         
            
    FROM empleado    
    WHERE numrut_emp = :b_runEmp;
    
    DBMS_OUTPUT.PUT_LINE('NOMBRE DEL EMPLEADO: ' || v_nombreEmp);
    DBMS_OUTPUT.PUT_LINE('RUN: ' || :b_runEmp);
    DBMS_OUTPUT.PUT_LINE('SIMULACION 1: AUMENTAR EN UN' || v_porcentaje|| '% EL SALARIO DE TODOS LOS EMPLEADOS');
    DBMS_OUTPUT.PUT_LINE('SUELDO ACTUAL: '||v_sueldoActual);
   -- DBMS_OUTPUT.PUT_LINE('SUELDO REAJUSTADO: '||v_sueldoReajustado);
   -- DBMS_OUTPUT.PUT_LINE('REAJUSTE: '||v_reajuste);
    
    

END;

--caso 4

SET SERVEROUTPUT ON

DECLARE

    v_descTipoPropiedad varchar2(30);
    v_idTipoPropiedad varchar2(1);
    
    v_totalPropiedades number(3);
    v_valorTotal varchar2(12);

BEGIN
    
    v_idTipoPropiedad := 'A';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);
    
    --secuencia 2
     v_idTipoPropiedad := 'B';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);

--SECUENCIA 3

 v_idTipoPropiedad := 'C';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);

--SECUENCIA 4

     v_idTipoPropiedad := 'D';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);

--SECUENCIA 5

     v_idTipoPropiedad := 'E';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);

--SECUENCIA 6

     v_idTipoPropiedad := 'F';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);

--SECUENCIA 7

     v_idTipoPropiedad := 'G';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);

--SECUENCIA 8

     v_idTipoPropiedad := 'H';
    select id_tipo_propiedad, count(nro_propiedad), to_char(sum(valor_arriendo),'$99G999G999')
    into v_idTipoPropiedad, v_totalPropiedades, v_valorTotal
    from propiedad
    group by id_tipo_propiedad
    having id_tipo_propiedad = v_idTipoPropiedad;
    
    select desc_tipo_propiedad
    into v_descTipoPropiedad
    from tipo_propiedad
    where id_tipo_propiedad = v_idTipoPropiedad;
    
    DBMS_OUTPUT.PUT_LINE('  ');
    DBMS_OUTPUT.PUT_LINE ('RESUMEN DE: '||v_descTipoPropiedad);
    DBMS_OUTPUT.PUT_LINE ('Total de propiedades: '||v_totalPropiedades);
    DBMS_OUTPUT.PUT_LINE ('Valor Total Arriendo:'||v_valorTotal);
END;