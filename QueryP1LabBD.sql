CREATE DATABASE campeonatoPaulista
GO
USE campeonatoPaulista
GO
CREATE TABLE times(
cod_time            INT           NOT NULL,
nome_time           VARCHAR(200)  NOT NULL,
cidade              VARCHAR(200)  NOT NULL,
estadio             VARCHAR(200)  NOT NULL,
material_esportivo  VARCHAR(200)  NOT NULL
PRIMARY KEY (cod_time)
)
GO
CREATE TABLE grupos(
cod_time      INT      NOT NULL,
grupo         CHAR(1)  NOT NULL,
PRIMARY KEY (grupo, cod_time),
FOREIGN KEY (cod_time) REFERENCES times (cod_time)
)
GO
CREATE TABLE jogos(
cod_rodada     INT       NOT NULL,
cod_timeA      INT       NOT NULL,
cod_timeB      INT       NOT NULL,
gols_timeA     INT       NOT NULL,
gols_timeB     INT       NOT NULL,
data_jogo      DATETIME  NOT NULL,
PRIMARY KEY (cod_timeA, cod_timeB, data_jogo)
)
GO
INSERT INTO times VALUES 
(1,'Água Santa', 'Diadema', 'Distrital do Inamar', 'Karilu'),
(2, 'Botafogo-SP', 'Ribeirão Preto', 'Santa Cruz', 'Volt Sport'),
(3, 'Corinthians', 'São Paulo', 'Neo Química Arena', 'Nike'),
(4, 'Ferroviária', 'Araraquara', 'Fonte Luminosa', 'Lupo'),
(5, 'Guarani', 'Campinas', 'Brinco de Ouro', 'Kappa'),
(6, 'Inter de Limeira', 'Limeira', 'Limeirão', 'Alluri Sports'),
(7, 'Ituano', 'Itu', 'Novelli Júnior', 'Kanxa'),
(8, 'Mirassol', 'Mirassol', 'José Maria de Campos Maia', 'Super Bolla'),
(9, 'Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biase', 'Physicus'),
(10, 'Palmeiras', 'São Paulo', 'Allianz Parque', 'Puma'),
(11, 'Ponte Preta', 'Campinas', 'Moisé Lucarelli', '1900'),
(12, 'Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 'Nike'),
(13, 'Santo André', 'Santo André', 'Bruno José Daniel', 'Icone Sports'),
(14, 'Santos', 'Santos', 'Vila Belmiro', 'Umbro'),
(15, 'São Bernardo', 'São Bernardo do Campo', 'Primeiro de Maio', 'Magnum Group'),
(16, 'São Paulo', 'São Paulo', 'Morumbi', 'Adidas')

CREATE PROCEDURE sp_divide_times_em_grupos
AS
BEGIN
  DECLARE @grupoA TABLE (cod_time int, grupo VARCHAR(1))
  DECLARE @grupoB TABLE (cod_time int, grupo VARCHAR(1))
  DECLARE @grupoC TABLE (cod_time int, grupo VARCHAR(1))
  DECLARE @grupoD TABLE (cod_time int, grupo VARCHAR(1))

  -- Adiciona todos os times em uma tabela temporária para facilitar a divisão
  DECLARE @todosOsTimes TABLE (cod_time int)
  INSERT INTO @todosOsTimes (cod_time)
  SELECT cod_time FROM times

  -- Garante que os quatro times não estejam no mesmo grupo
  DECLARE @times_excluidos TABLE (cod_time int)
  INSERT INTO @times_excluidos SELECT cod_time FROM times WHERE nome_time IN ('Corinthians', 'Palmeiras', 'Santos', 'São Paulo')
	

  -- Distribui os times aleatoriamente nos quatro grupos
  WHILE (SELECT COUNT(*) FROM @todosOsTimes) > 0
  BEGIN
    DECLARE @codigoTime int
    SELECT TOP 1 @codigoTime = cod_time FROM @todosOsTimes ORDER BY NEWID()

    -- Verifica em que grupo o time deve ser inserido
    IF (SELECT COUNT(*) FROM @grupoA) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoA(cod_time, grupo) VALUES (@codigoTime, 'A')
    END
    ELSE IF (SELECT COUNT(*) FROM @grupoB) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoB (cod_time, grupo) VALUES (@codigoTime, 'B')
    END
    ELSE IF (SELECT COUNT(*) FROM @grupoC) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoC (cod_time, grupo) VALUES (@codigoTime, 'C')
    END
    ELSE IF (SELECT COUNT(*) FROM @grupoD) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoD (cod_time, grupo) VALUES (@codigoTime, 'D')
    END

	-- Remove o time da tabela temporária
    DELETE FROM @todosOsTimes WHERE cod_time = @codigoTime
    END

  -- Insere os times nos grupos definitivos
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoA
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoB
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoC
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoD
END

GO
exec sp_divide_times_excluidos
GO
exec sp_divide_times_em_grupos
GO
SELECT * FROM grupos



CREATE PROCEDURE sp_divide_times_excluidos
AS
    DECLARE @grupo          CHAR(1),
            @grupos VARCHAR(4),
            @time_exclui    INT

    DECLARE @times_excluidos TABLE (cod_time int)
    INSERT INTO @times_excluidos SELECT cod_time FROM times WHERE nome_time IN ('Corinthians', 'Palmeiras', 'Santos', 'São Paulo')

	DELETE FROM grupos

	SET @grupos = 'ABCD'
    WHILE (SELECT COUNT(*) FROM @times_excluidos) > 0
    BEGIN
		SET @time_exclui = (SELECT TOP 1 cod_time FROM @times_excluidos ORDER BY RAND() * (SELECT COUNT(*) FROM @times_excluidos))
		SET @grupo = SUBSTRING(@grupos, CAST(RAND() * LEN(@grupos) + 1 AS INT), 1)
        INSERT INTO grupos VALUES (@time_exclui, @grupo)
		DELETE FROM @times_excluidos WHERE cod_time = @time_exclui
		SET @grupos = REPLACE(@grupos, @grupo, '')
	END

exec sp_divide_times_excluidos
SELECT* FROM grupos


CREATE PROCEDURE sp_gerar_rodadas
AS
	DECLARE @times_rodada TABLE (cod_time INT, grupo CHAR(1))
	DECLARE	@rodada TABLE (num_rodada INT, timeA INT, timeB INT, golsA INT, golsB INT, data_rodada DATE)
	DECLARE	@numRodadas INT = 1,
			@numJogos INT = 1,
			@timeA INT,
			@timeB INT,
			@dataRodada DATE = '2022-01-23',
			@diaSemana VARCHAR(10) = 'domingo'

	INSERT INTO @times_rodada SELECT cod_time, grupo FROM grupos
	
	WHILE @numRodadas <= 12
	BEGIN
		DELETE FROM @rodada
		SET @numJogos = 1

		WHILE @numJogos <= 8
		BEGIN
			 -- seleciona um time aleatório
                 -- Sorteia o time A
            SELECT TOP 1 @timeA = cod_time
            FROM @times_rodada
            WHERE grupo NOT IN (SELECT grupo FROM @times_rodada WHERE cod_time = @timeB)
            ORDER BY NEWID()

            -- Sorteia o time B
            SELECT TOP 1 @timeB = cod_time
            FROM @times_rodada
            WHERE grupo NOT IN (SELECT grupo FROM @times_rodada WHERE cod_time = @timeA)
            ORDER BY NEWID()

			-- verifica se o time já jogou contra o outro time selecionado
			IF NOT EXISTS(SELECT * FROM @rodada WHERE ((timeA = @timeA AND timeB = @timeB) OR (timeA = @timeB AND timeB = @timeA)) AND data_rodada = @dataRodada)
			BEGIN
				INSERT INTO @rodada VALUES(@numRodadas, @timeA, @timeB, CAST(ROUND(RAND() * 7 + 1, 0) AS INT), CAST(ROUND(RAND() * 9 + 1, 0) AS INT), @dataRodada)
				DELETE FROM @times_rodada WHERE cod_time = @timeA
				DELETE FROM @times_rodada WHERE cod_time = @timeB
			END

			SET @numJogos = @numJogos + 1
		END
		
		INSERT INTO jogos SELECT * FROM @rodada
		INSERT INTO @times_rodada SELECT cod_time, grupo FROM grupos 
		
		SET @numRodadas = @numRodadas + 1

			-- Atualiza a data para a próxima rodada
        IF @diaSemana = 'domingo'
        BEGIN
            SET @diaSemana = 'quarta'
            SET @dataRodada = DATEADD(day, 3, @dataRodada)
        END
        ELSE
        BEGIN
            SET @diaSemana = 'domingo'
            SET @dataRodada = DATEADD(day, 4, @dataRodada)
        END

	END

EXEC sp_gerar_rodadas
SELECT * FROM jogos ORDER BY data_jogo
DELETE FROM jogos
