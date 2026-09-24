# Contribuții

Contribuțiile la compendiu sînt binevenite, în special corecturile,
completările, materialele asociate disciplinelor și informațiile privind
modificările recente ale programei.

Înainte de modificări structurale semnificative, este recomandată consultarea
[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

## Tipuri de contribuții

Sînt utile în special:

* corectarea greșelilor de conținut;
* corectarea greșelilor de redactare;
* completarea unor explicații;
* exemple suplimentare;
* exerciții și probleme;
* implementări;
* figuri și diagrame;
* actualizarea informațiilor curriculare;
* semnalarea unor discipline sau teme lipsă;
* bibliografie și surse relevante.

## Organizarea conținutului

Conținutul academic este organizat pe domenii, nu după program, an sau semestru.

De exemplu:

```text
content/
├── algorithms-theory/
├── artificial-intelligence/
├── mathematics/
├── optimization/
└── systems/
```

Dacă un subiect este utilizat de mai multe discipline, acesta trebuie, pe cît
posibil, tratat o singură dată și referențiat din celelalte locuri.

Nu copiați același material în mai multe capitole doar pentru a reproduce
structura unor cursuri diferite.

## Adăugarea unui capitol

Un capitol nou necesită:

1. definirea sa în catalogul Fennel;
2. asocierea cu un domeniu;
3. crearea fișierului LaTeX corespunzător;
4. definirea eventualelor prerechizite;
5. asocierea cu disciplinele relevante, dacă este cazul.

Conceptual:

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

Fișierul asociat va fi dedus din domeniu și identificator, de exemplu:

```text
content/artificial-intelligence/neural-networks.tex
```

Identificatorul unui capitol trebuie considerat stabil. Nu modificați
identificatorul doar pentru a reflecta o schimbare de titlu.

## Adăugarea unei discipline

Disciplinele universitare sînt definite separat de capitole și de planurile de
învățămînt.

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

Nu creați automat un capitol nou pentru fiecare disciplină.

O disciplină trebuie asociată materialului conceptual deja existent ori de cîte
ori acest lucru este posibil.

Anul, semestrul și numărul de credite nu se declară în `course`. Acestea aparțin
unei versiuni concrete a planului de învățămînt.

## Asocierea unei discipline cu un plan de învățămînt

Poziția unei discipline este declarată în `curriculum`.

De exemplu:

```clojure
(curriculum info-2025
  (programme info)
  (academic-year "2025–2026")
  (years 3)
  (source info-plan-2025)

  (year 1
    (semester 2
      (required
        (course structuri-date
          (credits 5))

        (course algoritmi-fundamentali
          (credits 5))))))
```

Această separare permite păstrarea mai multor versiuni ale planurilor de
învățămînt fără duplicarea disciplinelor.

## Discipline opționale

Disciplinele care formează un grup de alegere trebuie reprezentate explicit ca
grup.

Exemplu:

```clojure
(elective-group software-or-ml
  (choose 1)

  (course software-engineering
    (credits 4))

  (course machine-learning
    (credits 4)))
```

Nu transformați un grup de alegere într-o simplă listă de discipline
independente dacă planul de învățămînt stabilește o relație între ele.

## Discipline facultative

Disciplinele facultative sînt declarate separat:

```clojure
(facultative
  (course foreign-language
    (credits 2)))
```

Ele pot apărea în harta curriculară chiar dacă nu primesc conținut propriu în
compendiu.

## `scope`

Rolul unei discipline în compendiu este descris prin `scope`.

Valorile utilizate sînt:

* `core` — disciplina contribuie direct la conținutul principal;
* `supporting` — disciplina are un rol complementar;
* `curriculum-only` — disciplina este păstrată în harta curriculară, fără
  obligația de a avea conținut propriu.

Exemplu:

```clojure
(course educatie-fizica-1
  "Educație fizică I"
  (scope curriculum-only))
```

## Relațiile dintre discipline și capitole

Sînt utilizate două mecanisme diferite:

```text
covers
assumes
```

### `covers`

`covers` descrie materialul efectiv tratat de o disciplină.

Sînt utilizate două niveluri:

* `primary` — material central;
* `supporting` — material relevant, dar secundar.

Exemplu:

```clojure
(covers
  (supporting graph-algorithms)

  (primary
    combinatorial-optimization
    heuristics
    metaheuristics))
```

### `assumes`

`assumes` descrie materialul pe care disciplina îl presupune deja cunoscut.

Exemplu:

```clojure
(assumes
  graph-theory
  complexity)
```

Nu utilizați `covers` pentru a reprezenta prerechizite.

## Prerechizitele capitolelor

Relația conceptuală dintre capitole este declarată prin `requires`.

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

`requires` și `assumes` au roluri diferite:

```text
requires
    relație conceptuală între capitole

assumes
    material presupus de o disciplină
```

## Actualizarea planurilor de învățămînt

Nu modificați o versiune istorică a unui plan pentru a o face să corespundă unei
versiuni noi.

Dacă structura programului se modifică semnificativ, trebuie adăugat un nou
`curriculum`.

De exemplu:

```clojure
(curriculum info-2023 ...)
(curriculum info-2025 ...)
```

Acest lucru permite păstrarea structurii specifice fiecărei cohorte.

## Sursele informațiilor curriculare

Fiecare plan de învățămînt trebuie, pe cît posibil, asociat unei surse.

Exemplu:

```clojure
(source info-plan-2025
  (title "Plan de învățămînt — Informatică")
  (institution
    "Universitatea „Vasile Alecsandri” din Bacău")
  (academic-year "2025–2026")
  (url "..."))
```

Nu introduceți sau modificați informații curriculare pe baza presupunerilor
atunci cînd o sursă oficială poate fi verificată.

## Stilul conținutului

Materialul trebuie să urmărească, pe cît posibil:

* notație consecventă;
* formulări clare;
* definiții înaintea utilizării conceptelor;
* exemple după introducerea noțiunilor importante;
* referințe către materialul deja tratat în locul duplicării;
* separarea clară dintre materia curriculară și completările suplimentare.

## Cod sursă

Exemplele de cod trebuie, atunci cînd este practic, păstrate în fișiere separate
și incluse în document.

De exemplu:

```text
examples/
└── algorithms/
    └── dijkstra.cpp
```

Astfel, codul prezentat în PDF poate fi verificat și compilat independent.

Codul original al proiectului este disponibil sub licența 0BSD, dacă nu este
specificat altfel.

În fișierele proprii poate fi folosit:

```text
SPDX-License-Identifier: 0BSD
```

## Materiale externe

Nu presupuneți că un material primit de la un student, profesor sau găsit online
poate fi redistribuit liber.

Atunci cînd materialul nu este original:

* indicați sursa;
* păstrați informațiile privind autorul;
* verificați licența sau permisiunea de utilizare;
* nu relicențiați materialul sub licențele proiectului dacă nu aveți dreptul să
  faceți acest lucru.

Materialele originale ale compendiului sînt licențiate conform informațiilor din
`README.md`.

## Bibliografie

Sursele bibliografice trebuie introduse în bibliografia proiectului și citate
din document.

Se preferă sursele primare și documentațiile oficiale atunci cînd acestea
există.

## Teste

Modificările DSL-ului, macro-urilor sau validatorului trebuie însoțite, atunci
cînd este relevant, de teste.

Structura testelor este:

```text
tests/
├── macros/
├── validation/
└── fixtures/
    ├── valid/
    └── invalid/
```

Exemple de cazuri care trebuie testate:

* identificatori duplicați;
* referințe către entități inexistente;
* ani și semestre invalide;
* grupuri de opționale invalide;
* prerechizite inexistente;
* cicluri între prerechizite;
* expandarea corectă a macro-urilor.

## Commit-uri

Repository-ul folosește convenția Conventional Commits.

Exemple:

```text
feat(ai): add neural network introduction
feat(algorithms): add Dijkstra algorithm
feat(curriculum): add 2025 INFO curriculum
fix(calculus): correct derivative example
fix(curriculum): correct elective group
docs: update architecture documentation
refactor: simplify curriculum model
style: adjust chapter typography
build: add Fennel compilation step
test: add curriculum validation cases
```

Mesajele de commit sînt scrise în limba engleză.

## Licențiere

Prin contribuirea de material original la proiect, contribuitorul trebuie să
accepte distribuirea acestuia sub licența aplicabilă tipului de material:

* CC BY 4.0 pentru text, explicații, exerciții și ilustrații;
* 0BSD pentru cod și alte componente software.

Materialele terților nu sînt acoperite automat de aceste licențe.
