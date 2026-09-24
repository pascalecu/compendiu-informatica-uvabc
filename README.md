# Compendiu de informatică - UVABc

Compendiu de studiu în curs de dezvoltare, construit pornind de la disciplinele
programelor de Informatică - licență și Informatică Aplicată în Știință și
Tehnologie (IAST) - master de la Universitatea „Vasile Alecsandri” din Bacău.

Scopul proiectului este reunirea într-un singur document a noțiunilor studiate
în cadrul celor două programe și organizarea lor într-o structură coerentă pe
domenii ale informaticii.

Materia este completată, acolo unde este util, cu explicații suplimentare,
demonstrații, exemple, exerciții, algoritmi, implementări, observații proprii și
subiecte care reprezintă o continuare firească a celor întîlnite în programa
universitară.

Compendiul este un material personal de studiu și referință. Nu reprezintă un
suport de curs oficial și nu este afiliat oficial Universității „Vasile
Alecsandri” din Bacău.

> [!NOTE]
>
> Compendiul folosește în textul original grafia cu „î” și în interiorul
> cuvintelor, neadoptînd reintroducerea generală a lui „â” stabilită prin
> reforma ortografică din 1993.
>
> În celelalte privințe, sînt urmate modificările și recomandările ortografice
> ulterioare, în măsura în care acestea nu depind de această convenție.
>
> Denumirile oficiale, citatele, titlurile lucrărilor și alte fragmente
> reproduse din surse externe își păstrează grafia originală.

## Organizare

Compendiul nu reproduce împărțirea administrativă a materiei pe ani și semestre.
Conținutul este organizat pe domenii, iar disciplinele universitare sînt
asociate capitolelor corespunzătoare.

Structura urmărită este, în linii mari:

```text
Compendiu de informatică
├── Fundamente matematice și modelare
├── Fundamentele programării și limbaje
├── Algoritmi și teoria calculului
├── Date și sisteme informaționale
├── Sisteme de calcul și comunicații
├── Inginerie software și aplicații
├── Inteligență artificială
├── Optimizare și cercetări operaționale
├── Geometrie, grafică și tehnologii imersive
├── Securitate informatică
├── Cercetare și practică academică
├── Didactica informaticii și științele educației
└── Competențe profesionale complementare
```

Această organizare permite tratarea continuă a unui subiect chiar atunci cînd
acesta este distribuit între mai multe discipline sau este reluat la niveluri
diferite în cadrul licenței și masterului.

De exemplu:

```text
Structuri de date
        ↓
Algoritmi fundamentali
        ↓
Grafuri
        ↓
Cercetări operaționale
        ↓
Optimizare combinatorie
        ↓
Eficiență și optimizare
```

sau:

```text
Probabilități și statistică
            ↓
Inteligență artificială
            ↓
Învățare automată
            ↓
Rețele neuronale
            ↓
Aplicații ale inteligenței artificiale
```

## Legătura cu programa universitară

Legătura cu planurile de învățămînt este păstrată explicit.

O disciplină poate corespunde mai multor capitole ale compendiului, iar același
capitol poate fi relevant pentru mai multe discipline.

De exemplu, materialul despre rețele neuronale poate fi asociat cu discipline
precum:

* Informatică - Inteligență artificială;
* Informatică - Învățare automată;
* IAST - Rețele neuronale. Aplicații;
* IAST - Aplicații ale Inteligenței Artificiale.

Documentul va conține și o hartă curriculară prin care materialul poate fi
parcurs după structura programelor universitare:

```text
Informatică - Licență
├── Anul I
├── Anul II
└── Anul III

IAST - Master
├── Anul I
└── Anul II
```

Disciplinele din această hartă vor trimite către capitolele relevante ale
compendiului.

Astfel, documentul poate fi folosit atît ca lucrare de referință organizată pe
domenii, cît și pentru urmărirea materiei unei anumite discipline.

## Conținut

În funcție de subiect, compendiul poate include:

* definiții și rezultate teoretice;
* demonstrații și deducții;
* explicații și observații suplimentare;
* exemple rezolvate;
* algoritmi și pseudocod;
* implementări și fragmente de cod;
* exerciții și probleme;
* materiale și observații de laborator;
* recapitulări ale prerechizitelor;
* legături între concepte și discipline;
* trimiteri către alte capitole;
* bibliografie și resurse pentru aprofundare.

Conținutul nu este limitat strict la programa universitară. Pot fi incluse și
subiecte suplimentare atunci cînd acestea contribuie la înțelegerea materiei,
oferă context sau reprezintă o continuare naturală a acesteia.

## Tehnologii

Documentul este redactat în LaTeX și compilat cu LuaLaTeX.

Metadatele curriculare și o parte din generarea structurii documentului sînt
gestionate folosind Fennel, compilat în Lua pentru integrarea cu LuaLaTeX.

Detaliile privind arhitectura proiectului, modelul curricular și DSL-ul Fennel
sînt descrise în [`ARCHITECTURE.md`](ARCHITECTURE.md).

## Compilare

Procesul de build va include compilarea surselor Fennel și generarea
documentului cu LuaLaTeX.

Instrucțiunile exacte de compilare vor fi adăugate odată cu implementarea
infrastructurii de build.

## Surse

Structura curriculară are la bază planurile de învățămînt și fișele
disciplinelor publicate de Universitatea „Vasile Alecsandri” din Bacău.

Conținutul poate fi completat folosind:

* propriile notițe;
* materiale de curs și laborator la care am avut acces în timpul studiilor;
* materiale distribuite în perioada cursurilor desfășurate online;
* cărți și articole de specialitate;
* documentații tehnice;
* alte surse bibliografice relevante;
* exemple, explicații și exerciții proprii.

Sursele externe sînt indicate și citate acolo unde este necesar.

Materialele provenite din surse externe nu sînt relicențiate prin acest proiect
și rămîn supuse drepturilor de autor, licențelor și condițiilor de utilizare ale
surselor originale.

## Contribuții

Sînt binevenite corecturi, completări, exemple, surse și informații actualizate
despre discipline.

Instrucțiunile privind contribuțiile sînt disponibile în
[`CONTRIBUTING.md`](CONTRIBUTING.md).

## Statut

Proiectul se află într-un stadiu incipient.

În prezent, repository-ul conține documentația inițială și fișierele de licență.
Structura LaTeX, infrastructura Fennel și conținutul propriu-zis vor fi adăugate
treptat.

Organizarea proiectului se poate modifica pe măsură ce materialul este
dezvoltat.

## Licență

Proiectul folosește două licențe, în funcție de natura materialului.

Conținutul original al compendiului, inclusiv textul, explicațiile, exercițiile
și ilustrațiile proprii, este disponibil sub [Creative Commons Attribution 4.0
International (CC BY 4.0)](./LICENSE-CC-BY), dacă nu este specificat altfel.

Codul sursă original, inclusiv exemplele de programare, macro-urile LaTeX,
sursele Fennel, codul Lua, scripturile și celelalte componente software, este
disponibil sub [BSD Zero Clause License (0BSD)](./LICENSE-0BSD), dacă nu este
specificat altfel.

Materialele și fragmentele de cod provenite din surse externe rămîn supuse
licențelor și drepturilor autorilor lor originali.

## Contact

Dacă sînteți student și doriți să contribuiți cu materiale de curs sau de
laborator ori să mă ajutați să mențin compendiul la zi cu ceea ce se predă în
prezent, mă puteți contacta folosind următoarele identificatoare codificate în
[ASCII85](https://cryptii.com/pipes/ascii85-decoding/):

* Discord: `5]C.Q@ps1b@s%`
* E-mail: `F*(i,ARfj@1dG\j@;0O1@rH2`

Codificarea este folosită doar pentru a evita colectarea automată a adreselor de
către scrapere simple.

Sînt binevenite și materialele oferite direct de cadre didactice.
