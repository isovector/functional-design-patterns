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
constantFrequency :: Frequency -> Waveform
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

Another good way of grouping functions is by looking for [endos]()---functions
that consume and produce a value of the same type. This gives us a third group:

3. ```haskell
    combineWF :: Waveform -> Waveform -> Waveform
    silence :: Time -> Time -> Waveform -> Waveform
    echo :: Waveform -> Waveform
   ```


---

...smaller context...
