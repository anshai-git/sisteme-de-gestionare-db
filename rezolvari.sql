--
-- Fill DB
--

-- cluburi
INSERT INTO dbo.[cluburi] (Denumire) 
VALUES 
(CONVERT(VARBINARY, 'club_1')),
(CONVERT(VARBINARY, 'club_2')),
(CONVERT(VARBINARY, 'club_3')),
(CONVERT(VARBINARY, 'club_4')),
(CONVERT(VARBINARY, 'club_5'));

SELECT CONVERT(VARCHAR(MAX), Denumire) FROM dbo.[cluburi];

-- discipline
INSERT INTO dbo.[discipline] (denumire, descriere) 
VALUES 
('rust',	'the only one that counts'),
('cpp',		'must do it'),
('ocaml',	'cool af'),
('lua',		'why not');

SELECT * FROM dbo.[discipline];

-- competitii
INSERT INTO dbo.[competitii] (denumire, localiate, data_desf) 
VALUES
('competition_1',	'Oradea',	'2021-01-01T00:00:00'),
('competition_2',	'Cluj',		'2022-01-01T00:00:00'),
('competition_3',	'Vaslui',	'2023-01-01T00:00:00'),
('competition_4',	'Cluj',		'2024-01-01T00:00:00');

SELECT * FROM dbo.[competitii];

-- competitii-discipline
INSERT INTO [competitii-discipline] (id_concurs, id_disciplina) 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4);

SELECT * FROM dbo.[competitii-discipline];

-- sportivi
insert into dbo.[sportivi] (nume, prenume, Data_nasterii, Sex, id_club) 
values
('nume_1',	'prenume_1',	'2000-05-06T00:00:00', 'M', 1),
('nume_2',	'prenume_2',	'1999-05-06T00:00:00', 'M', 1),
('nume_3',	'prenume_3',	'2001-05-06T00:00:00', 'M', 2),
('nume_4',	'prenume_4',	'2010-05-06T00:00:00', 'M', 2),
('nume_5',	'prenume_5',	'1990-05-06T00:00:00', 'M', 3),
('nume_6',	'prenume_6',	'2000-01-03T00:00:00', 'F', 3),
('nume_7',	'prenume_7',	'2005-01-06T00:00:00', 'F', 4),
('nume_8',	'prenume_8',	'2002-03-01T00:00:00', 'F', 4),
('nume_9',	'prenume_9',	'2006-01-01T00:00:00', 'F', 4),
('nume_10',	'prenume_10',	'1995-01-05T00:00:00', 'F', 5);

SELECT * FROM dbo.[sportivi];

-- participari-rezultate

INSERT INTO dbo.[participari-rezultate] (id_sportiv, p1, p2, p3, total) 
VALUES
(1, '10:00:00',	'01:00:00',	'05:00:00',	'16:00:00'),
(2, '1:00',		'10:00',	'10:00',	'21:00'),
(3, '1:00',		'10:00',	'10:00',	'21:00'),
(4, '1:00',		'1:00',		'1:00',		'3:00');

SELECT * FROM [participari-rezultate];


--  
-- Exercitii
--


-- -- -- -- -- -- -- -- -- -- -- -- L3 -- -- -- -- -- -- -- -- -- -- -- --

-- L3 (1) Renuntam la id_participare
ALTER TABLE dbo.[participari-rezultate]
DROP COLUMN id_participare;

-- L3 (2) Adaugati autoincrement la toate keile primare
-- rezolvat din MSSMS UI || modificat script "triatlon.sql"

-- L3 (3) adaugati index de unicitate pe coloana denumire din tabela Cluburi
CREATE UNIQUE INDEX idx_denumire 
ON dbo.[cluburi] (denumire);

-- L3 (4) adaugati un index compus pe coloanele Nume si Prenume din tabela sportivi ascendent
CREATE INDEX idx_nume_prenume 
ON dbo.[sportivi] (Nume ASC, Prenume ASC);

-- L3 (5) Scrieti o tranzactie care insereaza 3 cluburi si verifica daca sunt erori la inserare.
-- tranzactia sa aiba savepointuri dupa primele 2 inserari( folositi exemplul din curs)
BEGIN TRY
	BEGIN TRANSACTION;

    INSERT INTO Cluburi (denumire) VALUES (CONVERT(varbinary, 'test_club_1'));
    INSERT INTO Cluburi (denumire) VALUES (CONVERT(varbinary, 'test_club_2'));
    
    SAVE TRANSACTION dupa_inserare_2;
    
    INSERT INTO Cluburi (denumire) VALUES (CONVERT(varbinary, 'test_club_3'));
    COMMIT;
    
    PRINT 'Tranzactie finalizata cu succes.';
END TRY
BEGIN CATCH
    PRINT 'Eroare la tranzactie >> ROLLBACK';
	ROLLBACK;
END CATCH;

-- -- -- -- -- -- -- -- -- -- -- -- L4 -- -- -- -- -- -- -- -- -- -- -- --

-- L4 (1) Scrieti o procedura stocata care afiseaza concursurile viitoare.

-- 'CREATE PROCEDURE' must be the only statement in the batch
-- https://stackoverflow.com/questions/41022645/create-procedure-must-be-the-only-statement-in-the-batch-erro
-- In SSMS the GO keyword splits the statement into separate batches
GO 

CREATE PROCEDURE list_future_competitions AS
BEGIN
    SELECT * FROM dbo.[competitii]
    WHERE data_desf > GETDATE();
END;

EXEC dbo.list_future_competitions;

-- L4 (2)  scrieri o procedura stocata care are ca si parametru numele 
-- concursului si afiseaza disciplinele disponbile la acel concurs
GO

CREATE PROCEDURE list_disciplines_for_competition
    @competition_name NVARCHAR(50)
AS
BEGIN
    SELECT dbo.[Discipline].[Denumire]
    FROM Discipline
    INNER JOIN dbo.[competitii-discipline] ON dbo.[Discipline].[id] = dbo.[competitii-discipline].[id_disciplina]
    INNER JOIN competitii ON competitii.id = [competitii-discipline].id_concurs
    WHERE competitii.denumire = @competition_name;
END;

EXEC dbo.list_disciplines_for_competition @competition_name = 'competition_2';

-- L4 (3) scrieti o procedura stocata care returneaza numarul de concurenti inscrisi la un concurs
GO

CREATE PROCEDURE count_competitors_for_competition
	@competition_name NVARCHAR(50)
AS
BEGIN
	SELECT count(*) FROM dbo.[participari-rezultate] pr
	INNER JOIN dbo.[competitii-discipline] cd on cd.[id_concurs] = pr.[id]
	INNER JOIN dbo.[competitii] c on c.[id] = cd.[id_concurs] AND c.[denumire] = @competition_name
END

EXEC count_competitors_for_competition @competition_name = 'competition_1';

-- L4 (4) scrieti o procedura stocata care afiseaza sportivii care nu au incheiat concursul de la cluj.
GO

CREATE PROCEDURE list_incomplete_competitors_from_cluj
AS
BEGIN
    SELECT Nume, Prenume
    FROM dbo.[sportivi] sp
    LEFT JOIN dbo.[participari-rezultate] ON sp.[id] = [participari-rezultate].id_sportiv
    INNER JOIN competitii ON [participari-rezultate].id = competitii.id
    WHERE competitii.localiate = 'Cluj' AND [participari-rezultate].id IS NULL;
END;

-- -- -- -- -- -- -- -- -- -- -- -- L5 -- -- -- -- -- -- -- -- -- -- -- --

-- L5 (1) scrieti o functie scalara definita de utilizator care calculeaza timpul total obtinut de sportivi
-- COALESCE >> https://learn.microsoft.com/en-us/sql/t-sql/language-elements/coalesce-transact-sql?view=sql-server-ver16
GO

CREATE FUNCTION calculate_total_time()
RETURNS TIME AS
BEGIN
    DECLARE @total_time TIME
    SELECT @total_time = COALESCE(SUM(total), '00:00:00')
    FROM dbo.[participari-rezultate]
    RETURN @total_time
END