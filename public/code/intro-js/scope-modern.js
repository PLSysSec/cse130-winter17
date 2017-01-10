function hello(x) {
  console.log(`A: x = ${x}`); // ??
  {
    const x = 45;
    console.log(`B: x = ${x}`); // ??
  }
  {
    console.log(`C: x = ${x}`); // ??
  }
}

hello(42);
