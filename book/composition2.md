---
id: composition2
confidence: 7
tags: []
bigger:
- philosophy
smaller:
- composition-of-correctness
- composition-of-functions
- composition-of-implementations
- composition-of-understanding
- types
see-also: []
name: "Composition2"
teaser: ""
---

Moreso than any other

The average software library is resoundingly non-composition; therefore, it can
be hard to spot---if only due to being a proverbial fish in water. To take
a concrete example, consider the popular protobuffer IDL. Protobuffer, like
other interface description languages, is used to give a schema for sending
records over the wire. The purpose is to define your datatype once, and
generate code for it in any language in which you might be communicating.

As an example of what a protobuffer definition looks like, the following is
straight out of the language guide:

```protobuffer
message Example {
  string query = 1;
  int32 page_number = 2;
  int32 results_per_page = 3;
}
```

The exact details here don't matter, but this defines a new record called
`Example`, with three fields. You can see that each field comes with an
associated type. Besides the "usual" types---things like `string`, `bool`,
`int32`---protobuffer has some support for type operators. For example, you can
mark a field as `repeated`:

```protobuffer
message Example2 {
  int32 userid = 1;
  repeated int32 relationships = 2;
}
```

which says that in a given `Example2`, we will have exactly one `userid`, but
zero or more `relationship`s. In essence, `repeated` turns a field of type `T`
into a list, or array, of `T`s. Despite the presence of one instance of
`repeated` turning a field into a 1D array, we cannot use `repeated repeated`
to turn a field into a 2D array.

In other words, the `repeated` construct cannot be composed with itself.
However desirable it might be for your business logic to be able to articulate
2D arrays, you are nevertheless stuck.

Consider another example, also from protobuffers. It's often desirable to
articulate "at most one of these fields is present" (a
[coproduct][coproduct])---for example, I might need to maintain both a legacy
and new version of an order system. Therefore, in processing an order, I might
have the legacy version of the data structure, or the new one, and my software
ought to be able to handle either.

We can express this situation in protobuffer via a `oneof` field:

```protobuffer
message OrderStatusReq {
  oneof order_container {
    LegacyOrder legacy_order = 1;
    Order order = 2;
  }
}
```

But these `oneof` fields are also noncompositional; they can't be combined with
`repeated` fields. That is to say, neither can I make an array of things which
are one of `LegacyOrder` or `Order`, nor can I make a `oneof` of fields which
are themselves arrays.

How does one get into this situation? Usually it is caused by having an
implementation in mind when you design the abstraction. This is at odds with
[applications-want-to-be-libraries][applications-want-to-be-libraries]---recall
that the hallmark of lasting software is its ability to solve problems that the
author never thought of. Composition, by its very nature, allows for all
meaningful combinations of concepts---the crushing majority of which will never
be discovered by any human, but which is guaranteed to work regardless.

