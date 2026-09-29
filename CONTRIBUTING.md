# Contribuții

Contribuțiile pot adăuga fie conținut academic, fie date despre programele INFO
și IAST.

Înainte de a modifica modelul, citiți
[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md). Pentru date preluate din
documentele UVABc, consultați și [`docs/SOURCES.md`](docs/SOURCES.md).

## Conținut academic

Compendiul se organizează după subiecte, nu după lista disciplinelor.

Dacă aceeași noțiune apare în mai multe discipline, ea se explică o singură dată
și se leagă de toate disciplinele relevante.

```clojure
(topic recurrent-neural-networks
  {:title "Rețele neuronale recurente"
   :file "content/artificial-intelligence/recurrent-neural-networks.tex"
   :requires [neural-networks]})
```

`requires` exprimă o dependență conceptuală între topicuri. Precondițiile
dintr-o fișă de disciplină pot ajuta la stabilirea acestor relații, dar nu se
copiază automat.

Ordinea cărții este definită explicit prin `domain.topics` și `topic.children`.

## Discipline

`course` reprezintă disciplina ca identitate. Anul, semestrul, creditele și
celelalte date ale unei apariții concrete stau în `course-entry`.

```clojure
(course operating-systems
  {:title "Sisteme de operare"
   :topics
   {:primary
    [operating-systems processes filesystems]

    :secondary
    [computer-architecture]}})
```

`primary` și `secondary` sînt clasificări editoriale ale compendiului, nu
cîmpuri publicate de UVABc.

Ele pot fi propuse pornind de la fișa disciplinei. Temele tratate direct și
suficient de amplu sînt candidați buni pentru `primary`; prerechizitele,
noțiunile auxiliare și legăturile cu alte domenii pot ajunge în `secondary`.

Conținuturile fișei sînt sursa principală pentru această mapare. Obiectivele,
precondițiile și rezultatele învățării pot fi folosite ca indicii suplimentare.

O sugestie generată automat trebuie verificată înainte de a fi introdusă în
datele canonice.

## Curriculum

Fiecare program are un curriculum canonic folosit de compendiu, dar acesta poate
fi construit din mai multe documente.

Nu completați datele unei cohorte cu valori luate din planul altei cohorte doar
pentru a umple un cîmp lipsă.

`course-entry`, `elective-group` și `finalization` fac parte dintr-un curriculum
și nu au registre globale proprii.

## Opționale

Un `elective-group` păstrează variantele disponibile și, dacă structura anuală
publică această informație, varianta aleasă.

```clojure
(elective-group
  {:choose 1
   :options
   [software-testing
    cloud-computing
    special-web-engineering]
   :selected software-testing})
```

`selected` nu înlocuiește `options`. Lista variantelor și alegerea pentru anul
universitar respectiv pot proveni din surse diferite.

## Fișe de disciplină

Un `syllabus` reprezintă o fișă concretă a unei discipline într-un anumit an
universitar.

Valorile care repetă informații din curriculum pot fi păstrate sub `reported`
atunci cînd vrem să le comparăm cu cele din plan:

```clojure
:reported
{:credits 4
 :requirement "DI"
 :assessment "E"}
```

Forma raportată de sursă se păstrează chiar dacă proiectul folosește intern o
valoare normalizată.

Nu este nevoie să modelăm în profunzime fiecare formulare administrativă.
Textele lungi pot rămîne texte, iar structurile mai detaliate se introduc numai
acolo unde sînt utile compendiului.

## Profesori

Profesorii se declară separat:

```clojure
(teacher gloria-cerasela-crisan
  {:name "Gloria-Cerasela Crișan"
   :position :associate-professor
   :doctorate :doctor
   :habilitation true})
```

Titulatura poate fi generată din aceste cîmpuri. Dacă este important să păstrăm
exact titulatura publicată într-o anumită fișă, aceasta poate avea local un
`reported-title`.

Profesorii se leagă de fișele disciplinelor, nu direct de `course`, deoarece
titularii se pot schimba de la un an universitar la altul.

## Build și validare

Modificările datelor trebuie să treacă validarea, iar schimbările care afectează
randarea trebuie verificate și prin build-ul documentului.

## Commit-uri

Folosim Conventional Commits, cu mesaje în engleză:

```text
feat(curriculum): add current INFO year two
feat(syllabus): add operating systems syllabus
feat(teachers): add INFO teaching staff
fix(curriculum): correct IAST elective selection
docs: simplify architecture documentation
```
