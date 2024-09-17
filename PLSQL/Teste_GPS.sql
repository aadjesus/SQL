Select * From Table(GPSTESTEALE.fc_retornar_newsgps(50000));
Select * From GPSTESTEALE.posicionamento a;
Select * From posicionamento;
Select *  From diariatrecho Where ID = 316;
Select * From realizadatrecho Where iddiariatrecho = 316;    
Select * From horario Where ID = 2024;                   
Delete posicionamento;
Delete GPSTESTEALE.posicionamento;

-- Insert partida
Insert Into GPSTESTEALE.posicionamento(id, origem, dado)
Values
    (GPSTESTEALE.seq_posicionamento.Nextval,
     'NEWSGPSVIEWMODEL',
     '{
     "Servico":"4680",
     "Placa":"AKB1122",
     "Latitude":"-12.7259895861961",
     "Longitude":"-60.1911931335967",
     "PontoAtual":"160114",
     "CodigoDaLinha":"637",
     "Evento":"Entrada de cerca",
     "DataComunicacao":"' || to_char(Sysdate, 'YYYY-MM-DD') ||
      ' 09:00:00' || '
}')

-- Insert chegada
Insert Into GPSTESTEALE.posicionamento(id, origem, dado)
Values
    (GPSTESTEALE.seq_posicionamento.Nextval,
     'NEWSGPSVIEWMODEL',
     '{
     "Servico":"4680",
     "Placa":"AKB1122",
     "Latitude":"-11.6765886035305",
     "Longitude":"-61.1906343699913",
     "PontoAtual":"160114",
     "CodigoDaLinha":"637",
     "Evento":"Entrada de cerca",
     "DataComunicacao":"' || to_char(Sysdate, 'YYYY-MM-DD') ||
      ' 12:15:00' || '
}')

Update localidade Set Latitude = '-12.7259895861961', Longitude = '-60.1911931335967' Where ID = 1215;
Update localidade Set Latitude  = '-11.6765886035305', Longitude = '-61.1906343699913' Where ID = 204;

Select a.id,
       c.placa Veic_Dia,
       d.placa Veic_Rea,
       to_char(f.inicio, 'HH24:MI:SS'),
       to_char(f.fim, 'HH24:MI:SS'),
       g.ID || ': ' || g.latitude || ' / ' || g.longitude As origem,
       h.ID || ': ' || h.latitude || ' / ' || h.longitude As destino,
       b.ID,
       i.*
  From diariatrecho a
  Left Join realizadatrecho b On a.ID = b.iddiariatrecho
  Left Join veiculo c On c.ID = a.idveiculo
  Left Join veiculo d On d.ID = b.idveiculo
  Left Join programadotrecho e On e.ID = a.idprogramadotrecho
  Left Join horario f On f.ID = e.idhorario
  Left Join localidade g On g.ID = e.idorigem
  Left Join localidade h On h.ID = e.iddestino
  Left Join horario i On i.ID = b.idhorario
 Where (a.idveiculo Is Not Null Or b.idveiculo Is Not Null)