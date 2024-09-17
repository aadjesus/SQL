create or replace trigger TR_xisto
   after insert on gfo_itinerario_servicos
  for each Row
Declare
  V_id_itinerario NUMBER;

begin

  If Inserting Then

          V_id_itinerario = Select max(id_itinerario) From gfo_itinerario Where codintlinha = :New.codintlinha;
          INSERT INTO gfo_itinerario 
                (codintlinha ,id_itinerario ,vigencia_inicial ,ativo )
          VALUES 
                (:New.codintlinha, V_id_itinerario, Sysdate,'A' );

          INSERT INTO gfo_itinerario_itens 
                (CODINTLINHA,ID_ITINERARIO,SENTIDO,SEQUENCIAL,TIPO_LOCAL,COD_LOCALIDADE,DISTANCIA,TEMPO )
          VALUES 
                (:New.codintlinha, V_id_itinerario,:New.SENTIDO, :New.SEQUENCIAL);
                
  End If;

End TR_xisto;
