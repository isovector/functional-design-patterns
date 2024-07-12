---
id: modeling-with-types
confidence: 7
tags: []
bigger:
- composition
- tools
- totality
smaller:
- newtypes-over-aliases
- smart-constructors
- types
- combinator-libraries
see-also: []
name: "Modeling with Types"
teaser: ""
---


...suppose that you have already a rudimentary and informal understanding of
the problem domain. Now, extract exactness by hashing out the objects of study
and the interrelations between them.

---

**Types define the universe of discourse, and functions between them articulate
the meaningful things we can say about them. Types are the most successful
organizing technique for taming complexity in software.**

When building a software library (which is to say, when building any
software---[applications-want-to-be-libraries]()), the most salient question is
"what is this library *about*?" In answering this question, you will come up
with a series of domain objects that are worth being able to discuss in
software.

For example, an audio processing library might require concepts of audio files,
waveforms, frequencies, pitches, and time. A database library might have
data stores, schemas, rows, columns, fields, transactions, and so on. A UI
toolkit might have windows, scrollbars, text entry elements, cursors, and
buttons.

Even when working in an untyped language, the types exist behind the scenes.

---

...smaller context...
