-- Przykład edukacyjny dla SQLite. Wykonaj TYLKO w nowej, pustej bazie.
-- Ustawienie kluczy obcych dotyczy bieżącego połączenia.
PRAGMA foreign_keys = ON;

CREATE TABLE czlonkowie (
    numer INTEGER PRIMARY KEY,
    imie TEXT NOT NULL,
    data_przyjecia TEXT NOT NULL,
    skladka_oplacona INTEGER NOT NULL
        CHECK (skladka_oplacona IN (0, 1))
);

INSERT INTO czlonkowie
    (numer, imie, data_przyjecia, skladka_oplacona)
VALUES
    (101, 'Anna', '2026-09-15', 1),
    (102, 'Piotr', '2026-10-02', 0);

CREATE TABLE dyscypliny (
    id INTEGER PRIMARY KEY,
    nazwa TEXT NOT NULL UNIQUE
);

INSERT INTO dyscypliny (id, nazwa)
VALUES (1, 'Showdown'), (2, 'Pływanie');

CREATE TABLE przynaleznosci (
    numer_czlonka INTEGER NOT NULL REFERENCES czlonkowie(numer),
    id_dyscypliny INTEGER NOT NULL REFERENCES dyscypliny(id),
    PRIMARY KEY (numer_czlonka, id_dyscypliny)
);

INSERT INTO przynaleznosci (numer_czlonka, id_dyscypliny)
VALUES (101, 1), (101, 2), (102, 1);

-- Oczekiwane trzy wiersze: Anna-Showdown, Anna-Pływanie, Piotr-Showdown.
SELECT c.imie, d.nazwa
FROM czlonkowie AS c
JOIN przynaleznosci AS p ON p.numer_czlonka = c.numer
JOIN dyscypliny AS d ON d.id = p.id_dyscypliny
ORDER BY c.numer, d.id;
