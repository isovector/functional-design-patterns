---
id: combinator-libraries
confidence: 7
tags: []
bigger:
- composition-of-correctness
- composition-of-implementations
- composition-of-understanding
- modeling-with-types
- tools
smaller:
- parsers
see-also: []
name: "Combinator Libraries"
teaser: ""
---


...bigger context...

---

Make a list of each salient concept in your problem domain. These are good
candidates for the types in your library. Without fail, this list will be
*wrong,* but it's a good starting point. We'll use the audio processing library
as our on-going example for this section. Thus, let's lay out our candidate types:

```haskell
data AudioFile
data Waveform
data Frequency
data Pitch
data Time
```

Next, make a list of every interaction you can think of that exists between the
type candidates enumerated above. Pay close attention to the "obvious"
interactions---that is to say, the things you're aware that you'd like your
library to be able to do. In our audio processing example, this might be:

* extract the channels of an audio file as waveforms
* sample a waveform at a particular time
* combine two waveforms together
* build a waveform out of a constant frequency
* build a waveform out of a value changing over time
* shift a waveform in time
* mute a section of a waveform
* add an echo to a waveform
* export waveforms as the channels of an audio file

Notice that some of these operations are between several candidate types (such
as extracting the channels of an audio file as waveforms), while others are
only over a single candidate (such as shifting a waveform in time.) Even if an
interaction aren't obviously necessary for whatever you originally set out to
build, if it's meaningful, write it down. As a general principle, strive
towards having a few interactions that introduce concepts, and several that
eliminate them ([introduction-and-elimination]()). In particular, aim to have
at least one way of producing each domain object.

This stage is to come up with examples of you'd like to be able to do with your
library. Lay each desired interaction out as a function:

```haskell
extractChannels :: AudioFile -> List Waveform
sampleWF :: Waveform -> Time -> Frequency
combineWF :: Waveform -> Waveform -> Waveform
signal :: (Time -> Pitch) -> Waveform
delay :: Waveform -> Time -> Waveform
silence :: Time -> Time -> Waveform -> Waveform
echo :: Waveform -> Waveform
exportAudio :: List Waveform -> AudioFile
```

Like the set of types we originally came up with, this list probably too is
wrong, and certainly is incomplete. But all we're looking for is a starting
point.

Often, these identified functions will appear as groups of related
functionality. One particularly illuminating grouping is
[there-and-back-again](), in which we look for functions that appear to be
inverses of one another. Above, there are two such groups:

1. ```haskell
    extractChannels :: AudioFile -> List Waveform
    exportAudio :: List Waveform -> AudioFile
   ```
2. ```haskell
    sampleWF :: Waveform -> Time -> Frequency
    signal :: (Time -> Pitch) -> Waveform
   ```

Spotting this second group requires a little sluething---we must recall that
the function arrow associates to the right ([function-types]()), and identify
that there isn't much in the way of our listed interactions that differentiates
between `Pitch` and `Frequency`.

[isomorphisms]() like these, especially when one side is expressed in terms of
types that have obvious, real world interpretations---such as `Time` and
`Frequency`---are exceptionally good candidates for the [denotations]() of your
combinator library.

Another good way of grouping functions is by looking for [endos]()---functions
that consume and produce a value of the same type. This gives us a third group:

3. ```haskell
    combineWF :: Waveform -> Waveform -> Waveform
    silence :: Time -> Time -> Waveform -> Waveform
    echo :: Waveform -> Waveform
   ```

The express goal is now to generalize as much of the interface as you can.
Taking the denotation of `Waveform` to be `Time -> Frequency`, we can ask
ourselves whether it is meaningful to parameterize either side of the function
arrow. While functions out of some general type `a` into `Frequency` are
potentially psychedelically interesting, it's unclear whether this is a good
generalization.

Instead, consider functions out of timem *into* some general type `a`. These are
"signals" that vary over time, of which `Frequency` is just a special case.
Therefore we can try:

```haskell
data Signal a
type Waveform = Signal Frequency
```

Consider each function from group 3 generalized against this new `Signal` type,
instead of being directly over `Waveform`s. None of them make much sense as
written, but with minor changes we can fix each. First, let's look at `combineWF`:

```haskell
combineWF :: forall a. Signal a -> Signal a -> Signal a
```

Due to the [forall]() quantifier on this type, we have no means of combining the
`a` value at corresponding moments in time. Thus, we must introduce a combining
operation:

```haskell
combineWF :: forall a. (a -> a -> a) -> Signal a -> Signal a -> Signal a
```

Having made this transformation, there is now no reason that we need only
a single abstract type. Thus, generalize the type further:

```haskell
combineWF :: forall a b c. (a -> b -> c) -> Signal a -> Signal b -> Signal c
```

The type of `combineWF` is now of a familiar shape ([applicatives]()), and due
to [the-best-abstraction-already-exists](), we ought to look for more
applicative structure in `Signal`. Does it admit an applicative unit?

```haskell
constantS :: forall a. a -> Signal a
```

This is certainly tenable, `constantS` would produce a `Signal` that never
changes. Therefore, it seems likely that `Signal` has an applicative structure,
and thus we ought to look also for a function structure:

```haskell
mapS :: (a -> b) -> Signal a -> Signal b
```

Again, this is a very reasonable addition, in that we'd like to post-compose the
output of a function-over-time. The applicative laws state that we can always
give functor structure whenever we have applicative structure (see
[applicatives]()), but even if this were not true, functors can always be
created [initial-encodings](freely) via [yoneda]().

Due to [the-best-abstraction-already-exists](), you will often discover that
most of your problem domain reduces to known abstractions. Given the new
applicative structure for `Signal`, we can cast our vengeful gaze on `silence`:

```haskell
silence :: forall a. Time -> Time -> Signal a -> Signal a
```

The loosely-intended semantics here were to "blank out" the signal between the
given times, but again, the universally-quanitifed nature of the new signature
doesn't allow us to do so. Instead we could try taking a parameter representing
silence:

```haskell
silence :: forall a. a -> Time -> Time -> Signal a -> Signal a
```

but such an implementation would therefore be equivalent to:

```haskell
silence silent start end s =
  signal (\t ->
    if t >= start && t < end
       then silent
       else sampleSF s t
    )
```

which means we may provide `silence` in our library if we'd like, but it does
not need to be a first-class primitive.


---

...smaller context...
