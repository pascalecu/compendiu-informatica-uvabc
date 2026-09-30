# Arhitectura proiectului

Acest document descrie modelul țintă al proiectului. Implementarea actuală este
încă minimală și va introduce aceste componente incremental.

Proiectul păstrează două structuri care se suprapun.

Prima descrie cartea:

```text
domain
└── topic
    ├── topic
    └── requires → topic
```

A doua descrie universitatea:

```text
programme
└── curriculum
    └── year
        └── semester
            ├── course-entry → course
            └── elective-group → course[]

course
└── syllabus
    ├── teacher
    └── source
```

Puntea dintre ele este `course.topics`.

## Entități

Au identitate proprie și intră în registry:

```text
domain
topic
programme
course
curriculum
syllabus
teacher
source
```

`course-entry`, `elective-group` și `finalization` există numai în interiorul
unui curriculum.

## Structura cărții

`domain` grupează topicurile mari, iar `topic` poate avea copii.

```clojure
(domain systems
  {:title "Arhitectura calculatoarelor, sisteme și rețele"
   :topics
   [computer-architecture
    operating-systems
    networks]})
```

```clojure
(topic operating-systems
  {:title "Sisteme de operare"
   :file "content/systems/operating-systems.tex"
   :children
   [processes
    threads
    synchronization
    memory-management
    filesystems]
   :requires [computer-architecture]})
```

Listele sînt ordonate și stabilesc ordinea din carte.

## Discipline și topicuri

`course` reprezintă disciplina universitară, nu locul ei într-un plan.

```clojure
(course neural-networks-applications
  {:title "Rețele neuronale. Aplicații"
   :topics
   {:primary
    [neural-networks
     backpropagation
     recurrent-neural-networks]

    :secondary
    [optimization
     fuzzy-systems]}})
```

`primary` și `secondary` sînt ale compendiului. Ele nu apar ca atare în fișele
UVABc.

Totuși, pot fi derivate parțial din surse. Conținuturile din fișă sînt cel mai
bun punct de plecare. Obiectivele și rezultatele învățării pot confirma
importanța unui subiect, iar precondițiile pot sugera topicuri conexe.

Generatorul sau un script de analiză poate produce o propunere, dar maparea
finală rămîne editorială.

## Curriculum

Curriculumul folosit de compendiu este o vedere canonică a programului, nu copia
unui singur PDF.

În anii în care cohorte diferite coexistă, fiecare an poate avea propria sursă:

```clojure
(curriculum info
  {:programme info
   :years
   {1 {:source info-structure-y1-2025 ...}
    2 {:source info-structure-y2-2025 ...}
    3 {:source info-structure-y3-2025 ...}}})
```

`course-entry` păstrează datele apariției concrete a disciplinei:

```clojure
(course-entry operating-systems
  {:code "UB03I501F"
   :category {:value :fundamental :reported "DF"}
   :requirement {:value :required :reported "DOB"}
   :credits 4
   :assessment {:value :exam :reported "E"}
   :hours {...}})
```

Forma `reported` este utilă fiindcă documentele UVABc nu folosesc întotdeauna
aceleași abrevieri.

## Opționale și finalizare

Un `elective-group` păstrează variantele disponibile și, dacă este cunoscută,
varianta aleasă pentru anul universitar descris de sursă.

`finalization` este pentru probele de după ultimul semestru. Dacă elaborarea
lucrării apare ca activitate în semestru, ea rămîne un `course-entry`.

## Fișe

`syllabus` reprezintă o fișă concretă dintr-un an concret.

Fișa poate conține profesori, ore, prerechizite, obiective, conținuturi,
bibliografie, evaluare și rezultate ale învățării. Nu este nevoie ca toate
aceste cîmpuri să fie obligatorii și nici să fie modelate la aceeași
granularitate.

Pentru compendiu, cele mai valoroase părți sînt de obicei:

```text
contents
prerequisites
bibliography
teachers
reported
```

Restul poate fi păstrat în forme simple atunci cînd este util.

## Profesori

Profesorii au un model mic și derivabil:

```clojure
(teacher elena-nechita
  {:name "Elena Nechita"
   :position :professor
   :doctorate :doctor})
```

Din aceste cîmpuri putem genera `Prof. univ. dr.`.

Nu încercăm să construim o bază completă de personal universitar.

## Surse

`source` descrie documentele din care provin datele universitare: planuri,
structuri de an, fișe și pagini de personal.

Bibliografia științifică a compendiului rămîne în BibLaTeX.

## Principiul general

Modelăm în profunzime ceea ce folosește compendiul. Restul datelor pot fi
păstrate fără a construi în jurul lor subsisteme pe care nu le folosim încă.

Arhitectura Fennel poate rămîne însă împărțită în module specializate;
modularitatea codului și complexitatea modelului sînt două lucruri diferite.
