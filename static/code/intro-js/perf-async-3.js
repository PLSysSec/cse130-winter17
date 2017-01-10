const fs = require('fs');

readAndProcessFile('perf-sync.js');
readAndProcessFile('perf-async.js');

function readAndProcessFile(name) {
  return fs.readFile(`./${name}`, 'utf8', processFile(name));
}

function processFile(fname) {
  return (err, str) => {
    fs.writeFileSync(`/tmp/${fname}`, str);
    console.log(`DONE writing /tmp/${fname}`);
  };
}
