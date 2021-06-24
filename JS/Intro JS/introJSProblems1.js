function mysteryScoping1() {
    var x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}

function mysteryScoping2() {
    const x = 'out of block';
    if (true) {
        const x = 'in block';
        console.log(x);
    }
    console.log(x);
}

function mysteryScoping3() {
    const x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}

function mysteryScoping4() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    console.log(x);
}

function mysteryScoping5() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    let x = 'out of block again';
    console.log(x);
}

const madLib = (verb, adj, noun) => {
  console.log(`We shall ${verb.toUpperCase()} the ${adj.toUpperCase()} ${noun.toUpperCase()}.`);
}

const isSubstring = (searchString, subString) => {
  return searchString.includes(subString);
}

const fizzBuzz = array => {
  let newArr = []
  for (let i = 0; i < array.length; i++) {
    if (array[i] % 3 === 0 && array[i] % 5 === 0) {
      continue;
    } else if (array[i] % 3 === 0 || array[i] % 5 === 0) {
      newArr.push(array[i]);
    }
  }
  console.log(newArr);
}

const isPrime = num => {
  if (num === 2) {
    return true;
  }

  for (let i = 2; i < num; i++) {
    if (num % i === 0) {
      return false;
    }
  }
  return true;
}

const sumOfNPrimes = n => {
  let sum = 0;
  let count = 0;
  let i = 2

  while (count < n) {
    if (isPrime(i) === true) {
      count += 1;
      sum += i;
    }
    i++;
  }
  return sum
}
