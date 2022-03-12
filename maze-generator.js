"use strict";

class MazeGenerator {
  // consructor of the maze engine
  constructor({ gatesCount = 5, lockedGatesCount = 0 } = {}) {
    // number of gates in the maze
    this.gatesCount = gatesCount;
    // number of locked gates in the maze
    this.lockedGatesCount = lockedGatesCount;
    // create {gatesCount} random numbers from array from 100 to 999
    this.gatesNums = this.shuffle(Array.from(this.createGatesNums())).slice(
      0,
      gatesCount
    );

    // calculate gates inside
    this.gatesInsideCount =
      gatesCount == 2 ? 1 : gatesCount == 3 ? 2 : gatesCount == 4 ? 3 : 4;
    // init gates
    this.gates = this.initGates();
    this.usedGates = this.distributeGates();
    this.unUsedGates = this.gatesNums.filter(
      (gate) => !this.usedGates.includes(gate)
    );
    // fix unused gates
    this.fixInside();
    // delete unwanted vars
    delete this.unUsedGates;
    delete this.usedGates;
    // lock gates
    this.keys = this.lockGates();
    // generate keys
    this.genKeys();
    // set start and end points
    this.setStartGate();
    this.setEndGate();
  }

  // create numbers from 100 to 999 as generator
  *createGatesNums() {
    for (let i = 100; i <= 999; i++) {
      yield i;
    }
  }

  // shuffle array
  shuffle = (arrToShuffle) => {
    let arrCopy = arrToShuffle.slice();
    for (let i = arrCopy.length - 1; i > 0; i--) {
      let j = Math.floor(Math.random() * i);
      [arrCopy[i], arrCopy[j]] = [arrCopy[j], arrCopy[i]];
    }
    return arrCopy;
  };

  // gen gates
  initGates = () => {
    return this.gatesNums.map((num) => {
      return {
        number: num,
        isStart: false,
        isEnd: false,
        isLocked: false,
        key: false,
        gatesInside: [],
      };
    });
  };

  genRandomIndex = () => {
    return Math.floor(Math.random() * this.gatesNums.length);
  };

  // generate random gate number of this.gatesNums
  genGateInside = () => {
    let randomIndex = this.genRandomIndex();
    let randomGateNum = this.gatesNums[randomIndex];
    return randomGateNum;
  };

  getRandomGate = () => {
    let randomIndex = this.genRandomIndex();
    let randomGate = this.gates[randomIndex];
    return randomGate;
  };

  // distribute gates
  distributeGates = () => {
    // init used gates: gates used inside other gates
    let usedGates = [];
    // map on all gates and generate gates inside
    this.gates.map((gate) => {
      // add {this.gatesInsideCount} gates inside
      for (let i = 0; i < this.gatesInsideCount; i++) {
        // init random gate number
        let gateNum = this.genGateInside();
        // random gate numebr should not be repeated in the samge gate
        // and should not be the same gate number
        while (gate.gatesInside.includes(gateNum) || gateNum == gate.number) {
          gateNum = this.genGateInside();
        }
        // add gateNum to gates inside
        gate.gatesInside.push(gateNum);
        // add gateNumber used to usedGates array if not exists
        if (!usedGates.includes(gateNum)) {
          usedGates.push(gateNum);
        }
      }
    });
    return usedGates;
  };

  // add unused gates to random gate
  fixInside = () => {
    for (let i = 0; i < this.unUsedGates.length; i++) {
      let randomGate = this.getRandomGate();
      // add to gateInside only if gatesInsideCount is not more that the gatesInsideCount
      while (
        randomGate.gatesInside.length > this.gatesInsideCount ||
        randomGate.number == this.unUsedGates[i]
      ) {
        randomGate = this.getRandomGate();
      }
      // add unsused gate to gatesInside of the randomGate we got
      randomGate.gatesInside.push(this.unUsedGates[i]);
    }
  };

  // generate lockes and keys
  // conditions:
  // -> gatesInside length == normal length == this.gatesInsideCounts (no fixes)
  // -> not already locked
  lockGates = () => {
    let keys = [];
    for (let i = 0; i < this.lockedGatesCount; i++) {
      let randomGate = this.getRandomGate();
      while (
        randomGate.gatesInside.length > this.gatesInsideCount ||
        randomGate.isLocked
      ) {
        randomGate = this.getRandomGate();
      }
      randomGate.isLocked = true;
      keys.push(randomGate.number);
    }
    return keys;
  };
  // generate keys for locked gates
  // conditions IMPORTANT:
  // not keyed
  // key != number of current gate
  // key != number of gate that has the key of current random gate
  // must one key should be out of loked
  // how to apply last condition :
  // 1 - get the gate that has key of the current randomGate -> let A
  // 2 - check key == A.number
  genKeys = () => {
    // console.log(this.keys);
    for (let i = 0; i < this.keys.length; i++) {
      let key = this.keys[i];
      let randomGate = this.getRandomGate();
      while (
        randomGate.key !== false ||
        randomGate.number === key ||
        !this.isPossibleKey(key, randomGate.number)
      ) {
        randomGate = this.getRandomGate();
      }
      randomGate.key = key;
    }
  };

  // apply third condition of adding keys
  isPossibleKey = (key, currentRandomNum) => {
    let query = this.gates.filter((gate) => gate.key == currentRandomNum);
    if (query.length == 0) {
      return true;
    } else {
      // console.log(key, currentRandomNum);
      return query[0].number !== key;
    }
  };

  // set start point gate
  // conditions:
  // 1 - not locked
  setStartGate = () => {
    let randomGate = this.getRandomGate();
    while (randomGate.isLocked) {
      randomGate = this.getRandomGate();
    }
    randomGate.isStart = true;
  };

  // set last point (win)
  // conditions:
  // 1 - not start point!
  // 2 - locked

  setEndGate = () => {
    let randomGate = this.getRandomGate();
    while (!randomGate.isLocked || randomGate.isStart) {
      randomGate = this.getRandomGate();
    }
    randomGate.isEnd = true;
  };
}

module.exports = { MazeGenerator };
// let gg = new MazeGenerator({ gatesCount: 6, lockedGatesCount: 2 });
// console.log(gg.gates);
