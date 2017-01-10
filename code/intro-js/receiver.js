const obj = {
  x: 10,
  f: function (y) {
    this.x++;
    return this.x + y;
  }
};

console.log(obj.x); // ??
console.log(obj.f(3)); // ??
console.log(obj["x"]); // ??
