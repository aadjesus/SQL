Create Or Alter FUNCTION [dbo].[Monitora_ObterFaturamento] (@pDataBase date, @pId_Fornecedor Int, @pSomenteAceitos bit = 0, @pDia Int = 0)          
RETURNS Numeric(9,2)          
AS          
BEGIN          
    Declare @vValor         Numeric(14,6)          
          , @vPedidos       Numeric(14,6)
          , @vDataInicio    Date
          , @vDataFim       DateTime          
          , @vIdTabelaPreco Int          
             
    Set @vDataInicio = Cast(FORMAT(@pDataBase, 'yyyy-MM-') + '01' as date)

    If (@pDia = 0)  
        Set @vDataFim = DateAdd(Minute, 59, DateAdd(Hour, 23, Convert(DAteTime, DAteAdd(Day, -1, DateAdd(Month, 1, Convert(Date, Convert(Varchar, @pAno) + '-' + Convert(Varchar, (@pMes)) + '-01') )))  ))      
    Else  
        Set @vDataFim = DateAdd(Minute, 59, DateAdd(Hour, 23, Convert(DAteTime, Convert(Date, Convert(Varchar, @pAno) + '-' + Convert(Varchar, (@pMes)) + '-' + Convert(Varchar, (@pDia)) ) ) ))              
            
    Select @vPedidos = IsNull(Sum(a.Valor_Total), 0)
      From Pedido a
     Inner Join Fornecedor b On a.ID_Fornecedor = b.Id 
     Where @pSomenteAceitos = 0 Or (a.Ativo = 1 And b.Data_Hora_Entrada >= b.Data_Primeira_Ativacao) 
       And a.Data_hora_Entrada Between @vDataInicio And @vDataFim 
       And a.Id_Fornecedor = @pId_Fornecedor
             
    Select @vValor = IsNull(Max(c.Valor),0)
      From Fornecedor            a
      Left Join TabelaPreco      b On (a.Id_Tabela_Preco = b.Id or b.Padrao = 1)
      Left Join TabelaPrecoFaixa c On b.Id = c.Id_Tabela_Preco	
     Where a.Ativo = 1
       And a.Id    = @pId_Fornecedor 
       And @vPedidos between c.Faixa_Inicio and c.Faixa_Fim
                   
    Return @vValor
End