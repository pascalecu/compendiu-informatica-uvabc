# Curriculum și discipline

Acest document descrie programele de studiu, disciplinele și curriculumul
canonic folosit de proiect.

## Programe

`programme` descrie identitatea unui program de studiu.

```clojure
(programme info
  {:title "Informatică"
   :short "INFO"
   :cycle :bachelor
   :duration-years 3
   :study-mode :full-time})

(programme iast
  {:title "Informatică Aplicată în Științe și Tehnologie"
   :short "IAST"
   :cycle :master
   :duration-years 2
   :study-mode :full-time})
```

Programul este independent de disciplinele și fișele sale.

## Discipline

`course` descrie o disciplină ca identitate.

```clojure
(course operating-systems
  {:title "Sisteme de operare"
   :topics {...}})
```

Nu îi asociem obligatoriu un singur program. Relația cu INFO sau IAST este dată
de curriculum.

În `course` se păstrează informații suficient de stabile, precum titlul canonic,
denumiri alternative și legătura cu topicurile compendiului. Anul, semestrul,
codul, creditele, categoria, regimul, forma de verificare, orele și titularii
aparțin curriculumului sau fișei disciplinei.

## Curriculumul canonic

Fiecare program are un curriculum canonic folosit de compendiu. Acesta nu este
neapărat copia unui singur PDF: în același an universitar pot coexista cohorte
care urmează planuri diferite.

```clojure
(curriculum info
  {:programme info
   :sources [info-plan-2025]
   :years
   {1 {:source info-structure-y1-2025 ...}
    2 {:source info-structure-y2-2025 ...}
    3 {:source info-structure-y3-2025 ...}}
   :profile {...}
   :statistics {...}
   :finalization [...]})
```

Pentru documentele UVABc din 2025–2026, planurile INFO și IAST conțin atît
secțiuni marcate „Valabil începînd cu anul I universitar 2025-2026”, cît și
secțiuni pentru ani superiori marcate separat ca valabile în anul universitar
2025–2026. Aceste secțiuni nu trebuie amestecate fără a ține cont de cohortă.

## Ani și semestre

Forma recomandată este o structură imbricată:

```clojure
(curriculum info
  {:programme info
   :years
   {1 {:semesters {1 [...] 2 [...]}}
    2 {:semesters {3 [...] 4 [...]}}
    3 {:semesters {5 [...] 6 [...]}}}})
```

Numerele semestrelor pot fi globale în cadrul programului.

## `course-entry`

O apariție concretă a unei discipline într-un semestru este descrisă prin
`course-entry`.

```clojure
(course-entry operating-systems
  {:code "UB03I501F"
   :category {:value :fundamental :reported "DF"}
   :requirement {:value :required :reported "DOB"}
   :credits 4
   :assessment {:value :exam :reported "E"}
   :hours
   {:weekly
    {:lecture 2
     :laboratory 1}
    :semester
    {:lecture 28
     :applications 14
     :total 42
     :individual 58}}})
```

Exemplul de mai sus corespunde disciplinei „Sisteme de operare” din planul INFO
valabil începînd cu anul I universitar 2025–2026.

`course-entry` nu are registru global propriu; identitatea disciplinei rămîne în
`course`.

## Categorii, regim și evaluare

Modelul normalizează abrevierile administrative, dar poate păstra și forma
publicată de sursă:

```text
DF → :fundamental
DD → :domain
DS → :specialized
DC → :complementary

DOB / DI → :required
DOP / DO → :elective
DFA / DL → :facultative

E → :exam
C → :colloquium
V → :continuous
```

Fișele disciplinelor folosesc uneori `DI`, `DO` și `DL`, în timp ce planurile și
structurile folosesc în mod obișnuit `DOB`, `DOP` și `DFA`. Normalizarea nu
înlocuiește forma raportată de document atunci cînd aceasta este utilă pentru
audit.

## Ore

Schema trebuie să poată reprezenta, după caz:

- curs (`C`);
- seminar (`S`);
- laborator (`L`);
- proiect (`P`);
- practică (`A`);
- opțiunea universității (`U`), acolo unde apare;
- totalurile semestriale (`TOC`, `TOA`, `TO`);
- studiul individual (`SI`).

Nu inventăm valori zero atunci cînd sursa doar lasă un cîmp necompletat.

## Discipline opționale

Un grup de opționale este reprezentat prin `elective-group`.

```clojure
(elective-group
  {:choose 1
   :options
   [software-testing
    cloud-computing
    special-web-engineering]
   :selected software-testing})
```

Exemplul corespunde Opționalului 1 IAST: planul publică variantele „Testare și
analiză software”, „Cloud Computing” și „Capitole speciale de inginerie web”,
iar structura anului I 2025–2026 indică drept variantă aleasă „Testare și
analiză software”.

`selected` nu înlocuiește `options`. Lista variantelor și alegerea dintr-un an
concret pot proveni din documente diferite.

## Discipline facultative

O disciplină facultativă poate fi reprezentată printr-un `course-entry` cu
`requirement.value = :facultative`. Dacă există un grup facultativ din care se
alege, se folosește `elective-group` cu același regim.

Alegerea și caracterul facultativ sînt proprietăți diferite.

## Practică, elaborarea lucrării și finalizare

Activitățile care apar în interiorul unui semestru și au credite sau evaluare
rămîn `course-entry`. Aici intră, de exemplu, practica de specialitate și
elaborarea lucrării de licență sau de disertație atunci cînd apar în tabelul
semestrului.

`finalization` este rezervat probelor plasate după ultimul semestru. De exemplu,
planul IAST valabil începînd cu anul I 2025–2026 are în semestrul 4 „Elaborarea
lucrării de disertație”, iar după semestrul 4 publică separat „Prezentarea și
susținerea publică a lucrării de disertație”, cu 10 credite.

## Sursele curriculumului

Curriculumul poate indica mai multe surse. Pentru date istorice sau pentru
secțiuni diferite ale aceluiași PDF trebuie păstrat suficient context încît să
poată fi identificată exact informația folosită, inclusiv pagina sau intervalul
de pagini atunci cînd este necesar.

Nu completăm datele unei cohorte cu valori din alta doar pentru a umple un cîmp
lipsă.

## Actualizări

Arhiva de documente poate primi un snapshot pentru fiecare an universitar chiar
dacă documentele sînt neschimbate. Curriculumul canonic, în schimb, nu trebuie
duplicat doar pentru că s-a schimbat anul calendaristic; îl actualizăm cînd
apare o schimbare relevantă pentru structura folosită de compendiu.

Git păstrează istoricul modificărilor modelului, iar `sources/uvabc/` păstrează
documentele din care au fost extrase datele.
