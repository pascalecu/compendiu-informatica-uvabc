# Fișele disciplinelor

`syllabus` reprezintă o fișă concretă dintr-un anumit an universitar.

```clojure
(syllabus operating-systems-2025
  {:course operating-systems
   :academic-year "2025-2026"
   :source info-syllabi-y3-2025
   :pages [1 4]
   ...})
```

În arhiva 2025–2026, fișa pentru „Sisteme de operare” ocupă primele patru pagini
din pachetul INFO pentru anul III.

O disciplină poate avea mai multe fișe în timp.

## Ce merită structurat

Fișele conțin multe informații, dar nu toate trebuie tratate la aceeași
granularitate.

Pentru compendiu, cele mai utile sînt de obicei:

```text
teachers
reported
prerequisites
contents
bibliography
```

Restul poate fi păstrat atunci cînd este util:

```clojure
:details
{:workload ...
 :conditions ...
 :competences ...
 :objectives ...
 :alignment ...
 :evaluation ...
 :minimum-standard ...
 :learning-outcomes ...
 :approval ...}
```

`details` nu înseamnă că toate aceste cîmpuri trebuie să existe și nici că
trebuie modelate foarte fin.

## Date repetate

Dacă fișa repetă informații din curriculum, le putem păstra separat:

```clojure
:reported
{:study-year 3
 :semester 5
 :category "DF"
 :requirement "DI"
 :assessment "E"
 :credits 4}
```

Aceste valori apar în fișa „Sisteme de operare” din pachetul INFO 2025–2026.
Planul folosește `DOB` pentru aceeași disciplină, ceea ce este un exemplu bun de
ce merită păstrată forma raportată de fiecare document.

## Profesori

Profesorii sînt legați de fișa concretă, nu direct de `course`.

De exemplu, fișa „Rețele neuronale. Aplicații” din IAST 2025–2026 îl indică pe
Iulian-Marius Furdu atît pentru curs, cît și pentru seminar:

```clojure
:teachers
{:lecture [iulian-furdu]
 :seminar [iulian-furdu]}
```

Dacă este importantă forma exactă publicată într-o fișă veche, aceasta poate fi
păstrată local prin cîmpuri precum `reported-name` sau `reported-title`.

## Conținuturi

Conținuturile pot fi structurate fără a inventa formulări care nu apar în sursă.
De exemplu, fișa „Sisteme de operare” conține tema:

```clojure
:contents
{:lecture
 [{:title "Drivere și module de nucleu. Procese și gestiunea lor."
   :hours 2}]}
```

Fișa „Rețele neuronale. Aplicații” conține, între altele, teme precum
„Algoritmul de retropropagare și ameliorări ale acestuia”, „Rețele Kohonen” și
„Rețele recurente: retropropagarea în timp”. Aceste conținuturi pot alimenta
sugestiile pentru `course.topics.primary` și `course.topics.secondary`.

Nu generăm însă topicuri automat și definitiv doar din textul fișei. Un script
poate propune, iar autorul confirmă sau corectează.

## Bibliografie

Bibliografia unei fișe rămîne metadată curriculară.

O carte intră în bibliografia efectivă a compendiului numai dacă este folosită
la redactarea lui.
