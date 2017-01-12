+++
date = "2017-01-09T00:00:00-00:00"
description = "description"
draft = false
type = "notes"
title = "JavaScript objects"

+++

{{< load-runkit >}}

Below is the code snippet illustrating simple JavaScript objects, created using
the object literal notation:

{{< runkit receiver >}}
const obj = {
  "x-w00t": 10,
  x: 1337,
  f: function (y) {
    this.x++;
    return this.x + y;
  }
};

console.log(obj.x); // ??
console.log(obj.f(3)); // ??
console.log(obj["x"]); // ??
console.log(obj["x-w00t"]) // ??
{{< /runkit >}}

Classes are sometimes appropriate, however. For example, they let you define
what every object instance of the class should look like. They also let you
define a single method that is **reused** by every object instance. This can be
done in modern JavaScript. Below is a code snippet showing the older style of
using functions, however, to accomplish similar goals. This yet-again
demonstrate the power of JavaScript's function (and objects-everywhere) design:

{{< runkit class >}}
function Car(make, model) {
  this.make = make;
  this.model = model;
  this.toString = function () {
    return `${this.make}@${this.model}`;
  };
}
Car.mySweetProp = 42;

const f = new Car("Ford", "Focus");
console.log(f.toString());
const t = new Car("Toyota", "Corola");
console.log(t.toString());

// Car.prototype is shared by all objects created by calling new Car(...)
// That's right you can treat functions like objects!

console.log(f.__proto__ === Car.prototype); // ??

// Let's define property common to all cars:
Car.prototype.color = "black";

console.log(f.color); // ??
// getProperty "color" of f
//     if it has it, return it
//     else getProperty "color" of f.__proto__
console.log(t.color); // ??

// Can override the default color that is defined on the prototype:

t.color = "red";

console.log(t.color); // ??
console.log(f.color); // ??

// We can define a method on the prototype:

Car.prototype.toColorString = function () {
  return `${this.make}, ${this.model}, ${this.color}`;
};

console.log(f.toColorString()); // ??
console.log(t.toColorString()); // ??
{{< /runkit >}}

**[Continue with bad consequences of flexible design](../intro-js-code-3)**.
