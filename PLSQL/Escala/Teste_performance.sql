Update OSASCO180417.Frt_cadveiculos Set id_externo = Null;
        
Insert Into EscalaTesteAle.Veiculo
    (ID,
     placa,
     prefixo,
     idfilial,
     idtecnologia,
     idexterno )
    SELECT EscalaTesteAle.seq_Veiculo.Nextval,
           Replace(a.placaatualveic, '-', ''),
           a.prefixoveic,
           c.id,
           e.id,
           a.id_externo
      From OSASCO180417.frt_cadveiculos a
     Inner Join EscalaTesteAle.Empresa b On a.codigoempresa = b.codigo
     Inner Join EscalaTesteAle.Filial c On b.ID = c.idempresa And c.codigo = a.codigofl
     Inner Join OSASCO180417.Frt_Tipodefrota d On a.codigotpfrota = d.codigotpfrota
     Inner Join EscalaTesteAle.Tecnologia e On d.id_externo = e.idexterno
     
