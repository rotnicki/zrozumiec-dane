# Jeden fikcyjny zbiór danych w kilku formatach

Wszystkie pliki reprezentują te same **dwa fikcyjne rekordy**: Anna (numer 101, data przyjęcia 2026-09-15, składka opłacona) i Piotr (numer 102, data przyjęcia 2026-10-02, składka nieopłacona).

## Pliki

- [`czlonkowie.csv`](czlonkowie.csv) — tekstowa tabela **ze średnikami**, dialekt CSV; `TAK`/`NIE` wymagają interpretacji.
- [`czlonkowie.json`](czlonkowie.json) — tablica dwóch obiektów JSON.
- [`czlonkowie.jsonl`](czlonkowie.jsonl) — JSON Lines, po jednym dokumencie w każdym wierszu.
- [`czlonkowie.yaml`](czlonkowie.yaml) — mapa zawierająca listę członków.
- [`czlonkowie.xml`](czlonkowie.xml) — element `czlonkowie` z dwoma elementami `czlonek`.
- [`czlonkowie.toml`](czlonkowie.toml) — tablica tabel, daty jako rodzime wartości TOML.
- [`czlonkowie.schema.json`](czlonkowie.schema.json) — przykład **JSON Schema** dla pliku `czlonkowie.json`.
- [`klub.sql`](klub.sql) — definicje tabel i zapytania dla **SQLite**, także dwie dyscypliny i powiązania.

## Ograniczenia i mapowanie

- CSV: średnik nie jest przecinkiem z przykładu RFC 4180. W programie importującym wybierz separator `;` i kodowanie UTF-8.
- JSON: daty są tekstem, a składki wartościami logicznymi.
- YAML: daty ujęto w cudzysłowy, aby nie zależeć od automatycznego rozpoznawania typu przez biblioteki.
- XML: zawartość znaczników nie ma automatycznie tych samych typów co JSON.
- TOML: `data_przyjecia = 2026-09-15` jest lokalną datą w TOML.
- SQLite: daty są tekstem, a `1`/`0` reprezentują prawdę/fałsz. Plik `klub.sql` jest **tekstem z poleceniami**, nie binarną bazą `.db`.
- JSON Schema: słowo kluczowe `format: date` może wymagać osobnego włączenia sprawdzania w konkretnym walidatorze. Sam schemat nie wymusza unikatowości numeru `numer` między wszystkimi rekordami.

## Jak bezpiecznie sprawdzić przykład SQL

Użyj nowej, pustej bazy SQLite, np. `cwiczenie-klub.db`, a nie bazy z prawdziwymi danymi. W narzędziu `sqlite3` można wykonać polecenia z pliku `klub.sql`. Skrypt tworzy tabele i dane przykładowe; **ponowne wykonanie go w tej samej bazie** spowoduje błędy „tabela już istnieje”. To zamierzone: przykład startuje od pustej bazy.

Wynik ostatniego zapytania ze skryptu (imię, nazwa dyscypliny) powinien zawierać trzy wiersze: Anna – Showdown; Anna – Pływanie; Piotr – Showdown.

Więcej objaśnień: [rozdział 3](../rozdzialy/03-jeden-rekord-wielu-zapisach.md) i [rozdział 4](../rozdzialy/04-pliki-bazy-relacje.md).
