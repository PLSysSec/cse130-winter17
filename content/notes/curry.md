+++
date = "2017-01-25T00:00:00-00:00"
description = "description"
draft = false
type = "notes"
title = "Currying"

+++

{{< load-runkit >}}

Below is the code snippet illustrating how to implement multi-argument functions using lambdas and back:

{{< runkit curry >}}
// Let's take a 3 argument function
const foo = (x, y, z) => x + y + z;
// This function can be curried, i.e., it can be implemented using
// single-argument functions:
const foo_curried = (x) => (y) => (z) => x + y +z;
// a single argument function can always be used to implement a
// multiple-argument functions:
const foo_uncurried = (x,y,z) => foo_curried(x)(y)(z);
// all the foo's are equivalent:
// the only thing thatchanges is how we call the function

console.log(foo(1,2,3));
console.log(foo_curried(1)(2)(3));
console.log(foo_uncurried(1,2,3));
{{< /runkit >}}


In a language with only sigle-argument lambdas, you can add syntactic sugar to
implement multiple-argument functions:

- Function declaration: `(x1,x2,x3,...,xn) => e` gets transformed to `(x1) => (x2) => (x3) => ... => (xn) => e`

- Function application: `f(e1, e2, e3, ..., en)` gets transformed to `f(e1)(e2)(e3)...(en)`

