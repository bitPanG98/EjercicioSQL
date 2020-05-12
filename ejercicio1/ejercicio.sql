CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Ejercicio`()
BEGIN
	
    DECLARE cantidadSemestreActivo INT;
	DECLARE mensajeBotonEntrega VARCHAR(10);
    
    #--Para verificar  estado semestre
    SET cantidadSemestreActivo = (SELECT COUNT(id) 
					FROM semestreacademico 
					WHERE CURDATE()>=Fecha_Inicio AND CURDATE()<=Fecha_Fin);
	
    IF cantidadSemestreActivo > 0 THEN
		SET mensajeBotonEntrega = 'Boton entrega activo - registre entrega';
        
        #--Cargar materiales segun mes por semestre
        SELECT 
			mat.id_Material, mat.Nombre_Material,
			tipma.tipo
		FROM SemestreAcademico semaca,
			Material mat,
			TipoMaterial tipma 
		WHERE 
			(MONTH(CURDATE())=MONTH(semaca.FechaInicio)
			AND tipma.tipo='Plumones'
			AND tipma.tipo='Motas')
			OR 
            (MONTH(CURDATE())>=MONTH(DATE_ADD(semaca.FechaInicio, interval 1 month)) 
			AND tipma.tipo='Recargas'
			OR tipma.tipo='Otros');

    ELSE
		SET mensajeBotonEntrega = 'Boton entrega inactivo - Registre semestre';
    END IF;
    
END