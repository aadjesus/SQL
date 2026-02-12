--select * from Funcionario where nome like '%gue%'
--select * from Local where id = 370

DECLARE @DataInicio DATETIME = '20260217 08:00:00'; -- Formato ISO: AAAAMMDD (sem traços)
DECLARE @DataFim    DATETIME = '20261231 23:59:59';

-- 2. CTE Recursiva
WITH DatasGeradas AS (
    SELECT 
        @DataInicio AS Inicio,
        DATEADD(HOUR, 10, @DataInicio) AS Fim
    
    UNION ALL
    
    SELECT 
        DATEADD(WEEK, 1, Inicio),
        DATEADD(WEEK, 1, Fim)
    FROM DatasGeradas
    WHERE DATEADD(WEEK, 1, Inicio) <= @DataFim
)

-- 3. Inserção
INSERT INTO Reserva (
    IdFuncionario, 
    IdLocal, 
    IdTipo, 
    DataHoraReservadaInicial, 
    DataHoraReservadaFinal, 
    Motivo,
    DataOperacao
)
SELECT 
    7,                                      -- IdFuncionario
    370,                                      -- IdLocal
    2,                                      -- IdTipo
    Inicio AT TIME ZONE 'E. South America Standard Time' AT TIME ZONE 'UTC', -- Garante que não é NULL
    Fim AT TIME ZONE 'E. South America Standard Time' AT TIME ZONE 'UTC',    -- Garante que não é NULL
    'Reservado para o time do financeiro as terças',
    GETDATE()                              -- DataOperacao
FROM DatasGeradas
OPTION (MAXRECURSION 100);