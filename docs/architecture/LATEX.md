# Integrarea cu Lua$\LaTeX$

Acest document descrie integrarea țintă. Build-ul actual verifică doar lanțul
minimal Fennel → Lua → Lua$\LaTeX$; generarea semantică de mai jos urmează să
fie implementată.

Fennel produce structură și date; Lua$\LaTeX$ produce documentul.

```text
Fennel
  ↓
TeX semantic generat
  ↓
LuaLaTeX
  ↓
PDF
```

Rendererul nu trebuie să decidă fonturi, culori sau spațieri.

De exemplu:

```latex
\CompendiumDomain{systems}{Arhitectura calculatoarelor, sisteme și rețele}
\CompendiumTopic{operating-systems}{Sisteme de operare}
```

sau:

```latex
\CourseHeader{operating-systems}{Sisteme de operare}
\CoursePlacement{INFO}{Anul III}{Semestrul V}
\CourseCredits{4}
```

Macro-urile $\LaTeX$ decid prezentarea.

## Pagina disciplinei

O prezentare normală poate arăta titlul, anul, semestrul, creditele, profesorii,
un rezumat și topicurile principale/conexe.

O vedere mai detaliată poate adăuga codul, orele și alte date din fișă.

Ambele folosesc același model.

## Curriculum

Se pot genera separat curriculumurile INFO și IAST, inclusiv grupurile de
opționale și selecțiile consemnate în sursele folosite.

Datele mai administrative din `profile`, `statistics` sau `details` nu trebuie
randate doar pentru că există în model.

## `main.tex`

Fișierul principal poate rămîne simplu:

```latex
\begin{document}

\frontmatter
\tableofcontents

\mainmatter
\input{.build/generated/book.tex}

\appendix
\input{.build/generated/curriculum-info.tex}
\input{.build/generated/curriculum-iast.tex}

\end{document}
```
