---
id: philosophy
confidence: 7
tags: []
bigger: []
smaller:
- applications-want-to-be-libraries
- code-reifies-understanding
- composition
- if-it-compiles-it-works
- open-world-assumption
- purity
- understanding-before-implementation
- what-not-how
see-also: []
name: "The Philosophy of Functional Programming"
teaser: ""
---

**Programs are made up of smaller programs.**

This is the fundamental tenet of the functional programming. Don't be deceived
by the terseness of this slogan---it packs a great deal of depth in its seven
words.

We can understand this in two ways. One way of parsing the importance is that
programs *are made up of* smaller programs. How does one build a large program?
By combining smaller programs together. Of course, this only gives rise to
further questions. In what ways can programs be combined? Is combining program
`A` with program `B` the same as combining B with A? Can any two programs be
combined, or are there limitations? If programs `A` and `B` both have some
property `p`, is it guaranteed that their combination will also satisfy `p`?

Already this suggests a very different way of thinking about programming than
you are likely familiar with. Under the functional lens, programs become
objects to be manipulated---as tangible as the booleans and unsigned integers,
but significantly more expressive.

Another parsing of our slogan is that programs are made up of *smaller
programs.* This gestures towards other intriguing questions. Is there a smallest
program? Are the smaller programs individually meaningful? Is the larger program
merely the sum of its parts? Can we arbitrarily divide a program, or must it
split only along pre-existing "fracture lines?"

These are the sorts of questions answered in this book. But these questions are
not merely academic trivia; they have profound consequences for the engineer
attempting to build real-world software systems. Intuition for writing software
can get one only so far; inevitably you will encounter a sufficiently-difficult
problem that defies all intuitive means of tackling it. In these situations,
knowing how to carve programs at their joints will be immeasurably helpful.

---

Software is a means to an end ([what-not-how](),
[code-reifies-understanding]()). Knowing what problem you're tackling, and being
able to identify a solution when you see one, must come
first---[understanding-before-implementation](). Programs are built out of
smaller programs ([composition]()) and, importantly,
[applications-want-to-be-libraries](). These principles are significantly easier
to follow when our code is pure ([purity]()) and under an open-world assumption
([open-world-assumption]()). Composition of meaning means that often
[if-it-compiles-it-works]().

