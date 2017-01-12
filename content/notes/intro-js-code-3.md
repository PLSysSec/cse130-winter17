+++
date = "2017-01-12T00:00:00-00:00"
description = "description"
draft = false
type = "notes"
title = "JavaScript No-Nos"

+++

{{< load-runkit >}}

Below are code snippets that illustrate some of the flexible features of
JavaScript and how they can introduce unexpected/unintuitive behavior.  There
are many more; see Appendix B of Crockford's _JavaScript: The Good Parts_.
Please note that there are useful, positive side of most of these; every
language design/implementation decision is a trade-off.

### Automatic semicolon insertion

{{< runkit auto-semi >}}
function f() {
  return 3;
}
function g() {
  return
  3;
}
console.log(f()); // ??
console.log(g()); // ??
{{< /runkit >}}

### Eval

{{< runkit eval >}}
global.x = 33;
{
  const x = 44;
  const ev = eval;
  console.log(eval("x")); // ??
  console.log(ev("x")); // ??
}
{{< /runkit >}}


### Implicit casting

See the sarcastic [WAT](https://www.destroyallsoftware.com/talks/wat) video.

### Monkeypatching

Because JavaScript lets you modify arbitrary objects and their prototypes,
running untrusted code safely is extremely difficult to do. (If you're
interested in this, come talk to me; this is some of my research.)
See the examples
[here](https://github.com/google/caja/wiki/GlobalObjectPoisoning) on global
object poisoning.

{{< runkit poisoning >}}
// suppose this API is expose by someone not completely trustworthy
function add(x, y) {
  if (!('stolenGoods' in global)) {
    // define new property on global object, if we haven't already
    global.stolenGoods = [];
    // copy the original toString
    const originalToString = Object.prototype.toString;
    // redefine it as to steal data when code calls toString
    Object.prototype.toString = function () {
      // call the original toString
      const res = originalToString.apply(this, arguments);
      stolenGoods.push(JSON.stringify(this));
    };
  }
  return x + y;
}

const obj = {
  secret: 'aliceIsSuperCool',
  x: 1337
};

console.log(obj);
add(3, 4); // we've been poisoned

console.log(obj); // calls toString implicitly
console.log({ otherSecret: 'cse130 is fun' });

console.log(`stolen stuff: ${global.stolenGoods}`); // ??
{{< /runkit >}}
