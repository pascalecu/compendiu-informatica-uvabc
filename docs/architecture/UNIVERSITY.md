# Programe, curriculum și discipline

## Programe

```clojure
(programme info
  {:title "Informatică"
   :short "INFO"
   :cycle :bachelor
   :duration-years 3})

(programme iast
  {:title "Informatică Aplicată în Științe și Tehnologie"
   :short "IAST"
   :cycle :master
   :duration-years 2})
```

Planurile UVABc 2025–2026 indică trei ani pentru INFO și doi ani pentru IAST.

## Discipline

`course` este identitatea disciplinei:

```clojure
(course operating-systems
  {:title "Sisteme de operare"
   :summary "..."
   :topics {...}})
```

Nu îi asociem obligatoriu un singur program. Relația cu INFO sau IAST este dată
de curriculum.

## Curriculum

Curriculumul canonic este structura pe care o folosește compendiul pentru un
program.

```clojure
(curriculum info
  {:programme info
   :sources [...]
   :years
   {1 {:source info-structure-y1-2025 ...}
    2 {:source info-structure-y2-2025 ...}
    3 {:source info-structure-y3-2025 ...}}
   :profile {...}
   :statistics {...}
   :finalization [...]})
```

`profile` și `statistics` pot păstra datele suplimentare din plan, dar nu
trebuie să genereze automat alte subsisteme sau randări.

Detaliile despre cohorte, intrările curriculare și opționale sînt în
[`CURRICULUM.md`](CURRICULUM.md).

## Course entry

```clojure
(course-entry operating-systems
  {:code "UB03I501F"
   :category {:value :fundamental :reported "DF"}
   :requirement {:value :required :reported "DOB"}
   :credits 4
   :assessment {:value :exam :reported "E"}
   :hours {...}})
```

Valorile normalizate ajută la interogări. `reported` păstrează forma folosită de
document.

Pentru ore, schema trebuie să poată reprezenta curs, seminar, laborator,
proiect, practică și, unde apare, coloana `U`.

## Opționale

```clojure
(elective-group
  {:choose 1
   :options
   [software-testing
    cloud-computing
    special-web-engineering]
   :selected software-testing})
```

Exemplul este bazat pe Opționalul 1 IAST din 2025–2026: planul publică cele trei
variante, iar structura anului I indică „Testare și analiză software” ca
variantă aleasă.

## Practică și finalizare

Activitățile care apar în semestru cu credite rămîn `course-entry`.
`finalization` este rezervat probelor de după ultimul semestru.

## Profesori

Pentru INFO și IAST folosim un model redus:

```clojure
(teacher gloria-cerasela-crisan
  {:name "Gloria-Cerasela Crișan"
   :position :associate-professor
   :doctorate :doctor
   :habilitation true})
```

Titulatura se generează din aceste valori.

Profesorii sînt legați de fișe, nu direct de `course`, fiindcă titularii se pot
schimba de la un an la altul.
