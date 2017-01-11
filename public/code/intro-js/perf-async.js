const fs = require('fs');

fs.readFile('./perf-sync.js', 'utf8', cb1); // returns immediately, cb1 is queued on the event loop and called later when actual file read is done
fs.readFile('./perf-async.js', 'utf8', cb2); // returns immediately, " "

function processFile(fname, str) {
  fs.writeFileSync(`/tmp/${fname}`, str);
  console.log(`DONE writing /tmp/${fname}`);
}

function cb1(err, str) {
  processFile('perf-sync.js', str);
}

function cb2(err, str) {
  processFile('perf-async.js', str);
}
