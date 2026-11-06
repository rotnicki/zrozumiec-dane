# 4. Czym plik różni się od bazy danych i po co są relacje?

> **Pytanie przewodnie:** skoro możemy już zapisać członków klubu w CSV lub JSON, po co budować bazę danych?

## Plik i baza danych: nie są przeciwieństwami

Plik jest nazwanym zasobem przechowującym zawartość w określonej postaci. Może być tekstem, zdjęciem, dokumentem, archiwum lub plikiem o strukturze binarnej.

Baza danych jest **uporządkowanym zbiorem danych**, którym zwykle zarządza program zapewniający dodatkowe operacje: wyszukiwanie, aktualizacje, kontrolę ograniczeń, transakcje i mechanizmy dostępu.

Dlatego nie należy mówić: „plik jest prosty, a baza danych zawsze jest czymś poza plikami”.

**SQLite** potrafi przechowywać całą bazę w jednym pliku. **PostgreSQL** jest natomiast systemem serwerowym: aplikacje łączą się z serwerem bazy, który sam zarządza jej plikami i procesami.

To różne **sposoby organizowania pracy z danymi**, a nie tylko dwa rozszerzenia plików.

## Dlaczego arkusz lub CSV może przestać wystarczać?

Wyobraź sobie, że w klubie jest sto osób. Ktoś zapisuje nowe składki, ktoś inny aktualizuje sekcje sportowe. Dwie osoby jednocześnie otwierają ten sam CSV, zmieniają go i zapisują.

Zwykły plik nie określa sam z siebie zasad rozstrzygania takich zmian. Jeśli system przechowywania nie zapewnia właściwej współpracy, ostatni zapis może zastąpić pracę wcześniejszej osoby.

Współczesne programy pracujące z plikami mogą oczywiście implementować blokady i mechanizmy synchronizacji. Nie oznacza to, że każdy CSV ma je automatycznie. Silnik bazy danych daje **przeznaczone do tego mechanizmy**.

Nie zawsze są one potrzebne: dla krótkiej listy wysyłanej raz na miesiąc CSV może być całkowicie wystarczający.

## Dlaczego relacyjny model danych oddziela tabele?

Anna uprawia showdown i pływanie. Piotr uprawia showdown. Możemy naiwnie zapisać:

| Numer | Imię | Dyscyplina |
|---|---|---|
| 101 | Anna | Showdown |
| 101 | Anna | Pływanie |
| 102 | Piotr | Showdown |

Na pierwszy rzut oka działa. A jeśli Anna zmieni imię lub dopiszemy do jej rekordu adres? Być może trzeba będzie poprawiać te same informacje w wielu wierszach.

To **nadmiarowość**: wielokrotnie zapisujemy tę samą informację. Pojawia się ryzyko, że jedna kopia zostanie zmieniona, a druga nie.

Możemy rozdzielić dane logicznie na trzy tabele.

### Tabela członków

```text
numer | imie
101   | Anna
102   | Piotr
```

### Tabela dyscyplin

```text
id | nazwa
1  | Showdown
2  | Pływanie
```

### Tabela powiązań

```text
numer_czlonka | id_dyscypliny
101           | 1
101           | 2
102           | 1
```

Ostatnia tabela zawiera tylko pary identyfikatorów. Jeżeli czytamy `101 | 2`, znaczenie jest następujące: „członek numer 101 uprawia dyscyplinę numer 2”.

Tak opisujemy zależność **wiele do wielu**: jedna osoba może mieć wiele dyscyplin, a jedna dyscyplina wielu członków.

Ten przykład pokazuje intuicję normalizacji. Formalna normalizacja ma bardziej precyzyjne zasady, które rozwiniemy osobno. Nie jest prawdą, że należy zawsze rozbijać dane na maksymalną liczbę tabel: decyzja zależy od zależności między danymi i sposobu ich wykorzystania.

## Co oznaczają klucze?

**Klucz podstawowy** identyfikuje konkretny rekord w tabeli. W naszej tabeli członków jest nim `numer`. W tabeli dyscyplin — `id`.

**Klucz obcy** wskazuje powiązanie z rekordem istniejącym w innej tabeli. W tabeli powiązań `numer_czlonka` odnosi się do numeru członka, a `id_dyscypliny` do dyscypliny.

Jeśli system **wymusza klucze obce**, nie możemy bezkarnie dodać powiązania z nieistniejącą dyscypliną. W SQLite należy pamiętać, że egzekwowanie ograniczeń kluczy obcych ma swoje ustawienia: w naszym skrypcie jawnie występuje `PRAGMA foreign_keys = ON;`.

**Klucz** to niekoniecznie wartość przeznaczona do obliczeń. Numer członkowski 101 jest identyfikatorem, nie kwotą ani liczbą osób. W innym projekcie identyfikator może być tekstem, np. `"00101"`, gdy początkowe zera mają znaczenie.

## SQL: opisujemy, jakie dane chcemy uzyskać

W [przykładowym pliku `klub.sql`](../przyklady/klub.sql) zapisano tworzenie tabel i danych fikcyjnego klubu.

Po uruchomieniu skryptu w **pustej** bazie SQLite możemy wykonać:

```sql
SELECT c.imie, d.nazwa
FROM czlonkowie AS c
JOIN przynaleznosci AS p ON p.numer_czlonka = c.numer
JOIN dyscypliny AS d ON d.id = p.id_dyscypliny
ORDER BY c.numer, d.id;
```

Wyjaśnienie krok po kroku:

1. `SELECT` określa pola, które chcemy zobaczyć: imię członka i nazwę dyscypliny.
2. `FROM czlonkowie AS c` oznacza, że zaczynamy od tabeli członków i skrótowo nazywamy ją `c`.
3. Pierwsze `JOIN` łączy członków z tabelą powiązań na podstawie identycznych numerów.
4. Drugie `JOIN` łączy numer dyscypliny z właściwą nazwą.
5. `ORDER BY` porządkuje wynik według numeru członka, a potem identyfikatora dyscypliny.

Otrzymamy trzy wiersze, w tej kolejności:

- Anna — Showdown;
- Anna — Pływanie;
- Piotr — Showdown.

Zauważ: **imię jest przechowywane tylko raz w tabeli członków**. Zapytanie może jednak wyświetlić je tyle razy, ile jest powiązań. To nie sprzeczność — wynik zapytania i fizycznie przechowywane dane to różne rzeczy.

Dokładniejszy opis składni znajduje się w [samouczku SQL PostgreSQL](https://www.postgresql.org/docs/current/tutorial-sql.html). Konkretny skrypt repozytorium napisano jednak dla SQLite i uwzględnia on jego własne reguły typów.

## Co daje baza oprócz zapytań?

### Kontrolę poprawności

Definicja tabeli może wymagać, aby:

- numer był unikatowy;
- imię nie było wartością `NULL`;
- status składki miał tylko wartość 0 albo 1;
- powiązanie nie wskazywało nieistniejącego członka.

W naszym przykładzie są to między innymi ograniczenia `PRIMARY KEY`, `NOT NULL` i `CHECK`. [Oficjalna dokumentacja SQLite: CREATE TABLE](https://www.sqlite.org/lang_createtable.html).

Nawet baza nie odgadnie jednak, czy członek zapłacił za właściwy miesiąc. **Poprawność schematu** nie zastępuje reguł biznesowych.

### Transakcje

Wyobraź sobie zapis dwóch czynności:

1. Wpisz do rejestru, że wpłata została otrzymana.
2. Zmień informację o rozliczeniu składki.

Jeżeli druga czynność się nie powiedzie, nie chcemy pozostawić systemu w stanie częściowo zaktualizowanym.

Systemy transakcyjne pozwalają wykonywać grupy operacji z określonymi gwarancjami. Najczęściej omawia się właściwości **ACID**: atomowość, spójność, izolację i trwałość. Odróżnij atomowość („całość albo nic”) od izolacji (zasady współbieżności) i trwałości (zapis ma przetrwać awarie w określonych granicach).

Szczegóły gwarancji zależą od silnika, poziomu izolacji i konfiguracji; nie zakładaj, że każdy system działa identycznie.

### Indeksy

Indeks jest pomocniczą strukturą, która pomaga przy wybranych wyszukiwaniach. Wyobraź sobie katalog alfabetyczny w bibliotece: nie zawiera całej treści każdej książki, ale pozwala szybko wskazać właściwą.

Podobnie indeks bazy może przyspieszać wyszukiwanie członka po numerze lub sortowanie. Indeksy nie są darmowe: zajmują miejsce i trzeba je aktualizować podczas zmian danych.

## Co fizycznie mieści się w pliku SQLite?

Plik bazy SQLite nie jest plikiem tekstowym z wypisanymi komendami SQL. Ma zdefiniowany **format binarny** i jest podzielony na **strony**; przechowywanie tabel i indeksów wykorzystuje m.in. struktury **B-tree**.

Można to porównać do biblioteki z wielopoziomowymi spisami: znalezienie konkretnego numeru nie wymaga przeglądania każdego dokumentu od początku.

To tylko analogia. Faktyczny sposób budowy stron, komórek, indeksów i rekordów opisuje [oficjalna specyfikacja pliku SQLite](https://www.sqlite.org/fileformat.html).

Ważne: kiedy czytasz tabelę za pomocą SQL, nie musisz samodzielnie rozumieć rozmieszczenia każdego bajtu na dysku. To istota rozdziału między **logiką** a **fizyczną organizacją**.

## SQLite i PostgreSQL: dlaczego oba są potrzebne?

SQLite to wygodne rozwiązanie dla lokalnej aplikacji, niewielkiego narzędzia, pliku przechowywanego na urządzeniu czy samodzielnego rejestru. Nie wymaga zwykle instalacji odrębnego serwera bazy danych.

PostgreSQL jest systemem serwerowym. Wiele aplikacji i użytkowników może łączyć się z nim poprzez odpowiednio skonfigurowaną usługę, otrzymując mechanizmy współbieżności i zarządzania danymi.

Nie należy przyjmować prostego podziału „SQLite jest tylko dla małych danych, PostgreSQL dla dużych”. Istotniejsze są charakter pracy, model współdzielenia, obciążenie, wymagania eksploatacyjne i bezpieczeństwo.

### Co z Dropboxem i Dyskiem Google?

Umieszczenie pliku SQLite w folderze synchronizowanym przez chmurę nie tworzy automatycznie wspólnej bazy serwerowej.

Jeśli dwie osoby edytują kopie pliku i program synchronizujący próbuje później je scalić, sam mechanizm synchronizacji **nie zna** wszystkich transakcji bazy. Grożą konflikty wersji i utrata części pracy.

Może to być wygodny sposób przenoszenia **zamkniętej, nieużywanej** kopii pliku między urządzeniami, lecz nie zastępuje kontrolowanego dostępu wielu osób do jednej działającej bazy. Dla współdzielonych modyfikacji zwykle należy wybrać aplikację lub usługę zapewniającą prawidłowe transakcje.

## Czy inne bazy są gorsze?

Nie. Bazę relacyjną warto poznać jako punkt odniesienia, ale istnieją też:

- bazy **dokumentowe**, które przechowują złożone dokumenty;
- bazy **klucz–wartość** do pobierania wartości według klucza;
- bazy **grafowe**, w których ważne są sieci powiązań;
- bazy **szeregów czasowych**, zoptymalizowane pod pomiary i znaczniki czasu;
- systemy obsługujące **wektory** i wyszukiwanie podobnych treści.

Niektóre systemy łączą kilka takich podejść. Nie należy mylić rodzaju **modelu danych** z pojedynczą marką lub z formatem eksportu.

W dalszych rozdziałach zbadamy także Parquet, Arrow, Iceberg oraz inne narzędzia do pracy z bardzo dużymi zbiorami. To jednak **następny etap** kompendium, a nie zagadnienie rozstrzygnięte w tym rozdziale.

## Pytania kontrolne

1. Czy każda baza danych musi być wieloma plikami na osobnym serwerze?
2. Po co przechowywać osobno członków, dyscypliny i powiązania?
3. Czy powtórzone imię w wyniku `JOIN` oznacza, że imię jest zapisane w bazie dwukrotnie?
4. Czy synchronizacja pliku SQLite z chmurą zapewnia wieloosobowe transakcje?

**Odpowiedzi:** (1) nie, SQLite to znany kontrprzykład; (2) ograniczenie powielania danych i wyrażenie zależności; (3) nie, wynik może powtarzać wyświetlaną wartość; (4) nie.

**Dalej:** [Spis dalszych rozdziałów](../SPIS_TRESCI.md) lub [Słownik pojęć](../SLOWNIK.md).
