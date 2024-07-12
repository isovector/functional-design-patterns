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
comprised of paragraphs, consisting of sentences, themselves built out of
words. The meaning of the book arises through the interaction of the meaning of
the words. Perhaps the metaphor is a bit loose, in that surely some of the
meaning of a book comes from its historical context, but let us not dwell too
much on this point.

Composition is the basis of reductionism, which to date is the most successful
principle ever devised by humans. It is reductionism by which we make sense of
the world in the small, and extrapolate that understanding to the large. It is
the basis of philosophy, mathematics, logic, and science, themselves all
exceptionally successful human endeavors.

One wonders why exactly philosophy, mathematics, logic, and science have been
so "unreasonably effective" in helping us understand the world we live in. To
me, the only coherent answer is that these fields are all compositional. Small
pieces can be understood and glued together to form bigger pictures, which
themselves can be understood only in terms of their constituent parts. The
human brain, as remarkable as it is, isn't a particularly capable device. They
run at roughly 100Hz, and have enough "RAM" to keep only seven things in mind
simultaneously. These are extremely tight constraints, especially when tackling
big systems.

Our only recourse, therefore, is to layer abstractions upon one another,
minding our way to the heavens. This is the basis and origin of composition.
And if we are to have any chance at all of this towering process working, we
had better make sure that each layer is robust and sturdy.

All of this is to say that compositional systems work not because they are
fundamentally better, but because they are the only systems we humans have
a reasonable chance of understanding. Composition isn't sufficient for success,
but make no mistake---it certainly is necessary.

*Therefore:*

**Seek composition in all of your cognitive endeavors---especially software, of
which we will place special emphasis in this book. Build composable designs.
Furthermore, keep an extremely wary eye of any non-compositional systems, which
will always grow too complicated to be understood, and which therefore will
always contain bugs and disorganized designs.**

---

Use [composition-of-understanding]() to ensure your problem domain is
comprehensible. Model the problem via [types](), and give the implementation in
terms of [composition-of-implementations](). [composition-of-functions]() will
play a large role in this. Ensure that each piece of the implementation does
its job well, and rely on [composition-of-correctness]() to scale the system.
