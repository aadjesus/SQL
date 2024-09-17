Create Or Alter Procedure [dbo].[Monitora_ObterOverview] (@pDataInicial DAtetime = Null, @pDataFinal Datetime = null)
As 
Begin            
	Set NoCount On            
			
	if (@pDataInicial Is Null)
		Set @pDataInicial =  Convert(Date, Convert(Varchar, DAtePart(YEar, GetDate())) + '-' + Convert(Varchar, (DatePart(Month, GetDate()))) + '-01')           
	if (@pDataFinal Is Null) 
		Set @pDataFinal = GetDate()
			
	Create Table #Monitora 
		(Data				    DateTime
		,Cotacoes				Int
		,Pedidos				Int
		,ValorPedidos			Numeric(14,6)
		,FornecedoresAtivados   Int
		,FornecedoresInativados Int
		,Faturamento			Numeric(14,6))            
			
	Declare @vFor			Int
		  , @vData			Date
		  , @vCount			Int
		  , @vValor			Numeric(14,6)
		  , @vQuantidadeDias Int            
			
	Set @vQuantidadeDias = DateDiff(Day, @pDataInicial, @pDataFinal) + 1           
	Set @vFor = 0

	While @vFor < @vQuantidadeDias Begin            
		Set @vData = DateAdd(Day, @vFor * -1, @pDataFinal)            
		Insert Into #Monitora (Data ) VAlues (@vData)            
			
		Select @vCount = Count(*) 
		     , @vValor = Sum(VAlor_Total)            
		  From Pedido COT 
		 Inner Join Comprador COM On COT.Id_Comprador = COM.Id 
		 Where Convert(Date, Data_Hora_Entrada, 103) = @vData            
			
		Update #Monitora 
		   Set Pedidos = @vCount
		     , ValorPedidos = @vValor 
	     Where Data = @vData
			
		Select @vCount = Count(*)             
		  From Cotacao COT 
		 Inner Join Comprador COM On COT.Id_Comprador = COM.Id 
		 Where Convert(Date, Data_Abertura, 103) = @vData            
			
		Update #Monitora 
		   Set Cotacoes = @vCount 
		 Where Data = @vData            
			
		Select @vCount = Count(*)              
		  From Fornecedor FO       
		 Where Convert(Date, FO.Data_Primeira_Ativacao, 103) = @vData
		
		Update #Monitora 
		   Set FornecedoresAtivados = @vCount 
		 Where Data = @vData    
		
		Select @vCount = Count(*)              
		  From Fornecedor FO 
		 Where Convert(Date, FO.Data_Inativo, 103) = @vData
		
		Update #Monitora 
		   Set FornecedoresInativados = @vCount 
		 Where Data = @vData    
		
		Update #Monitora 
		   Set Faturamento = (Select Sum(dbo.Monitora_ObterFaturamento(@pDataFinal, FT.id, 1, Datepart(day,  @vData))) 
								From Fornecedor FT) 
         Where Data = @vData
			
		Set @vFor = @vFor + 1            
	End --While            
			
	Select Data
		 , Case Datepart(dw,  Data) 
			When 7 Then 'Sábado' 
			When 6 Then 'Sexta' 
			When 5 Then 'Quinta' 
			When 4 Then 'Quarta' 
			When 3 Then 'Terça' 
			When 2 Then 'Segunda' 
			When 1 Then 'Domingo' 
		   End as [Dia da semana]
		 , IsNull(Cotacoes, 0) As [Qtd de cotações no dia]
		 , IsNull(Pedidos, 0) As [Qtd de pedidos no dia]
		 , Format(IsNull(ValorPedidos, 0), 'C', 'pt-BR') As [Valor dos pedidos no dia]
		 , (Select Format(IsNull(Sum (C.ValorPedidos), 0), 'C', 'pt-BR') 
			  From #Monitora C 
			 Where C.Data Between @pDataInicial And DAteAdd(Minute, -1, DateAdd(Day, 1, B.Data))) As [Valor acumulado de pedidos]
		 , (Select Format(IsNull(Sum (D.VAlor_Total), 0), 'C', 'pt-BR') 
			  From pedido D 
			 Where D.[Data_Hora_Entrada] Between DateAdd(Month, -1, B.Data) And DateAdd(Month, -1, DAteAdd(Minute, -1, DateAdd(Day, 1, B.Data)))) As [Valor diario mês anterior]
		 , (Select Format(IsNull(Sum (D.VAlor_Total), 0), 'C', 'pt-BR') 
		      From pedido D 
			 Where D.[Data_Hora_Entrada] Between DateAdd(Month, -1, @pDataInicial) And DateAdd(Month, -1, DAteAdd(Minute, -1, DateAdd(Day, 1, B.Data)))) As [Valor acumulado mês anterior]
		 , (Select Format(IsNull(Sum( F.VAlor_Total), 0), 'C', 'pt-BR') 
		      From pedido F 
			 Where F.[Data_Hora_Entrada] Between DateAdd(Week, -1, b.Data)  And  DateAdd(Week, -1, DAteAdd(Minute, -1, DateAdd(Day, 1, B.Data)))) [Valor diario semana passada]
		 , FornecedoresAtivados As [Fornecedores Ativados no dia]
		 , FornecedoresInativados As [Fornecedores Inativados no dia]
		 , Format(Faturamento, 'C', 'pt-BR') As [Faturamento acumulado]    
	  From #Monitora B            
	 Order By Data Desc            
				
	Select Sum(Cotacoes) As [Qtd total de cotações no período]
	     , Sum(Pedidos) As [Qtd total de pedidos no período]
		 , Format(Sum(ValorPedidos), 'C', 'pt-BR') As [Valor total de pedidos no período]
		 , Sum(FornecedoresAtivados) As [Fornecedores Ativados no período]
		 , Sum(FornecedoresInativados) As [Fornecedores Inativados no período]
		 , Format((Select Sum (dbo.Monitora_ObterFaturamento(@pDataFinal, id, 1)) 
					 From Fornecedor), 'C', 'pt-BR') As [Faturamento real no período]
		 , Format((Select Sum (dbo.Monitora_ObterFaturamento(@pDataFinal, id, 0)) 
					 From Fornecedor), 'C', 'pt-BR') As [Faturamento possivel no período]        
	  From #Monitora            
			
	Drop Table #Monitora            
			
	Set NoCount Off            
End --Procedure 