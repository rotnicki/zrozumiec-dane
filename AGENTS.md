# Zasady pracy nad kompendium „Zrozumieć dane”

Te instrukcje obowiązują przy wszystkich zmianach w tym repozytorium. Najpierw przeczytaj `README.md`, `STAN_PRAC.md`, `SPIS_TRESCI.md` i odpowiednie rozdziały.

## Cel i odbiorca

- Pisanie w języku polskim dla osoby zainteresowanej technologią bez wymaganego przygotowania informatycznego.
- Wyjaśnianie **mechanizmów, przyczyn historycznych, kompromisów i konsekwencji**, a nie jedynie definiowanie terminów.
- Struktura rozdziału: pytanie/problem → prosty model → mechanizm → konkretny przykład → ograniczenia i wyjątki → podsumowanie lub pytania kontrolne.
- Zachowanie wspólnego, fikcyjnego przykładu klubu sportowego; zdefiniowane identyfikatory i nazwy muszą być spójne między plikami.

## Precyzja

- Rozróżniaj: dane/informacje; wartość/typ; schemat/rekord; model logiczny/zapis fizyczny; format/implementację; plik/system bazodanowy; SQL/język vs SQLite/silnik.
- Nie utożsamiaj SQL z formatem pliku, JSON z bazą danych ani Parquet z systemem zarządzania bazą.
- Nie utożsamiaj poprawności składni z prawdziwością danych. Wyjaśniaj `null`, brak pola i pustą wartość.
- Używaj „na przykład”, gdy opisujesz jedną z kilku możliwych implementacji. Zaznaczaj zależność od wersji lub ustawień.
- Gdy historia technologii nie ma jednoznacznej daty „wynalezienia”, nie podawaj jej bez mocnej podstawy źródłowej.

## Źródła

- Preferuj dokumentację normatywną, publikacje autorów, organizacje normalizacyjne, archiwa instytucji i dokumentacje twórców technologii.
- Przy twierdzeniach historycznych i specyfikacyjnych podawaj bezpośredni odsyłacz do źródła i jego charakter; opis źródła centralnie w `ZRODLA.md`.
- Weryfikuj aktualne wersje w chwili pracy; zapisuj **datę sprawdzenia** i stan projektu (np. szkic, standard opublikowany, eksperyment).
- Brak potwierdzenia oznaczaj jawnie. Oddzielaj źródłowe fakty, wnioski redakcyjne, analogie i hipotezy. Nie przenoś wewnętrznych identyfikatorów cytowań z rozmów AI.
- Nie kopiuj obszernych fragmentów specyfikacji; pisz własnym językiem i stosuj krótkie cytaty tylko wtedy, kiedy są potrzebne.

## Dostępność

- Zwięzłe nagłówki Markdown w logicznej hierarchii; poprawne listy i linki opisowe.
- Wytłumacz słowami budowę każdego istotnego przykładu kodu: znaczenie symboli, wierszy, kolumn i wyniku.
- Nie wymagaj od czytelnika zobaczenia obrazka, wykresu lub koloru. Jeśli dodasz diagram, dodaj pełny opis w tekście.
- Przykłady do samodzielnego uruchomienia opisuj krok po kroku; ostrzegaj przed operacjami zapisującymi lub usuwającymi rzeczywiste dane.
- Nie opieraj kursu na jednym systemie operacyjnym; jeśli instrukcja jest zależna od systemu, nazwij ten fakt.

## Praktyka i repozytorium

- Przykłady są fikcyjne; żadnych poufnych danych osobowych, haseł, tokenów, korespondencji lub surowych rozmów w publicznym repozytorium.
- Przykłady maszynowe powinny być poprawne składniowo i sprawdzone odpowiednim parserem lub narzędziem, jeśli jest dostępne. Opisz, czego nie sprawdzono.
- Nie twórz pustych katalogów na zapas. Kolejne rozdziały dopisuj dopiero wraz z treścią.
- Przy zmianie struktury aktualizuj `README.md` i `SPIS_TRESCI.md`; przy zakończeniu etapu aktualizuj `STAN_PRAC.md`.
- Nie zmieniaj historii git przez nadpisywanie wcześniejszych commitów. Każda logiczna zmiana powinna mieć uzasadniony commit.
- Opracowania robocze i historia decyzji są prowadzone w osobnym **prywatnym** repozytorium. To repozytorium musi pozostawać samodzielne.
