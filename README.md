# Compendiu de informatică - UVABc

Acest repository conține un compendiu construit în jurul programelor de
Informatică și Informatică Aplicată în Științe și Tehnologie (IAST) de la
Universitatea „Vasile Alecsandri” din Bacău.

Compendiul este un proiect independent; nu este un suport de curs oficial și nu
este afiliat Universității „Vasile Alecsandri” din Bacău.

Scopul nu este să copiem planurile de învățămînt sau fișele disciplinelor, ci să
adunăm materia într-o carte coerentă. Universitatea organizează materia în
discipline, ani și semestre; compendiul o organizează după idei, noțiuni și
legăturile dintre ele.

De aici apar cele două perspective ale proiectului:

```text
cartea
domain → topic → topic

universitatea
programme → curriculum → course
                         │
                         └── topics → topic
```

Un `topic` nu este același lucru cu un `course`. „Sisteme de operare” și „Rețele
neuronale. Aplicații”, de exemplu, sînt discipline din planurile de învățămînt.
Conținuturile acestor discipline pot fi descompuse în topicuri mai mici, pe baza
fișelor disciplinelor. O disciplină poate acoperi mai multe topicuri, iar
același topic poate apărea în mai multe discipline.

## Clonare

Repository-ul conține linkuri simbolice, folosite în special pentru
[`sources/uvabc/latest`](sources/uvabc/latest).

Pe Linux și macOS nu este necesară, în mod normal, nicio configurare
suplimentară. Pe Windows este recomandată activarea **Developer Mode** și a
suportului Git pentru linkuri simbolice înainte de clonare:

```powershell
git config --global core.symlinks true
```

Repository-ul poate fi apoi clonat în mod obișnuit.

Dacă linkurile simbolice nu pot fi create, restul repository-ului rămîne
utilizabil, dar `sources/uvabc/latest` poate fi extras ca fișier obișnuit în
locul unui link simbolic.

Detalii despre organizarea arhivei se găsesc în
[`sources/uvabc/README.md`](sources/uvabc/README.md).

## Sursele universitare

Datele despre programele INFO și IAST provin din documentele publicate de
Universitatea „Vasile Alecsandri” din Bacău, în principal planuri de învățămînt,
structuri anuale și fișe ale disciplinelor.

Copii ale documentelor folosite de proiect sînt arhivate în
[`sources/uvabc/`](sources/uvabc/), organizate după anul universitar.
[`sources/uvabc/latest`](sources/uvabc/latest) indică spre cel mai recent set
arhivat în repository; nu înseamnă neapărat anul universitar aflat în curs.

Documentele nu descriu întotdeauna aceeași cohortă. Un plan valabil începînd cu
anul I al unui anumit an universitar nu trebuie folosit automat pentru a descrie
anii superiori aflați deja în desfășurare.

Detaliile despre surse, cohorte și documentele folosite se găsesc în
[`docs/SOURCES.md`](docs/SOURCES.md).

## Ce păstrăm

Modelul poate păstra mai multe informații decît ajung efectiv în carte: credite,
ore, coduri, regimul disciplinei, profesori, conținuturile fișei, bibliografia,
rezultatele învățării și alte date publicate de UVABc.

Asta nu înseamnă că fiecare asemenea cîmp trebuie să primească un subsistem
propriu. Datele administrative pe care doar vrem să le păstrăm pot rămîne
structuri simple și opționale.

Partea importantă pentru compendiu este relația dintre:

```text
course
  ↕
topic
```

și conținutul din fișele disciplinelor, care ne ajută să stabilim ce merită
acoperit în carte.

## Fennel și LuaLaTeX

Arhitectura țintă folosește Fennel pentru date, validare și generare, iar
LuaLaTeX pentru carte.

Fluxul urmărit este:

```text
date Fennel
    ↓
normalizare
    ↓
validare
    ↓
indexuri și interogări
    ↓
TeX generat
    ↓
LuaLaTeX
    ↓
PDF
```

Codul Fennel este împărțit intenționat în module specializate. Nu urmărim să
avem cît mai puține fișiere; urmărim ca fiecare fișier să aibă o
responsabilitate clară.

## Ortografie

Textul original al proiectului folosește `î` și în interiorul cuvintelor.
Denumirile oficiale și fragmentele citate din surse pot fi păstrate exact în
forma în care apar acolo.

## Licență

Textul original al proiectului este distribuit sub CC BY 4.0. Codul, macro-urile
LaTeX, sursele Fennel și scripturile sînt distribuite sub 0BSD, dacă nu este
precizat altfel.

Documentele externe arhivate în [`sources/`](sources/) nu reprezintă conținut
original al proiectului și nu sînt acoperite de licențele CC BY 4.0 sau 0BSD ale
compendiului.

Pentru contribuții, vedeți [`CONTRIBUTING.md`](CONTRIBUTING.md).
