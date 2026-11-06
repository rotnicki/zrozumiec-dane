# 3. Jeden zbiór danych zapisany na wiele sposobów

> **Pytanie przewodnie:** jak zachować sens informacji, gdy zmieniamy sposób jej przedstawienia?

Wszystkie przykłady w tym rozdziale opisują **te same dwie fikcyjne osoby**. Możesz porównać ich pliki w katalogu [`przyklady/`](../przyklady/README.md).

| Numer | Imię | Data przyjęcia | Składka opłacona |
|---|---|---|---|
| 101 | Anna | 2026-09-15 | Tak |
| 102 | Piotr | 2026-10-02 | Nie |

Tak wygląda widok dla człowieka. Teraz zapiszmy to dla komputerów.

## 1. CSV: każdy wiersz i kolumna mają umówione miejsce

```csv
numer;imie;data_przyjecia;skladka_oplacona
101;Anna;2026-09-15;TAK
102;Piotr;2026-10-02;NIE
```

Pierwszy wiersz zawiera **nagłówki**. W drugim i trzecim są dane. **Średnik** oddziela kolejne pola w danym wierszu. Zatem wiersz z Anną składa się z czterech części: 101, Anna, data i TAK.

Ważna precyzja: nazwa CSV pochodzi od *comma-separated values*, czyli „wartości oddzielonych przecinkami”. Nasz plik wykorzystuje rozpowszechniony **dialekt ze średnikiem**. Jeśli program oczekuje przecinka, trzeba ustawić separator albo przekonwertować plik. [RFC 4180](https://www.rfc-editor.org/rfc/rfc4180.html) opisuje popularny wariant z przecinkiem i reguły cytowania, ale ma status **Informational** — nie jest uniwersalnym nakazem dla wszystkich implementacji.

**Najważniejsze ograniczenie:** sam CSV nie ustala, czy `101` jest liczbą, a `TAK` wartością logiczną. Tę umowę musi posiadać program lub dokumentacja. Trzeba również ustalić kodowanie znaków i sposób zapisywania separatorów wewnątrz wartości.

## 2. JSON: nazwy i wartości są zapisane razem

```json
[
  {
    "numer": 101,
    "imie": "Anna",
    "data_przyjecia": "2026-09-15",
    "skladka_oplacona": true
  },
  {
    "numer": 102,
    "imie": "Piotr",
    "data_przyjecia": "2026-10-02",
    "skladka_oplacona": false
  }
]
```

Jak to odczytać słownie?

- Zewnętrzny **nawias kwadratowy** otwiera tablicę dwóch elementów.
- Każdy element to **obiekt** w nawiasach klamrowych.
- W obiekcie zapisujemy **nazwę pola, dwukropek i wartość**.
- `numer` to liczba całkowita; `imie` i `data_przyjecia` są tekstami.
- `true` i `false` to wbudowane **wartości logiczne**.

W przeciwieństwie do CSV, JSON wyraźnie odróżnia tekst od liczby i wartości logicznej. Nie ma jednak własnego typu daty — `"2026-09-15"` jest nadal tekstem. JSON nie wymaga też, żeby wszystkie obiekty w tablicy miały jednakowy zestaw pól.

**Źródło:** [IETF RFC 8259](https://www.rfc-editor.org/rfc/rfc8259.html).

### A jeśli dojdzie lista dyscyplin?

Dla jednej osoby możemy dopisać:

```json
"dyscypliny": ["showdown", "plywanie"]
```

To lista dwóch tekstów. Nie musi być osobną tabelą, aby dało się ją zapisać w JSON. W modelu relacyjnym moglibyśmy jednak zdecydować się na osobną tabelę powiązań. **Sama możliwość zapisu nie przesądza o najlepszej strukturze dla dalszych operacji.**

## 3. JSON Lines: każdy wiersz jest osobnym dokumentem JSON

```jsonl
{"numer":101,"imie":"Anna","data_przyjecia":"2026-09-15","skladka_oplacona":true}
{"numer":102,"imie":"Piotr","data_przyjecia":"2026-10-02","skladka_oplacona":false}
```

Tu nie ma jednej zewnętrznej tablicy. Każdy z dwóch wierszy stanowi samodzielny dokument JSON. Jest to wygodne dla narzędzi czytających dane **po jednym rekordzie**, np. przy logach lub dużych przepływach danych.

Uwaga: zwykły parser oczekujący **jednego dokumentu JSON** nie odczyta automatycznie całego pliku JSON Lines jako poprawnego pojedynczego JSON. Potrzebny jest czytnik obsługujący tę konwencję albo odczyt wiersz po wierszu.

## 4. YAML: wcięcia określają budowę

```yaml
czlonkowie:
  - numer: 101
    imie: Anna
    data_przyjecia: "2026-09-15"
    skladka_oplacona: true
  - numer: 102
    imie: Piotr
    data_przyjecia: "2026-10-02"
    skladka_oplacona: false
```

Pierwszy wiersz otwiera listę członków. Wiersz zaczynający się od myślnika jest początkiem kolejnego elementu listy. Wcięte pod nim linie podają jego właściwości.

W YAML **wcięcia są częścią składni**, a nie tylko ozdobą. Niektóre wartości mogą być interpretowane odmiennie w zależności od wersji standardu i biblioteki, dlatego daty celowo zapisujemy w cudzysłowach. Chcemy otrzymać tekst, a nie polegać na niejednakowych regułach rozpoznawania dat.

**Źródło:** [specyfikacja YAML 1.2.2](https://yaml.org/spec/1.2.2/).

## 5. XML: nazwy pól występują w znacznikach

```xml
<?xml version="1.0" encoding="UTF-8"?>
<czlonkowie>
  <czlonek>
    <numer>101</numer>
    <imie>Anna</imie>
    <data_przyjecia>2026-09-15</data_przyjecia>
    <skladka_oplacona>true</skladka_oplacona>
  </czlonek>
  <czlonek>
    <numer>102</numer>
    <imie>Piotr</imie>
    <data_przyjecia>2026-10-02</data_przyjecia>
    <skladka_oplacona>false</skladka_oplacona>
  </czlonek>
</czlonkowie>
```

Wyobraź sobie podpisane pudełka: zewnętrzne `<czlonkowie>` zawiera dwa `<czlonek>`; w każdym jest czworo mniejszych pudełek z wartościami. Początek `<numer>` i koniec `</numer>` wyznaczają fragment dotyczący numeru.

W samym XML tekst `101` nie staje się automatycznie liczbą tylko dlatego, że włożono go do znacznika `numer`. Typ i reguły poprawności mogą być określone osobnym **schematem XML**.

XML bywa bardziej rozwlekły od JSON, ale jest użyteczny również w złożonych dokumentach, gdzie oprócz danych trzeba opisywać ich strukturę, kolejność i przestrzenie nazw.

**Źródło:** [W3C XML 1.0](https://www.w3.org/TR/xml/).

## 6. TOML: nazwane ustawienia i tabele

```toml
[[czlonkowie]]
numer = 101
imie = "Anna"
data_przyjecia = 2026-09-15
skladka_oplacona = true

[[czlonkowie]]
numer = 102
imie = "Piotr"
data_przyjecia = 2026-10-02
skladka_oplacona = false
```

Zapis `[[czlonkowie]]` oznacza w TOML kolejny element **tablicy tabel**. Każda kolejna linia `nazwa = wartość` ustala właściwość tego elementu.

Tutaj data ma szczególne znaczenie: **TOML posiada własny typ daty lokalnej**, więc `2026-09-15` bez cudzysłowów jest rozpoznawane jako data, a nie tekst. To różnica względem JSON.

TOML powstał z myślą przede wszystkim o przejrzystych plikach konfiguracji, a nie jako uniwersalny zamiennik wszystkich systemów bazodanowych.

**Źródło:** [TOML 1.1.0](https://toml.io/en/v1.1.0).

## 7. SQL: tutaj zmieniamy kategorię rozwiązania

```sql
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
```

To przykład **poleceń SQL dla SQLite**, a nie kolejnego formatu pliku podobnego do CSV.

Pierwszy fragment tworzy tabelę i narzuca reguły: `numer` jest kluczem podstawowym, `imie` nie może być `NULL`, a składka ma przyjmować 0 lub 1. Drugi zapisuje dwa wiersze.

SQLite nie ma osobnego, natywnego typu daty; w tym przykładzie data jest tekstem w uzgodnionym formacie, a logika jest reprezentowana liczbami `1` i `0`. [Dokumentacja typów SQLite](https://www.sqlite.org/datatype3.html) i [funkcji daty](https://www.sqlite.org/lang_datefunc.html).

Możemy teraz zapytać:

```sql
SELECT numer, imie
FROM czlonkowie
WHERE skladka_oplacona = 1;
```

Wynik to **101, Anna**. Baza wykonała filtrowanie za nas.

Plik z poleceniami `.sql` jest tekstem. Natomiast **plik właściwej bazy SQLite** ma wewnętrzną strukturę binarną. Nie należy mylić jednego z drugim.

## Czy dane są na pewno identyczne?

Na poziomie **zamierzonego znaczenia** tak: Anna opłaciła składkę, Piotr nie.

Na poziomie **typów i zapisu** — nie:

- w CSV `TAK` i `NIE` wymagają uzgodnionej interpretacji;
- w JSON i YAML pojawiają się wartości logiczne;
- w XML treść elementów wymaga osobnych reguł typowania;
- w TOML data może mieć natywny typ daty;
- w SQLite przyjęliśmy `1` i `0` oraz tekstowe daty.

Nie jest więc prawdą, że każda konwersja zachowuje wszystko „sama z siebie”. Potrzebny jest **świadomy sposób mapowania wartości**.

## Pytania kontrolne

1. Czy CSV ze średnikiem odpowiada dokładnie przykładom w RFC 4180?
2. Czy `"2026-09-15"` w JSON jest datą?
3. Czy `true` w JSON i `1` w SQLite mają identyczną postać?
4. Czy plik `.sql` jest plikiem samej bazy?

**Odpowiedzi:** (1) nie, to dialekt; (2) nie, to tekst; (3) nie, ale w naszym modelu mogą oznaczać to samo; (4) nie, zawiera polecenia SQL.

**Dalej:** [4. Pliki, bazy danych i relacje](04-pliki-bazy-relacje.md).
