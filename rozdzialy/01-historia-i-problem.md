# 1. Dlaczego w ogóle porządkujemy dane? Historia problemu

> **Pytanie przewodnie:** jak z pojedynczych zapisów stworzyć zbiór, z którego można szybko i wiarygodnie korzystać?

## Zaczęło się znacznie wcześniej niż od komputerów

Wyobraź sobie klub sportowy. Z początku ma kilkoro członków, więc organizator zna ich imiona. Później jest ich kilkudziesięciu, następnie kilkuset. Kto należy do sekcji pływania? Kto opłacił składkę? Kiedy konkretna osoba została przyjęta?

Dopóki pytamy o jedną osobę, wystarczy pamięć lub notatka. Gdy pytamy o cały zbiór osób, potrzebujemy **powtarzalnego sposobu zapisu**. Każda karta powinna zawierać te same rubryki: numer, imię, datę przyjęcia, sekcję i opłatę. Wtedy można porównywać i liczyć.

To nie jest wynalazek ery cyfrowej. Księgi rachunkowe, urzędowe rejestry, spisy ludności i katalogi biblioteczne od dawna rozwiązywały podobny problem. Stanowią **historyczne analogie do rekordów i pól**, ale nie należy utożsamiać papierowej kartoteki ze współczesną bazą danych.

### Karta jako rekord, rubryka jako pole

Weźmy fikcyjną kartę:

- numer członkowski: **101**;
- imię: **Anna**;
- data przyjęcia: **15 września 2026 r.**;
- składka opłacona: **tak**.

Jeśli każda karta wygląda podobnie, odpowiedź na pytanie „ile osób opłaciło składkę?” staje się wykonalna. Nadal jednak trzeba przejrzeć wiele kart. A co, jeśli potrzebujemy równocześnie listy według dat i listy według nazwisk? Być może trzeba sporządzać dodatkowe indeksy albo wiele kopii kart.

Właśnie w tym miejscu spotykają się dwa zagadnienia:

1. **Reprezentacja:** jak zapisać jedną informację, żeby była jednoznaczna?
2. **Organizacja i wyszukiwanie:** jak zarządzać tysiącami takich informacji, nie tracąc nad nimi kontroli?

W miarę wzrostu zbioru drugie pytanie staje się równie ważne jak pierwsze.

## 1890: karta perforowana pozwala odczytywać informacje maszynowo

W spisie ludności Stanów Zjednoczonych z 1890 r. zastosowano elektryczny system tabulacyjny opracowany przez Hermana Holleritha.

Informacje z formularzy przepisywano na papierowe karty. Otwory w ustalonych miejscach reprezentowały cechy osoby, na przykład wiek i stan cywilny. Maszyna korzystająca z kontaktów elektrycznych rozpoznawała perforacje i pomagała zliczać odpowiedzi.

Dlaczego to było ważne?

Przy zwykłym formularzu człowiek rozpoznaje słowo „tak”. W systemie perforowanym **umówione położenie otworu** wystarczało maszynie, żeby ustalić znaczenie zapisu. To przykład reprezentacji danych, którą można automatycznie przetwarzać.

Ważna uwaga: Hollerith nie był pierwszą osobą, która próbowała mechanizować pracę z informacjami; maszyny i karty wykorzystywano w innych dziedzinach wcześniej. Istotnym, dobrze udokumentowanym faktem jest zastosowanie jego systemu do spisu z **1890 r.**, a nie „wynalezienie wszystkich komputerowych danych”.

**Źródła pierwotne:** [U.S. Census Bureau, spis z 1890 r.](https://www.census.gov/programs-surveys/decennial-census/decade/1890/about-1890.html) oraz [historia tabulacji danych spisowych](https://www.census.gov/about/history/bureau-history/census-innovations/technology/tabulation-and-processing.html).

## Komputery, taśmy i pliki o ustalonej budowie

W kolejnych dziesięcioleciach maszyny potrafiły już przechowywać i obrabiać dane bez konieczności odczytywania każdej papierowej karty. Rozwijał się zapis magnetyczny, taśmy i dyski.

Jednym z podejść był **rekord o stałej długości**. Wyobraź sobie zapis, w którym program z góry wie:

- znaki 1–5: numer;
- znaki 6–25: nazwisko;
- znaki 26–35: data.

Każdy rekord trzeba przygotować według tej samej umowy. Program nie musi zgadywać, gdzie kończy się jedna wartość, a zaczyna następna. Jednocześnie **zmiana umowy** — na przykład dodanie nowego pola lub wydłużenie nazwiska — może oznaczać potrzebę zmiany programów i przechowywanych plików.

Przykład jest dydaktycznym uproszczeniem; rzeczywiste systemy miały wiele różnych struktur rekordów. Chodzi o uchwycenie problemu: jeśli aplikacja jest mocno związana z fizycznym układem danych, zmiana zapisu staje się kosztowna.

## Bazy hierarchiczne i sieciowe

Dane zaczęto organizować w postaci struktur z powiązaniami. W **modelu hierarchicznym** można myśleć o drzewie: u góry klub, niżej sekcje, jeszcze niżej członkowie.

Co jednak zrobić, gdy Anna uprawia jednocześnie showdown i pływanie?

Nie chcemy, żeby była „dwiema Annami” i żeby jej dane trzeba było poprawiać osobno w każdej sekcji. W rzeczywistych systemach istniały sposoby radzenia sobie z podobnymi problemami, ale przykład pokazuje ograniczenie naiwnego drzewa: wiele rzeczywistych zależności nie układa się naturalnie w jedną hierarchię.

W modelach sieciowych możliwe były bardziej złożone połączenia. Kosztem mogło być silniejsze związanie programu ze sposobem poruszania się między rekordami.

## 1970: Codd proponuje inny punkt widzenia

1 czerwca 1970 r. Edgar F. Codd opublikował artykuł *A Relational Model of Data for Large Shared Data Banks*.

Jego przełomowa idea nie polegała po prostu na „narysowaniu tabel”. Chodziło przede wszystkim o **oddzielenie sposobu logicznego opisywania danych od fizycznego ułożenia rekordów w komputerze**.

Wyobraź sobie, że pytasz system: „pokaż członków, którzy uprawiają pływanie”. Nie powinieneś musieć znać sektorów dysku ani ręcznie przechodzić po wskaźnikach wewnętrznego pliku. Podajesz, *jakie dane cię interesują*, a system ma wykonać odpowiednie operacje.

Model relacyjny opiera się na matematycznych relacjach. W praktyce systemy udostępniają go najczęściej jako tabele z wierszami i kolumnami, lecz teoria relacji i rzeczywista implementacja tabel SQL nie są pojęciami tożsamymi.

**Źródła pierwotne:** [IBM Research – opis artykułu Codda](https://research.ibm.com/publications/a-relational-model-of-data-for-large-shared-data-banks) oraz [rekord bibliograficzny ACM, DOI 10.1145/362384.362685](https://doi.org/10.1145/362384.362685).

## Od baz relacyjnych do wielu współistniejących rozwiązań

Rozwój komputerów, sieci i internetu przyniósł kolejne potrzeby:

- **programy współpracujące przez sieć** potrzebowały formatów wymiany danych;
- **systemy z licznymi użytkownikami** potrzebowały sprawnych transakcji i kontroli równoczesnego zapisu;
- **analiza milionów rekordów** zaczęła premiować odczytywanie wybranych kolumn, a nie całych wierszy;
- **systemy AI** zaczęły korzystać z liczb reprezentujących podobieństwo tekstów, zdjęć czy innych obiektów.

Nie oznacza to, że jedna technologia zastąpiła wszystkie pozostałe. Dziś CSV, JSON, XML, SQL, SQLite, PostgreSQL czy Parquet często współpracują w jednym projekcie.

Wybór zależy od tego, **co robimy z danymi**: zapisujemy pojedynczy dokument, przesyłamy rekord przez internet, aktualizujemy wspólną bazę czy analizujemy ogromne zbiory.

## Czego ta historia uczy?

Reprezentacja danych pojawia się tam, gdzie ktoś musi ustalić wspólną umowę dotyczącą znaczenia znaków i wartości. Wraz ze wzrostem liczby zapisów pojawia się drugi problem: jak je wydajnie odnajdywać, łączyć i aktualizować.

To dwie różne, choć powiązane kwestie. Odróżnianie ich pozwoli nam zrozumieć, dlaczego **JSON jest formatem wymiany**, a **SQLite jest systemem bazy danych**.

### Sprawdź, czy rozumiesz

1. Dlaczego uporządkowana kartoteka jest lepsza od luźnych notatek?
2. Co tak naprawdę umożliwiała karta perforowana Holleritha?
3. Dlaczego przechowywanie danych dokładnie według układu wymaganego przez program może utrudniać zmiany?
4. Czy model relacyjny oznacza, że wszystkie bazy danych mają identyczny układ bajtów na dysku?

**Odpowiedzi:** (1) pozwala konsekwentnie porównywać i szukać; (2) maszynowe rozpoznawanie umownie zakodowanych cech; (3) kod i zapis trzeba często zmieniać razem; (4) nie, model logiczny nie przesądza o fizycznym zapisie.

**Dalej:** [2. Dane, informacja i reprezentacja](02-od-informacji-do-reprezentacji.md).
