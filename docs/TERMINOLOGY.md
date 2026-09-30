# Terminologie

Codul și documentația au roluri diferite.

Identificatorii DSL-ului sînt în engleză pentru consistență, dar textul
explicativ se scrie în romînă firească. Nu se traduc mecanic numele interne
atunci cînd rezultatul sună artificial.

## Termeni principali

| În cod | În proză |
| --- | --- |
| `domain` | domeniu |
| `topic` | subiect, noțiune, unitate conceptuală |
| `programme` | program de studiu |
| `course` | disciplină |
| `curriculum` | curriculum; structura programului |
| `course-entry` | apariția/poziția disciplinei în curriculum |
| `elective-group` | grup de discipline opționale; grup de alegere |
| `syllabus` | fișa disciplinei |
| `source` | sursă; document-sursă |
| `requires` | prerechizite conceptuale; depinde de |
| `topics` | subiectele asociate disciplinei |

Numele intern poate fi menționat între backticks atunci cînd documentația
explică modelul.

## Formulări de evitat

Nu se folosesc în mod normal formulări precum:

```text
identitatea universitară
oferta disciplinei
catalogul anului universitar
acoperirea disciplinei
poziția curriculară
afirmația documentară
```

dacă există o formulare romînească mai simplă.

Se preferă, după context:

```text
disciplina
disciplina apare în semestrul...
structura anului/programului
subiectele tratate de disciplină
locul disciplinei în curriculum
informația din sursă
```

## `curriculum`

`curriculum` este folosit ca nume intern și poate fi folosit și în proză cînd
contextul este tehnic.

În texte mai generale pot fi preferate:

- structura programului;
- structura curriculară;
- disciplinele programului;
- planul folosit ca bază pentru compendiu.

Nu se spune „catalog” doar pentru că o versiune anterioară a modelului avea
entitatea `catalogue`.

## `course-entry`

`course-entry` este un termen tehnic.

În explicații se spune, de regulă:

- disciplina în curriculum;
- apariția disciplinei în semestru;
- intrarea disciplinei, dacă se discută chiar structura de date.

„Poziție curriculară” poate fi folosit numai dacă formularea este realmente
utilă în context, nu ca traducere implicită.

## `topics`

Legătura dintre `course` și `topic` este o alegere editorială a compendiului.

În proză se poate spune:

- disciplina tratează aceste subiecte;
- disciplina este asociată cu aceste subiecte;
- aceste noțiuni sînt relevante pentru disciplină.

Nu este necesar un substantiv special precum „acoperire”.

## Terminologia oficială

Atunci cînd este reprodusă terminologia unui document oficial, se păstrează
formularea documentului.

De exemplu:

- plan de învățămînt;
- fișa disciplinei;
- disciplină obligatorie;
- disciplină opțională;
- disciplină facultativă;
- formă de verificare;
- număr de credite;
- ore de curs, seminar, laborator, proiect sau practică.

Abrevierile oficiale precum `DF`, `DS`, `DC`, `DOB`, `DOP` sau `DFA` pot fi
păstrate atunci cînd provin din sursă.

## Ortografie

Textul original al proiectului folosește „î” și în interiorul cuvintelor.

Titlurile oficiale, citatele și fragmentele reproduse din surse externe își
păstrează însă grafia originală.
