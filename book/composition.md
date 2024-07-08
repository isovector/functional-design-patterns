---
id: composition
confidence: 7
tags: []
bigger:
- philosophy
smaller:
- composition-of-correctness
- composition-of-functions
- composition-of-implementations
- composition-of-understanding
see-also: []
name: "Composition"
teaser: ""
---


...in the [philosophy]() of functional programming, one pattern stands above
all---the means by which we create something complex out of simpler components.

---

**Much like a beautiful piece of music, software too is composed---according to
a rigid set of rules and constraints, which often are "felt" more than they are
understood.**


Composition is the idea that we can combine smaller components into larger
systems and "get away with it." That is to say, that the larger system preserves
some desired behavior that each of its components originally possessed.
Composition is the most powerful tool in all formalized engineering practices
and scientific disciplines, as it's what allows us to reason about small pieces
but build systems too large for any one human to understand.

The notion of composition is a slippery one, not at all aided by the many subtle
shades of overloaded meaning it carries. In programming, we can compose
solutions to subproblems into larger solutions (as in [dynamic-programming]()).
Familiarly, algorithms can be composed sequentially (do this, and then do that).
But they can also be composed "inside-out,"  when an algorithm isn't fully
specified in its behavior---for example, discussions of hash map implementations
often leaves unsaid what should happen when two keys produce the same hash.
Values at runtime are often built up of smaller values, in a dizzying number of
possibilities.

Outside the discipline of programming, it is composition that allows physicists
to understand magnetic fields by integrating the interactions of trillions of
simple point-charges. It is composition by which books are made up of chapters,
comprised of paragraphs, consisting of sentences, themselves built out of words,
which are nothing but sequences of individual letters.



---

...smaller context...
