# Migrarea de la modelul vechi

Acest document descrie trecerea de la modelul mai complex folosit anterior la
forma actuală.

Poate fi eliminat după terminarea migrării.

## Schimbarea principală

Modelul vechi încerca să distingă explicit:

```text
plan
catalogue
slot
choice-slot
offering
choice-offering
coverage
```

Modelul actual nu mai consideră necesară această granularitate pentru scopul
compendiului.

## Corespondență

| Vechi | Nou |
| --- | --- |
| `domain` | `domain` |
| `topic` | `topic` |
| `programme` | `programme` |
| `course` | `course` |
| `plan` | `curriculum` |
| `catalogue` | absorbit în `curriculum` |
| `course-slot` | `course-entry` |
| `offering` | `course-entry` |
| `choice-slot` | `elective-group` |
| `choice-offering` | eliminat |
| `coverage` | `course.topics` |
| `document` | `source` |
| `syllabus` | `syllabus` |

## Planuri istorice

Nu mai este necesar să existe:

```text
info-plan-2023
info-plan-2024
info-plan-2025
```

ca modele curriculare active.

Se păstrează:

```text
curriculum info
curriculum iast
```

iar Git reține istoricul.

Documentele istorice pot rămîne declarate ca `source` dacă sînt încă folosite de
fișe, note sau verificări.

## Migrarea disciplinelor

`course` păstrează doar identitatea disciplinei și legătura cu materia.

Valorile precum:

```text
code
credits
category
requirement
assessment
hours
```

se mută în `course-entry`.

## Migrarea opționalelor

Un `choice-slot` devine `elective-group`.

În loc de:

```clojure
(choice-slot ...
  (choose 1)
  (options a b))
```

se folosește:

```clojure
(elective-group ...
  {:choose 1
   :options [a b]})
```

## Migrarea `coverage`

Asocierile generale dintre curs și materia compendiului se mută direct în
`course.topics`.

În loc de:

```clojure
(coverage ...
  (from-course info-machine-learning)
  (primary ...)
  (secondary ...))
```

se folosește:

```clojure
(course info-machine-learning
  {:topics
   {:primary [...]
    :secondary [...]}})
```

Asocierile istorice foarte fine, dacă vor deveni vreodată necesare, pot fi
introduse ulterior ca excepții pe `syllabus`.

## Migrarea `document`

`document` devine `source`.

Noul nume descrie proveniența datelor universitare: planuri de învățămînt,
structuri anuale, fișe ale disciplinelor și pagini instituționale. Bibliografia
științifică a compendiului rămîne separată, în BibLaTeX.

## Ordinea recomandată

1. introduceți `source`;
2. mutați documentele existente;
3. creați curriculumul canonic INFO;
4. creați curriculumul canonic IAST;
5. transformați sloturile și ofertele în `course-entry`;
6. transformați grupurile de alegere în `elective-group`;
7. mutați legăturile generale cu materia în `course.topics`;
8. păstrați fișele istorice ca `syllabus`;
9. eliminați adaptoarele vechi după ce testele trec.

## Regula de final

După migrare, modelul trebuie să poată fi explicat astfel:

> Topicurile descriu cartea. Disciplinele descriu universitatea. Curriculumul
> spune unde apare o disciplină, fișa spune ce conține, iar sursa spune de unde
> știm.

Dacă această explicație nu mai este suficientă, o nouă abstracție trebuie
introdusă numai pentru o nevoie concretă.
