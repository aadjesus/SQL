create table GFO_CONTROLEOPERACIONAL_PREV
(
  ID_CONTROLE_OPERACIONAL NUMBER,
  CODIGOVEIC              NUMBER not null,
  CODINTLINHA             number ,
  COD_LOCALIDADE          number  not null,
  DATA_OCORRENCIA         DATE,
  PONTO_CONTROLE          VARCHAR2(1) 
)