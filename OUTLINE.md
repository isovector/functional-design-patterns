- Why functional programming matters? It's math.
- Why does math work?
    - It mirrors our mind.
    - Even if you don't know all the words that mathematicians use, you will be
      surprised if the problem domain you're working in isn't associative.
    - The point is not therefore that FP is better because it's more
      mathematical, but because reasoning about it is much more similar to how
      our minds work.
    - That is not to say that this is actually how our brains are IMPLEMENTED.
- Feasibility
    - Do you have the resources/know-how/budget/whatever to get this feature
        done? If yes, great.
    - If no, you will need to get better at politics or at corner cutting.
      Cut those corners which effect the following principles the least.
- The Principles
    - Correctness
        - Does the program do what it is supposed to? Do you know what it is
          supposed to do? How can it do that if you don't know what it is
          supposed to do?
        - In general, correctness means having no bugs WRT a specification. If
          you don't have a specification you can't possibly be correct.
        - Correctness also applies to the mental model that people build about
          your software. If the implementation doesn't correspond to the mental
          model, it is also not correct.
            - Because people don't code against your system, they code against
              their mental model of your system.
            - This means you can't "document away" bugs. Weird edge cases are
              bugs.
        - Encode invariants in the type system. Make illegal states
          unrepresentable.
    - Flexibility
        - The specification will always change. The goals will always move.
        - How do you ensure what you've built is capable of handling those
          moving goals?
        - When you need to cut a corner, how do you do it in such a way that you
          don't paint yourself into a corner? How do you make sure the cut
          corner wasn't important? How do you fill it in later?
        - DRY. The more cruft you have the less flexible you are to change.
        - Use the right abstractions/common vocabularies, such that changes are
          as minor as possible.
    - Empathy
        - Document. Not just for your coworkers, but for yourself in the future.
        - Don't learn on the job.
        - Don't do something complicated when a simple solution would work,
          unless you can appeal to one of the other principles.
        - Eliminate the possibility for easy-to-make errors whenever possible.
          Encode business logic in the type system.
        - Weigh the complexity of a change and ensure it's at the pareto
          frontier of the solution space.
            - Concave/convex problems.
- Everything stems from these things.
    - Do it correctly, unless its infeasible. In which case, be flexible about
      doing it as not-wrong as possible. When deciding between two options,
      always pick the one that maximizes empathy.
- Correctness/Flexibility are often accomplished simultaneously.
    - Applications are never the right thing to think about. Instead think about
      libraries.
    - Writing a library forces you to focus on the general problem, which
      increases the surface area of problems you are considering.
    - Writing a library means you can compose it together differently in order
      to solve evolving application demands.
    - Having a general purpose library means people can solve problems you can't
      imagine.
    - When you add empathy to the list, it forces you to think about the API
      surface of that library, and make it as pleasant to use as possible.
- ^ That is to say, libraries are the only solution to the above system of
    equations.
- Structuring applications
    - Applications should always be the barest wrapper around a library as
      possible.
    - Applications may load configuration and connect some UI elements to
      library code. And nothing else.
    - The meat of your code should be general purpose library code, some of
      which gets composed together to make the application. But the library
      comes first and is significantly more capable than the application ever
      provides.
    - Applications are hard to test, with all the UI stuff you need to operate
      on and automate. Libraries are easy---just make the calls and check the
      output.
- Structuring libraries
    - Libraries need not correspond to distinct compilation packages, but
      instead a strongly connected cluster of modules which exist to model some
      particular domain.
    - A software system is likely made up of many subsystems, each of which is
      modeled by a library.
    - If those independent subsystems need to interact, that too should be a
      library made up of components of the independent systems.
- Think more about "what" than "how"
    - WHAT am I trying to build? WHAT things make sense to model? WHAT
      invariants should hold here?
    - These are the crucial questions. They are the specification behind the
      "how do I make that happen?"
    - Focus on getting the "what" right; this gives you flexibility in the "how".
    - Most programming is all about how! But how to what? It's unclear! You have
      to build up a mental model of the what implicitly from the how.
- A library models a consistent and connected set of "what"s.
    - Made up of TYPES, which give us nouns that we can string functions
      between.
    - And combinators, which create and transform values of TYPES into other
      TYPES.
    - Notice already we have given a more general solution than what is standard
      in the literature. The much heralded MVC pattern is a special case of the
      separation of application (view) from library (model and controller),
      where the model is the types and the controllers are (often poorly
      modeled) functions.
- What are the properties of a good library?
    - It has a meaning. This is the specification/what from which all
      correctness comes downstream. This meaning gives rise to a mental model.
    - It solves the general problem. It is more useful than the original use
      case.
    - It is an abstract solution to the problem. Existing constraints exist in
      the problem domain, not the implementation.
    - It is impossible to use wrong. Every possible well-typed combination of
      functions is meaningful. Meaningless expressions are not well-typed.
