---
title: "Three Principles of Software Architecture"
teaser: "Let these principles flow throughout all of your software."
confidence: 7
bigger: []
smaller:
- correctness
- flexibility
- empathy
see-also:
- denotations
---


What is it that differentiates good software from bad? Given two possible
designs, which should we choose? While we do not yet have an excellent *metric*
to help answer these questions, any worthwhile piece of software must adhere to
three principles, namely *correctness,* *flexibility,* and *empathy.*

[smaller:Correctness](correctness) is the fundamental property. A correct
program is not only free of bugs, but also guides future maintainers and
integrators with a consistent mental model. The importance of this mental model
cannot be overstated, as correctness can be defined by the coherence between an
implementation and its mental model (see also:
[see-also:denotations](denotations).)

[smaller:Flexibility](flexibility) is the ability of a system to evolve with
changing requirements and specifications. Flexibility is what we appeal to when
project constraints get in the way of correctness; if we can't afford to get the
right answer today, we should at least leave the possibility open to correct
things in the future.

[smaller:Empathy](empathy) is the recognition that while it is the machine that
executes programs, the discipline of programming is a purely human endeavor.
Empathy is the principle that things ought to be to be written down, that simple
code is better than more complicated code, and that tracing down bugs is a
devastating waste of human capital.

Each principle is discussed much more thoroughly in its own pattern.

In most respects, these are all different shadows of the same abstract idea; we
know this since rarely are the three principles in tension. Improving a piece of
software along one axis often improves it along another (or both.) However,
should you need to trade one for another, prefer correctness over the other two.
When constrained resources prevent you from being correct, opt instead for
the flexibility to improve things in the future. When deciding between two
otherwise-equal technical decisions, choose whichever maximizes empathy.
