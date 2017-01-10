function Car(make, model) {
  this.make = make;
  this.model = model;
  this.toString = function () {
    return `${this.make}@${this.model}`;
  };
}

const f = new Car("Ford", "Focus");
console.log(f.toString());
const t = new Car("Toyota", "Corola");
console.log(t.toString());

// TODO: add color to prototype
