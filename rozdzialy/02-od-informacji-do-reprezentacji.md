# 2. Dane, informacja, model i sposób zapisu

> **Pytanie przewodnie:** jak przejść od rzeczywistego zdarzenia do zapisu, którego komputer nie zinterpretuje opacznie?

## Jeden fakt, kilka poziomów

Wyobraź sobie, że Anna została przyjęta do klubu sportowego 15 września 2026 r. i opłaciła składkę. To nasze **zdarzenia w rzeczywistości**.

Ktoś zapisuje: „Anna, numer 101, przyjęta 15 września, składka opłacona”. Jest to **informacja w ludzkim języku**.

Projektant systemu ustala, że każdy członek ma numer, imię, datę przyjęcia i znacznik opłacenia składki. To **model**: wybieramy cechy rzeczywistości, które chcemy przechowywać.

Następnie określamy, jakie pola muszą wystąpić w rekordzie i jakie mają typy. To **struktura i schemat**.

Na koniec wybieramy CSV, JSON albo tabelę w SQLite. To **reprezentacja i konkretny zapis**. Po odczytaniu danych program musi przywrócić im uzgodnione znaczenie.

Można zapamiętać tę drogę tak:

1. Rzeczywistość: członek dołączył do klubu.
2. Znaczenie: wiemy, kto, kiedy i na jakich warunkach.
3. Model: mamy pojęcia „członek”, „numer”, „data przyjęcia”, „składka”.
4. Schemat: numer jest obowiązkowy i unikalny; data ma określony sens; składka ma wartość „tak” lub „nie”.
5. Reprezentacja: zapis według reguł CSV, JSON, XML albo silnika bazy.
6. Odczyt i interpretacja: program odtwarza wartości i wie, co oznaczają.

Te poziomy są pomocnym **modelem dydaktycznym**, a nie jedyną formalną klasyfikacją w informatyce.

## Co komputer widzi naprawdę?

Na najniższym poziomie pamięć i nośniki opisuje się jako ciągi **bitów**, czyli wartości 0 i 1. Osiem bitów tworzy **bajt**.

Ale ciąg bajtów nie mówi sam z siebie: „jestem imieniem”, „jestem datą” czy „jestem numerem telefonu”. Potrzebna jest umowa, która mówi, jak je odczytać.

Dwie różne rzeczy:

- **kodowanie znaków**, np. UTF-8, wyjaśnia, jak przełożyć litery na bajty;
- **format danych**, np. JSON, określa, jak ułożyć znaki w obiekty, tablice i wartości.

Jeżeli plik zawiera polską literę „ł”, poprawne kodowanie pomaga ją odczytać. Nie mówi jednak, czy litera występuje w imieniu, opisie czy nazwie pola.

## Typ danych: czym różni się liczba od tekstu?

Rozważ następujące wartości:

```text
101
"101"
true
"2026-09-15"
```

**101 bez cudzysłowów** może być liczbą całkowitą. Da się na niej wykonywać działania matematyczne, choć nie zawsze ma to sens.

**"101" w cudzysłowach** jest napisem. To ważne, gdy zapisujemy np. numer członkowski z zerami na początku: `"00101"`. Zamiana takiego identyfikatora na liczbę 101 usunęłaby istotne zera.

**true** w JSON oznacza logiczną prawdę; **false** — fałsz.

**"2026-09-15"** w JSON pozostaje **napisem**, nawet jeśli czytelnik rozpoznaje w nim datę. Inne systemy lub formaty mogą mieć osobny typ daty. Sam wygląd wartości nie przesądza o sposobie jej przechowywania.

### Typ nie zawsze gwarantuje poprawne znaczenie

Liczba 250 może oznaczać kwotę w złotych, liczbę członków albo kilogramy. Nawet jeśli program poprawnie rozpozna typ liczbowy, nadal potrzebuje informacji o **jednostce i znaczeniu**.

Dane mogą być więc:

- poprawne jako ciąg znaków;
- poprawne składniowo w konkretnym formacie;
- poprawne typowo;
- a mimo to **nieprawdziwe lub błędnie opisane**.

Przykład: `"data_przyjecia": "2026-02-30"` jest poprawnym fragmentem JSON, ale data 30 lutego 2026 r. nie istnieje.

## Schemat a rekord

**Rekord** jest konkretnym zestawem wartości:

```text
numer = 101
imie = Anna
data_przyjecia = 2026-09-15
skladka_oplacona = tak
```

**Schemat** mówi, jakie rekordy są dozwolone:

- numer: wymagany, unikalny identyfikator;
- imię: wymagany tekst;
- data przyjęcia: data zgodna z uzgodnionymi regułami;
- składka opłacona: wartość logiczna.

Schemat nie jest tym samym co przykładowy rekord. Jeden schemat może opisywać tysiące rekordów.

W różnych rozwiązaniach schemat można podać na różne sposoby: w definicji tabel SQL, w JSON Schema albo w dokumentacji formatu. Sam JSON nie nakazuje, aby pole `imie` istniało i było tekstem. [RFC 8259](https://www.rfc-editor.org/rfc/rfc8259.html) opisuje składnię JSON; [JSON Schema](https://json-schema.org/specification) to osobny mechanizm określania reguł.

## Brak wartości, zero, pusty tekst i brak pola

To szczególnie ważna różnica przy imporcie danych:

- `0` może oznaczać rzeczywistą wartość zero;
- `""` jest pustym tekstem;
- `null` w JSON jest specjalną wartością informującą o braku wartości;
- brak klucza `data_przyjecia` oznacza, że tego pola **w ogóle nie zapisano**.

Nie wolno zakładać, że wszystkie te sytuacje są równoważne.

Na przykład brak daty przyjęcia może oznaczać: „jeszcze jej nie ustalono”, „nie dotyczy” albo „dane są niekompletne”. Która interpretacja jest właściwa? To musi określać **model i reguły projektu**, a nie przypadkowa konwencja.

Dodatkowa pułapka: SQL także używa wartości `NULL`, ale jej zachowanie podczas porównywania jest inne niż zwykłej wartości `null` w JSON. Tę różnicę rozwiniemy później.

## Logicznie to samo, fizycznie inaczej

Możemy mieć dwa pliki zawierające to samo znaczenie:

```text
101;Anna;2026-09-15;TAK
```

oraz:

```json
{"numer":101,"imie":"Anna","data_przyjecia":"2026-09-15","skladka_oplacona":true}
```

Na poziomie znaczenia chcemy wyrazić tę samą informację. Jednak **reguły kodowania są inne**: CSV musi polegać na zewnętrznej umowie dotyczącej kolumn i wartości „TAK”, JSON zapisuje nazwy pól bezpośrednio i posiada typ logiczny.

To wymaga odróżnienia trzech pojęć:

- **model logiczny** — jakie obiekty, cechy i związki istnieją;
- **składnia / format zapisu** — jak je przedstawiamy w pliku lub transmisji;
- **układ fizyczny** — jak ostatecznie bajty rozmieszczone są na nośniku i w pamięci.

Dla relacyjnej bazy danych użytkownik może pracować na tabeli i nie wiedzieć, jak silnik organizuje strony lub indeksy na dysku. To nie przypadek: niezależność modelu od wewnętrznej organizacji była istotnym założeniem pracy [Codda z 1970 r.](https://research.ibm.com/publications/a-relational-model-of-data-for-large-shared-data-banks).

## Co oznacza serializacja?

Wyobraź sobie, że program ma wewnętrzną strukturę `czlonek`: numer, imię i datę. Chce wysłać ją przez sieć.

**Serializacja** zamienia tę strukturę na uzgodnioną postać, np. tekst JSON lub ciąg bajtów Protobuf.

**Deserializacja** jest operacją odwrotną: odbiorca odczytuje zapis i odtwarza właściwe wartości.

Uwaga: „odtworzenie” nie zawsze oznacza utworzenie identycznego obiektu w pamięci. Różne języki programowania i systemy mają różne typy i reguły konwersji. Zawsze należy sprawdzić, czy nie utraciliśmy np. precyzji liczby, strefy czasowej albo zer w identyfikatorze.

## A gdzie w tym wszystkim jest semantyka?

Semantyka to **znaczenie** danych.

Pole `skladka_oplacona` wygląda na proste, ale warto zapytać:

- Czy chodzi o składkę za obecny miesiąc, kwartał czy rok?
- Czy częściowa wpłata liczy się jako „opłacona”?
- Czy członek zwolniony ze składki powinien mieć wartość `true`, `false` czy osobny status?

Żaden JSON ani SQL nie odpowie na to pytanie za projektanta. Format i typ mogą być poprawne, a system nadal może źle przedstawiać rzeczywistość.

Dlatego **dobry model danych zaczyna się od znaczenia**, a dopiero później wybieramy format i technologię.

## Pytania kontrolne

1. Czy UTF-8 i JSON rozwiązują ten sam problem?
2. Czy w JSON napis `"2026-09-15"` jest automatycznie typem daty?
3. Czy poprawny JSON gwarantuje poprawną datę?
4. Czy dwa różne formaty mogą przedstawiać tę samą informację?

**Odpowiedzi:** (1) nie, kodowanie znaków i struktura danych to różne warstwy; (2) nie; (3) nie; (4) tak, jeśli zachowamy znaczenie i świadomie określimy konwersje.

**Dalej:** [3. Jeden rekord w różnych zapisach](03-jeden-rekord-wielu-zapisach.md).
