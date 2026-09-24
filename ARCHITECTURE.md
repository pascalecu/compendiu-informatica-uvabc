# Arhitectura proiectului

Acest document descrie organizarea internă a compendiului, modelul curricular,
DSL-ul Fennel și relația dintre Fennel, Lua și LuaLaTeX.

## Principii

Arhitectura proiectului urmărește cîteva principii:

1. conținutul academic este organizat pe domenii, nu după ani și semestre;
2. programa universitară este reprezentată separat de conținut;
3. versiunile diferite ale planurilor de învățămînt trebuie să poată coexista;
4. informația nu trebuie duplicată în mai multe locuri;
5. identificatorii și relațiile dintre entități trebuie să poată fi validate
   automat;
6. identificatorii interni sînt stabili și independenți de titlurile afișate;
7. conținutul academic rămîne LaTeX obișnuit;
8. Fennel este sursa pentru modelul, DSL-ul și logica proiectului;
9. Lua este în principal un produs intermediar consumat de LuaLaTeX.

## Structura repository-ului

Structura urmărită este:

```text
.
├── README.md
├── CONTRIBUTING.md
├── LICENSE-CC-BY
├── LICENSE-0BSD
├── main.tex
│
├── docs/
│   └── ARCHITECTURE.md
│
├── preamble/
│
├── content/
│   ├── mathematics/
│   ├── programming-languages/
│   ├── algorithms-theory/
│   ├── data/
│   ├── systems/
│   ├── software-engineering/
│   ├── artificial-intelligence/
│   ├── optimization/
│   ├── graphics/
│   ├── security/
│   ├── academic/
│   ├── education/
│   └── professional/
│
├── src/
│   ├── macros/
│   │   ├── curriculum.fnl
│   │   └── helpers.fnl
│   │
│   ├── data/
│   │   └── curriculum.fnl
│   │
│   ├── model.fnl
│   ├── validate.fnl
│   ├── render.fnl
│   └── tex.fnl
│
├── tests/
│   ├── macros/
│   ├── validation/
│   └── fixtures/
│       ├── valid/
│       └── invalid/
│
├── bibliography/
├── figures/
├── examples/
│
└── .build/
    └── lua/
```

`.build/` conține exclusiv fișiere generate și nu trebuie editat manual sau
versionat.

## Separarea responsabilităților

### LaTeX

LaTeX este responsabil pentru:

* textul academic;
* formule;
* figuri;
* tabele;
* teoreme;
* exerciții;
* bibliografie;
* tipografie;
* layout;
* paginare.

Conținutul propriu-zis al unui capitol trebuie să poată fi citit și editat fără
a cunoaște implementarea modelului curricular.

### Fennel

Fennel este responsabil pentru:

* descrierea programelor de studii;
* descrierea versiunilor planurilor de învățămînt;
* descrierea disciplinelor;
* descrierea domeniilor și capitolelor compendiului;
* relațiile dintre discipline și capitole;
* prerechizite și dependențe conceptuale;
* validare;
* construirea modelului intern;
* generarea structurii necesare pentru LuaLaTeX.

### Lua

Lua este formatul executat de LuaLaTeX.

În mod normal, codul Lua din `.build/lua/` este generat din Fennel și nu se
editează manual.

Fluxul general este:

```text
Fennel
   │
   ▼
macro expansion
   │
   ▼
Lua generat
   │
   ▼
LuaLaTeX
   │
   ├── model curricular
   ├── structură generată
   └── conținut LaTeX
   │
   ▼
PDF
```

## Modelul conceptual

Modelul conține șase tipuri principale de entități:

```text
programme
curriculum
source

domain
chapter
course
```

Acestea aparțin conceptual unor niveluri diferite:

```text
Universitate                         Compendiu

programme                            domain
    │                                   │
    └── curriculum                      └── chapter
          │                                  │
          └── course placement               └┬─ requires
                    │                         │
                    └──────── course ─────────┘
                              │
                              ├── covers
                              └── assumes
```

## Identificatori

Fiecare entitate are un identificator intern stabil.

Exemple:

```text
info
info-2025
neural-networks
retele-neuronale
```

Identificatorul nu este un titlu și nu trebuie modificat doar pentru că
denumirea afișată a entității se schimbă.

De exemplu, titlul:

```text
Grafuri și teoria grafurilor
```

poate fi modificat ulterior fără a schimba identificatorul:

```text
graph-theory
```

Identificatorii sînt utilizați pentru:

* referințe;
* relații între entități;
* etichete LaTeX;
* indexuri;
* validare;
* generarea căilor implicite.

## `programme`

Un `programme` descrie identitatea unui program universitar, independent de un
anumit plan de învățămînt.

Exemple:

```clojure
(programme info
  "Informatică"
  (degree "Licență")
  (short "INFO"))

(programme iast
  "Informatică Aplicată în Știință și Tehnologie"
  (degree "Master")
  (short "IAST"))
```

Un program nu conține direct ani, semestre sau discipline.

Aceste informații aparțin unui `curriculum`.

## `curriculum`

Un `curriculum` reprezintă o versiune concretă a planului de învățămînt pentru
un program.

Exemplu:

```clojure
(curriculum info-2025
  (programme info)
  (academic-year "2025–2026")
  (years 3)
  (source info-plan-2025)

  (year 1
    (semester 1
      ...)

    (semester 2
      ...))

  (year 2
    ...)

  (year 3
    ...))
```

Separarea dintre `programme` și `curriculum` permite existența simultană a mai
multor versiuni ale planului:

```clojure
(curriculum info-2023 ...)
(curriculum info-2025 ...)
(curriculum info-2027 ...)
```

Astfel, modificarea structurii unui program nu necesită redefinirea
disciplinelor sau pierderea informațiilor despre cohorte mai vechi.

## Discipline în cadrul unui `curriculum`

Poziția unei discipline este proprietatea planului de învățămînt, nu a
disciplinei în sine.

De aceea, anul, semestrul și numărul de credite sînt declarate în `curriculum`.

Exemplu:

```clojure
(year 1
  (semester 2
    (required
      (course structuri-date
        (credits 5))

      (course algoritmi-fundamentali
        (credits 5)))))
```

O altă versiune a planului poate plasa aceeași disciplină în alt semestru sau îi
poate atribui alt număr de credite fără a modifica definiția disciplinei.

## Discipline obligatorii, opționale și facultative

DSL-ul trebuie să poată reprezenta cel puțin:

* discipline obligatorii;
* grupuri de discipline opționale;
* discipline facultative.

Exemplu:

```clojure
(year 3
  (semester 1

    (required
      (course artificial-intelligence
        (credits 5))

      (course operating-systems
        (credits 5)))

    (elective-group software-or-ml
      (choose 1)

      (course software-engineering
        (credits 4))

      (course machine-learning
        (credits 4)))

    (facultative
      (course foreign-language
        (credits 2)))))
```

`elective-group` reprezintă explicit faptul că disciplinele aparțin aceluiași
grup de alegere.

`choose` indică numărul de discipline care trebuie alese din grup.

## `source`

Un `source` descrie proveniența informațiilor curriculare.

Exemplu:

```clojure
(source info-plan-2025
  (title "Plan de învățămînt — Informatică")
  (institution "Universitatea „Vasile Alecsandri” din Bacău")
  (academic-year "2025–2026")
  (url "..."))
```

Un plan de învățămînt îl poate referenția prin:

```clojure
(source info-plan-2025)
```

Sursele pot fi utilizate ulterior și pentru generarea automată a referințelor
sau a unei secțiuni privind proveniența informațiilor curriculare.

## `domain`

Un `domain` reprezintă o parte tematică principală a compendiului.

Exemplu:

```clojure
(domain artificial-intelligence
  "Inteligență artificială")
```

Domeniile nu reprezintă discipline universitare.

Exemple de domenii:

```text
mathematics
programming-languages
algorithms-theory
data
systems
software-engineering
artificial-intelligence
optimization
graphics
security
academic
education
professional
```

Ordinea declarațiilor domeniilor poate defini ordinea lor în document.

## `chapter`

Un `chapter` reprezintă o unitate conceptuală a compendiului.

Exemplu:

```clojure
(chapter neural-networks
  "Rețele neuronale"

  (domain artificial-intelligence)

  (requires
    calculus
    linear-algebra
    probability
    machine-learning))
```

Din această declarație pot fi deduse automat informații precum:

```text
id      = neural-networks
label   = chapter:neural-networks
file    = content/artificial-intelligence/neural-networks.tex
```

### `requires`

`requires` descrie relațiile conceptuale dintre capitole.

De exemplu:

```clojure
(chapter neural-networks
  "Rețele neuronale"

  (domain artificial-intelligence)

  (requires
    calculus
    linear-algebra
    probability
    machine-learning))
```

înseamnă că înțelegerea capitolului `neural-networks` presupune materialul din
capitolele enumerate.

Aceste relații pot fi utilizate pentru:

* afișarea prerechizitelor;
* generarea unor trasee de studiu;
* detectarea dependențelor;
* verificarea ciclurilor.

## `course`

Un `course` reprezintă identitatea unei discipline universitare, independent de
poziția acesteia într-un anumit plan de învățămînt.

Exemplu:

```clojure
(course retele-neuronale
  "Rețele neuronale. Aplicații"

  (scope core)

  (assumes
    machine-learning)

  (covers
    (primary neural-networks)
    (supporting optimization)))
```

Un `course` nu conține:

```text
an
semestru
credite
```

deoarece aceste informații aparțin unui `curriculum`.

## `scope`

Nu toate disciplinele dintr-un plan de învățămînt trebuie să producă material
propriu în compendiu.

`scope` descrie rolul unei discipline în proiect.

Valorile inițiale sînt:

```text
core
supporting
curriculum-only
```

### `core`

Disciplina este direct relevantă pentru conținutul principal al compendiului.

```clojure
(scope core)
```

### `supporting`

Disciplina este relevantă, dar nu constituie unul dintre nucleele principale ale
compendiului.

```clojure
(scope supporting)
```

### `curriculum-only`

Disciplina este păstrată în harta curriculară pentru completitudine, dar nu
primește în mod necesar conținut propriu.

```clojure
(scope curriculum-only)
```

De exemplu:

```clojure
(course educatie-fizica-1
  "Educație fizică I"
  (scope curriculum-only))
```

## Relația dintre discipline și capitole

O disciplină și un capitol sînt concepte diferite.

Un curs poate utiliza mai multe capitole, iar un capitol poate fi relevant
pentru mai multe discipline.

sînt utilizate două mecanisme diferite:

```text
covers
assumes
```

### `covers`

`covers` descrie materialul tratat efectiv în cadrul disciplinei.

Nivelurile inițiale de asociere sînt:

```text
primary
supporting
```

#### `primary`

Capitolul constituie material central pentru disciplină.

#### `supporting`

Capitolul este relevant pentru disciplină, dar nu constituie tema principală.

Exemplu:

```clojure
(course optimizare-combinatorie
  "Optimizare combinatorie"

  (scope core)

  (covers
    (supporting graph-algorithms)

    (primary
      combinatorial-optimization
      heuristics
      metaheuristics)))
```

### `assumes`

`assumes` descrie materialul pe care disciplina îl presupune deja cunoscut.

Exemplu:

```clojure
(course retele-neuronale
  "Rețele neuronale. Aplicații"

  (scope core)

  (assumes
    machine-learning
    probability
    linear-algebra)

  (covers
    (primary neural-networks)))
```

Diferența este:

```text
chapter.requires
    dependență conceptuală între capitole

course.assumes
    material presupus de o disciplină

course.covers
    material tratat efectiv de disciplină
```

## DSL-ul Fennel

DSL-ul este definit în:

```text
src/macros/curriculum.fnl
```

Formele principale urmărite sînt:

```clojure
curriculum-data

programmes
programme
degree
short

curricula
curriculum
academic-year
years
year
semester
required
elective-group
choose
facultative
credits

sources
source
title
institution
url

domains
domain

chapters
chapter
requires

courses
course
scope
assumes
covers
primary
supporting
```

Un catalog poate arăta, conceptual, astfel:

```clojure
(curriculum-data

  (programmes
    (programme info
      "Informatică"
      (degree "Licență")
      (short "INFO"))

    (programme iast
      "Informatică Aplicată în Știință și Tehnologie"
      (degree "Master")
      (short "IAST")))

  (sources
    (source info-plan-2025
      (title "Plan de învățămînt — Informatică")
      (institution
        "Universitatea „Vasile Alecsandri” din Bacău")
      (academic-year "2025–2026")
      (url "...")))

  (domains
    (domain mathematics
      "Fundamente matematice și modelare")

    (domain artificial-intelligence
      "Inteligență artificială"))

  (chapters
    (chapter calculus
      "Analiză matematică"
      (domain mathematics))

    (chapter neural-networks
      "Rețele neuronale"
      (domain artificial-intelligence)
      (requires calculus)))

  (courses
    (course retele-neuronale
      "Rețele neuronale. Aplicații"

      (scope core)

      (assumes calculus)

      (covers
        (primary neural-networks))))

  (curricula
    (curriculum info-2025
      (programme info)
      (academic-year "2025–2026")
      (years 3)
      (source info-plan-2025)

      (year 1
        (semester 1
          ...))

      (year 2
        ...)

      (year 3
        ...))))
```

DSL-ul trebuie să rămînă declarativ.

Logica de procesare nu trebuie introdusă în catalogul curricular.

## Macro-uri

Macro-urile sînt utilizate pentru:

* eliminarea boilerplate-ului;
* transformarea identificatorilor simbolici în reprezentarea internă;
* generarea căilor implicite;
* generarea etichetelor;
* normalizarea declarațiilor;
* verificarea structurii locale;
* transformarea DSL-ului într-un model Lua simplu.

De exemplu:

```clojure
(chapter neural-networks
  "Rețele neuronale"
  (domain artificial-intelligence))
```

poate expanda conceptual la:

```clojure
{:id "neural-networks"
 :title "Rețele neuronale"
 :domain "artificial-intelligence"
 :label "chapter:neural-networks"
 :file "content/artificial-intelligence/neural-networks.tex"
 :prerequisites []}
```

Modelul rezultat trebuie să rămînă simplu chiar dacă DSL-ul devine mai expresiv.

## Validare

Validarea se face în două etape.

### Validare la expandarea macro-urilor

Macro-urile verifică proprietățile care pot fi determinate local.

Exemple:

* forma declarațiilor;
* existența cîmpurilor obligatorii;
* opțiuni duplicate;
* valori numerice invalide;
* semestru diferit de `1` sau `2`;
* `choose` mai mic decît `1`;
* număr negativ de credite;
* valori necunoscute pentru `scope`.

Macro-urile nu trebuie să încerce să rezolve relațiile globale dintre entități.

### Validare globală

`src/validate.fnl` verifică modelul complet.

Printre verificări se pot afla:

* identificatori unici;
* programe existente;
* planuri de învățămînt existente;
* domenii existente;
* discipline existente;
* capitole existente;
* surse existente;
* ani compatibili cu durata programului;
* referințe curriculare valide;
* grupuri de opționale valide;
* `choose` compatibil cu numărul de opțiuni;
* prerechizite existente;
* relații `covers` și `assumes` valide;
* fișiere LaTeX existente;
* eventuale cicluri în graful prerechizitelor.

Exemple de erori:

```text
curriculum: unknown chapter 'neurel-networks'
```

```text
curriculum: unknown course 'machine-learing'
```

```text
curriculum: year 4 is invalid for curriculum 'info-2025'
```

```text
curriculum: prerequisite cycle:
machine-learning
→ neural-networks
→ machine-learning
```

## Modelul intern

`src/model.fnl` transformă catalogul declarat prin DSL într-un model ușor de
interogat.

Printre indexurile utile se pot afla:

```text
programme-by-id
curriculum-by-id
source-by-id

domain-by-id
chapter-by-id
course-by-id

chapters-by-domain
chapters-by-course
courses-by-chapter

prerequisites-by-chapter
dependants-by-chapter

curricula-by-programme
course-placements-by-curriculum
```

Listele inverse nu sînt menținute manual, ci sînt generate din model.

## Render

`src/render.fnl` generează structura principală a documentului.

Conceptual:

```text
pentru fiecare domeniu
    generează partea

    pentru fiecare capitol al domeniului
        generează titlul
        generează prerechizitele
        generează disciplinele asociate
        include fișierul LaTeX
```

Conținutul academic nu trebuie generat din Fennel. Acest lucru aparține
LaTeX-ului:

```latex
\section{Perceptronul}

Un perceptron este...
```

Fennel gestionează structura și metadatele, nu redactarea materialului academic.

## Integrarea cu TeX

`src/tex.fnl` reprezintă stratul dintre Fennel/Lua și TeX.

Aici trebuie concentrate operații precum:

* escaping pentru text introdus în TeX;
* emiterea comenzilor;
* generarea etichetelor;
* generarea hyperlinkurilor;
* includerea fișierelor;
* generarea elementelor structurale.

Astfel, `render.fnl` nu trebuie să conțină peste tot concatenări manuale de
forma:

```lua
tex.print("\\chapter{" .. title .. "}")
```

## Harta curriculară

Harta curriculară este generată din entitățile `curriculum`.

Ea poate păstra simultan mai multe versiuni ale planurilor de învățămînt.

Exemplu:

```text
Informatică — plan 2025–2026
└── Anul I
    ├── Semestrul I
    │   ├── ...
    │   └── ...
    └── Semestrul II
        ├── Structuri de date
        └── Algoritmi fundamentali
```

Pentru o disciplină, harta poate afișa și legături către materialul relevant:

```text
IAST — Anul I — Semestrul I

Rețele neuronale. Aplicații
├── presupune
│   ├── Învățare automată
│   └── Probabilități și statistică
└── acoperă
    └── Rețele neuronale
```

Legăturile către capitole sînt generate automat.

## Teste

DSL-ul și validatorul trebuie testate independent de documentul complet.

Structura inițială este:

```text
tests/
├── macros/
├── validation/
└── fixtures/
    ├── valid/
    └── invalid/
```

Testele pentru macro-uri trebuie să verifice transformarea formelor DSL în
modelul intern așteptat.

Exemple:

```clojure
(chapter neural-networks
  "Rețele neuronale"
  (domain artificial-intelligence))
```

trebuie să genereze identificatorul, domeniul, eticheta și calea așteptate.

Testele de validare trebuie să includă cel puțin:

* identificatori duplicați;
* programe inexistente;
* discipline inexistente;
* capitole inexistente;
* ani invalizi;
* semestre invalide;
* grupuri de opționale invalide;
* fișiere LaTeX inexistente;
* prerechizite inexistente;
* cicluri între prerechizite.

## Build

Sursele Fennel reprezintă sursa de adevăr pentru codul proiectului.

```text
src/*.fnl
    │
    │ Fennel
    ▼
.build/lua/*.lua
    │
    │ LuaLaTeX
    ▼
document PDF
```

Fișierele Lua generate nu trebuie versionate.

`.gitignore` trebuie să includă cel puțin:

```gitignore
.build/
```

Procesul de build va fi automatizat astfel încît compilarea Fennel și LuaLaTeX
să poată fi pornite printr-o singură comandă.

## Regula sursei unice

Fiecare informație trebuie definită într-un singur loc.

De exemplu:

```text
identitatea programului        → programme
versiunea planului             → curriculum
sursa planului                 → source

numele domeniului              → domain
numele capitolului             → chapter
prerechizitele capitolului     → requires

identitatea disciplinei        → course
materialul presupus            → assumes
relația disciplină–capitol     → covers

anul, semestrul și creditele   → curriculum
statutul obligatoriu/opțional  → curriculum
```

Nu trebuie menținute manual informații derivate precum:

```text
courses-by-chapter
chapters-by-course
curricula-by-programme
```

Acestea sînt generate din model.

Această regulă este importantă pentru evitarea inconsistențelor pe măsură ce
proiectul crește.
