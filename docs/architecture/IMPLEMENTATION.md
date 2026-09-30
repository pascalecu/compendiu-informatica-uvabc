# Implementarea Fennel

Codul rămîne împărțit în module specializate. Asta este o alegere intenționată:
preferăm fișiere mici, cu responsabilități clare, chiar dacă modelul de date
rămîne relativ simplu.

Structura recomandată este:

```text
src/
├── compendium.fnl
├── tex.fnl
│
├── model/
│   ├── registry.fnl
│   ├── constructors.fnl
│   ├── normalize.fnl
│   ├── indexes.fnl
│   └── queries.fnl
│
├── data/
│   ├── knowledge/
│   │   ├── domains.fnl
│   │   └── topics/
│   └── university/
│       ├── programmes.fnl
│       ├── teachers.fnl
│       ├── sources.fnl
│       ├── courses/
│       ├── curricula/
│       └── syllabi/
│
├── validate/
│   ├── knowledge.fnl
│   ├── curriculum.fnl
│   ├── syllabus.fnl
│   └── model.fnl
│
└── render/
    ├── book.fnl
    ├── courses.fnl
    ├── curriculum.fnl
    ├── programme-profile.fnl
    ├── indexes.fnl
    └── reports.fnl
```

Nu toate modulele trebuie să fie mari ca să merite să existe. Separarea este
utilă și pentru navigarea repository-ului.

## Registry

Registry-ul păstrează entitățile cu identitate proprie:

```clojure
{:domains {}
 :topics {}
 :programmes {}
 :courses {}
 :curricula {}
 :syllabi {}
 :teachers {}
 :sources {}}
```

Structurile interne curriculumului nu au registre proprii.

## Constructori

`constructors.fnl` definește formele de bază:

```text
domain
topic
programme
course
curriculum
course-entry
elective-group
finalization
syllabus
teacher
source
```

Constructorii produc tabele Lua simple.

## Normalizare

`normalize.fnl` transformă reprezentări diferite în valori comune fără să piardă
forma originală.

```text
DOB / DI → :required
DOP / DO → :elective
DFA / DL → :facultative
```

Tot aici poate fi generată titulatura profesorilor și pot fi uniformizate
rolurile sau structura orelor.

Normalizarea nu inventează date lipsă și nu combină cohorte diferite.

## Indexuri

`indexes.fnl` poate construi relații folosite frecvent:

```text
parent-by-topic
courses-by-topic
topics-by-course
course-locations
syllabi-by-course
courses-by-teacher
```

## Queries

`queries.fnl` oferă un API stabil pentru restul proiectului:

```text
courses-for-topic
topics-for-course
course-location
syllabi-for-course
teachers-for-course
semester-entries
```

Rendererele nu trebuie să depindă de forma internă exactă a registry-ului.

## Sugestii de topicuri din fișe

O funcție separată poate analiza `syllabus.contents`, `objectives`,
`learning-outcomes` și `prerequisites` și poate produce candidați pentru:

```clojure
{:primary [...]
 :secondary [...]}
```

Această funcție nu modifică automat datele canonice.

Poate produce, de exemplu, un raport:

```text
course: neural-networks-applications

suggested primary:
  neural-networks
  backpropagation
  recurrent-neural-networks

suggested secondary:
  optimization
  fuzzy-systems
```

Autorul confirmă sau corectează rezultatul.

Dacă analiza devine suficient de mare, poate avea propriul modul:

```text
model/topic-mapping.fnl
```

sau:

```text
analysis/topic-mapping.fnl
```

## Validare

Validarea este împărțită pe domenii fiindcă asta face codul mai ușor de urmărit.

`knowledge.fnl` verifică topicurile și prerechizitele. `curriculum.fnl` verifică
anii, disciplinele și opționalele. `syllabus.fnl` verifică sursele, profesorii
și datele fișelor. `model.fnl` le rulează împreună.

Diferențele dintre documente pot fi avertismente, nu neapărat erori.

## Randări

Rendererele sînt separate după ieșirea pe care o produc:

```text
book.fnl
courses.fnl
curriculum.fnl
programme-profile.fnl
indexes.fnl
reports.fnl
```

Faptul că există un renderer nu înseamnă că toate datele trebuie afișate.
`programme-profile.fnl`, de exemplu, poate rămîne mic sau chiar nefolosit pînă
cînd există o anexă care chiar are nevoie de el.

Ieșirile tipice:

```text
.build/generated/book.tex
.build/generated/courses-info.tex
.build/generated/courses-iast.tex
.build/generated/curriculum-info.tex
.build/generated/curriculum-iast.tex

.build/reports/validation.txt
.build/reports/source-differences.txt
.build/reports/topic-suggestions.txt
```
