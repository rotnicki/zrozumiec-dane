# Zrozumieć dane

**Kompendium o reprezentacji, strukturze, zapisie i przetwarzaniu danych.**

Dlaczego ta sama informacja może występować w kartotece, CSV, JSON, XML, pliku SQLite lub serwerowej bazie danych? Skąd wzięły się te rozwiązania, jak działają i dlaczego nie istnieje jeden najlepszy sposób przechowywania wszystkiego? Ten projekt próbuje odpowiedzieć na te pytania **od podstaw, przystępnie i bez rezygnowania z dokładności**.

## Od czego zacząć

1. [Skąd wzięła się potrzeba porządkowania danych?](rozdzialy/01-historia-i-problem.md) — od kartotek do maszyn Holleritha i modelu relacyjnego.
2. [Dane, informacja, model, struktura i zapis](rozdzialy/02-od-informacji-do-reprezentacji.md) — pojęcia potrzebne do rozumienia dalszych rozdziałów.
3. [Ta sama informacja w różnych formatach](rozdzialy/03-jeden-rekord-wielu-zapisach.md) — porównanie CSV, JSON, YAML, XML, TOML i SQL na wspólnym przykładzie.
4. [Plik, baza danych i relacje](rozdzialy/04-pliki-bazy-relacje.md) — czym różnią się pliki od systemów baz danych, co dają klucze, transakcje i zapytania.

W rozdziałach pojęcia techniczne są wyjaśniane przy pierwszym użyciu. Nie trzeba wcześniej programować ani znać SQL.

## Materiały pomocnicze

- [Spis i plan dalszych rozdziałów](SPIS_TRESCI.md)
- [Słownik pojęć](SLOWNIK.md)
- [Przykładowe dane i pliki do porównania](przyklady/README.md)
- [Źródła i bibliografia](ZRODLA.md)
- [Stan opracowania i ograniczenia](STAN_PRAC.md)

## Jak czytać i sprawdzać przykłady

Przez pierwsze rozdziały prowadzi wymyślony przykład klubu sportowego: członkowie, numery, daty przyjęcia, składki i dyscypliny. To **dane fikcyjne**, nie ewidencja rzeczywistych osób. W przykładach nie używa się poufnych danych. Fragmenty kodu są opisywane również słownie, tak aby dało się z nich korzystać z czytnikiem ekranu.

**Uwaga o nazwach:** CSV, JSON, XML, YAML i TOML to formaty/składnie danych; SQL to język; SQLite i PostgreSQL to systemy zarządzania bazami; Parquet i Arrow mają inne, wyspecjalizowane cele. Nie należy porównywać ich tak, jakby wszystkie były wymiennymi typami plików.

## Charakter i aktualność

To **rozwijające się kompendium**, a nie ukończona książka. Publiczne rozdziały zawierają materiał nadający się do czytania już teraz; nie oznacza to, że wszystkie zagadnienia zostały wyczerpane. Przy twierdzeniach zależnych od wersji dokumentujemy stan weryfikacji. Źródła pierwotne i ograniczenia opisano w [bibliografii](ZRODLA.md) i [stanie prac](STAN_PRAC.md).

Podstawowy format to Markdown. Treści są tworzone tak, aby można było je czytać liniowo, w tym za pomocą czytników ekranu. Istotne schematy otrzymują opis słowny.

## Autorstwo i współpraca

Projekt edukacyjno-badawczy Mikołaja Rotnickiego, rozwijany z wykorzystaniem pomocy AI, weryfikacji dokumentacji źródłowej i kontroli redakcyjnej. Narzędzia AI nie są samodzielnym źródłem dowodów.

Prywatna dokumentacja procesu powstawania jest przechowywana osobno i nie stanowi części publicznej publikacji. Zasady dalszej pracy opisuje [AGENTS.md](AGENTS.md).
