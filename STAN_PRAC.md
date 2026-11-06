# Stan opracowania

Data kontroli: **2026-11-06**.

## Wykonano w pierwszym etapie

- Zdefiniowano charakter kompendium, sposób czytania i zasady redakcyjne.
- Opracowano cztery początkowe rozdziały, łączące genezę historyczną, pojęcia, reprezentacje tekstowe i podstawy baz relacyjnych.
- Utworzono wspólne, fikcyjne przykłady danych, ich pliki źródłowe i schemat SQL.
- Sporządzono pierwszy słownik i bibliografię źródeł pierwotnych.
- Sprawdzono kluczowe twierdzenia historyczne i podstawowe specyfikacje wskazane w bibliografii.

**Status redakcyjny:** publiczna wersja wstępna, otwarta na korekty i rozwój. Nie należy traktować planowanych rozdziałów jako napisanych.

## Zasady aktualności i zakresu dowodowego

- Daty 1890 (system Holleritha), 1970 (publikacja Codda) i 1998 (pierwsza rekomendacja XML 1.0) oparto na wskazanych dokumentach historycznych.
- JSON: specyfikacja RFC 8259 (2017), CSV: RFC 4180 (2005) **informacyjne**, a nie „obowiązkowy standard wszystkich implementacji CSV”.
- YAML i TOML: opisano ich współczesne, sprawdzone specyfikacje. Przykład CSV ze średnikiem jest **dialektem**, nie dosłowną reprezentacją z przykładów RFC 4180.
- Przykłady z SQLite odnoszą się do specyfiki SQLite (m.in. brak osobnego typu `DATE` i zwyczaj 0/1 dla logiki); nie należy ich bezpośrednio przenosić do wszystkich baz SQL.

## Pozostałe do opracowania lub weryfikacji

1. Pełna chronologia rozwoju formatów i systemów: należy oprzeć każdą ważną datę na dokumencie źródłowym.
2. Dokładniejsze omówienie Unicode, kodowania i różnic między typami dat.
3. Niezależne sprawdzenie przykładów w parserach YAML i TOML oraz opis zachowania rozmaitych bibliotek.
4. Przegląd aktualnych wydań formatów analitycznych i baz wektorowych; nie wystarczy powołać się na marketing dostawców.
5. TOON jest opisany w stanie projektu jako **Working Draft**; nie traktować go jako utrwalonego następcy JSON.
6. Przetestowanie przyszłych materiałów z czytnikami ekranu i konsultacje redakcyjne.

## Co dalej?

Dokończyć część o kodowaniu tekstu i typach danych; później rozwinąć każdy podstawowy format w samodzielnym rozdziale z walidacją i importem. Następnie pogłębić model relacyjny, indeksy i transakcje.

Nie publikować niezweryfikowanych danych zależnych od wersji technologii.
