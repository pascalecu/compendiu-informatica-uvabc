# Arhiva surselor UVABc

Acest director conține copii ale documentelor publicate de Universitatea „Vasile
Alecsandri” din Bacău și folosite ca surse pentru compendiu.

Documentele sînt păstrate local pentru ca datele proiectului să poată fi
verificate și după modificarea structurii site-ului universității, schimbarea
adreselor documentelor sau eliminarea unor versiuni mai vechi.

Arhiva este organizată după anul universitar:

```text
uvabc/
├── latest -> 2025-2026
└── 2025-2026/
    ├── SHA256SUMS
    ├── info/
    │   ├── plan.pdf
    │   ├── structure-year-1.pdf
    │   ├── structure-year-2.pdf
    │   ├── structure-year-3.pdf
    │   ├── syllabi-year-1.pdf
    │   ├── syllabi-year-2.pdf
    │   └── syllabi-year-3.pdf
    └── iast/
        ├── plan.pdf
        ├── structure-year-1.pdf
        ├── structure-year-2.pdf
        ├── syllabi-year-1.pdf
        └── syllabi-year-2.pdf
```

`latest` este un link simbolic **relativ** către cel mai recent set arhivat în
repository. Nu înseamnă neapărat anul universitar aflat în curs și nu trebuie
folosit pentru identificarea unei surse istorice.

Datele care trebuie să indice o sursă exactă folosesc întotdeauna calea
versionată:

```text
sources/uvabc/2025-2026/info/plan.pdf
```

și nu:

```text
sources/uvabc/latest/info/plan.pdf
```

Instrucțiunile pentru clonarea repository-ului cu suport pentru linkuri
simbolice, inclusiv pe Windows, se găsesc în
[`README`](../../README.md#clonare). Dacă `latest` nu poate fi creat ca link
simbolic, directoarele versionate rămîn accesibile direct.

## Integritate

Fiecare an universitar are propriul fișier `SHA256SUMS`.

Pentru 2025–2026, verificarea poate fi făcută din rădăcina repository-ului cu:

```sh
sha256sum -c sources/uvabc/2025-2026/SHA256SUMS
```

Fișierul conține căile documentelor relativ la rădăcina repository-ului.

Sumele SHA-256 permit verificarea integrității documentelor arhivate și
compararea unei versiuni publicate ulterior cu una păstrată deja.

## Proveniență

Copia locală păstrează documentul folosit efectiv de proiect. URL-ul original
păstrează proveniența sa.

Metadata unei surse poate conține, de exemplu:

```clojure
{:file "sources/uvabc/2025-2026/info/plan.pdf"
 :url "https://www.ub.ro/..."
 :retrieved "2026-09-30"
 :sha256 "..."}
```

Pentru planurile de învățămînt, anul din calea arhivei indică snapshot-ul în
care documentul a fost colectat. Perioada sa reală de aplicare trebuie păstrată
separat în metadata atunci cînd este relevantă.

Mai multe informații despre documentele folosite și rolul fiecărui tip de sursă
se găsesc în [`SOURCES.md`](../../docs/SOURCES.md).

## Licențiere

Fișierele din acest director sînt documente externe arhivate și nu reprezintă
conținut original al compendiului.

Licențele CC BY 4.0 și 0BSD ale proiectului nu se extind asupra acestor
documente. Drepturile și condițiile aplicabile fiecărui document rămîn cele ale
sursei originale.
