# Structura conceptuală

`domain` și `topic` descriu cartea.

Un domeniu grupează topicurile mari:

```clojure
(domain artificial-intelligence
  {:title "Inteligență artificială și sisteme inteligente"
   :topics
   [artificial-intelligence
    machine-learning
    neural-networks]})
```

Un topic poate avea copii:

```clojure
(topic neural-networks
  {:title "Rețele neuronale"
   :file "content/artificial-intelligence/neural-networks.tex"
   :children
   [perceptrons
    backpropagation
    recurrent-neural-networks]})
```

Listele `domain.topics` și `topic.children` sînt ordonate și stabilesc ordinea
din carte.

## Prerechizite

`topic.requires` exprimă o dependență conceptuală:

```clojure
(topic recurrent-neural-networks
  {:title "Rețele neuronale recurente"
   :requires [neural-networks]})
```

Precondițiile dintr-o fișă pot ajuta la alegerea acestor legături, dar nu sînt
copiate automat.

## Topicuri principale și conexe

Disciplinele pot lega topicurile astfel:

```clojure
:topics
{:primary
 [neural-networks
  backpropagation
  recurrent-neural-networks]

 :secondary
 [optimization
  fuzzy-systems]}
```

Distincția este editorială.

Poate fi sugerată din fișa disciplinei. O regulă practică bună este:

- temele predate direct și cărora li se acordă timp clar → `primary`;
- noțiunile auxiliare, prerechizitele și legăturile laterale → `secondary`.

Obiectivele și rezultatele învățării pot fi folosite ca semnale suplimentare.

Nu este necesar ca fiecare rînd din fișă să devină topic. O propunere automată
trebuie verificată manual înainte de a intra în datele canonice.

## Conținut LaTeX

Fennel păstrează structura și metadatele; textul lung rămîne în `content/`.

```clojure
:summary "Descriere scurtă."
:file "content/systems/operating-systems.tex"
```

ID-urile rămîn stabile chiar dacă titlul afișat se schimbă.
