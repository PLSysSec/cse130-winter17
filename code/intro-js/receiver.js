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
