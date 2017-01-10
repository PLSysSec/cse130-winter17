function hello(x) {
  console.log(`A: x = ${x}`); // ??
  (function () {
    var x = 45;
    console.log(`B: x = ${x}`); // ??
  })();
  (function () {
    console.log(`C: x = ${x}`); // ??
  })();
}

hello(42);
