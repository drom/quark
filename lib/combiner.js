'use strict';

// branch(0) loadstore(1) alu(2) drop-fear(3) tail(4) PS(5) RS(6)
var words = [
    {name:'LIT4',   use:[0, 0, 0, 1,  4,  1, 0, -1, 0]}, // (          -- x )
    {name:'LIT8',   use:[0, 0, 0, 1,  8,  1, 0, -1, 0]}, // (          -- x )
    {name:'LIT16',  use:[0, 0, 0, 1, 16,  1, 0, -1, 0]}, // (          -- x )
    {name:'LIT32',  use:[0, 0, 0, 1, 32,  1, 0, -1, 0]}, // (          -- x )
    {name:'BRANCH', use:[1, 0, 0, 1,  4, -1, 0,  1, 0]}, // (     addr --   )


    {name:'CALL',   use:[1, 0, 0, 1,  0, -1, 1,  1,-1]}, // (     addr --   | -- z )
    {name:'LOAD',   use:[0, 1, 0, 1,  4,  0, 0,  0, 0]}, // (     addr -- val )
    {name:'PICK',   use:[0, 0, 0, 1,  4,  1, 0,  0, 0]}, // (          -- x )
    {name:'DUP',    use:[0, 0, 0, 1,  0,  1, 0,  0, 0]}, // (        x -- x x )
    {name:'R>',     use:[0, 0, 0, 0,  0,  1,-1, -1, 1]}, // (          -- x | x --   )
    {name:'STORE',  use:[0, 1, 0, 0,  4, -1, 0,  2, 0]}, // ( val addr -- val )
    {name:'ALU',    use:[0, 0, 1, 1,  4, -1, 0,  1, 0]}, // (      x y -- z )
    {name:'DROP',   use:[0, 0, 0, 0,  0, -1, 0,  1, 0]}, // (        x --   )
    {name:'>R',     use:[0, 0, 0, 0,  0, -1, 1,  1,-1]}, // (        x --   |   -- x )
];

var options = {
    loadstore: 1,
    alu: 1,
    dropfear: 1,
    lit_slots: 120,
    r2r: 0,
    litalu1: 1,
    ps_push: 1,
    ps_pop: 1,
    rs_push: 1,
    rs_pop: 1,
    branch: 1
};

exports.options = options;

function good_loadstore (arr) {
    if (!options.loadstore) { return 1; }
    var i, count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[1]; // loadstore
    }
    if (count > 1) { return 0; }
    return 1;
}

function good_alu (arr) {
    var i, count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[2]; // ALUs
    }
    if (count > options.alu) { return 0; }
    return 1;
}

function good_dropfear (arr) {
    if (!options.dropfear) { return 1; }
    var i;
    for (i = 1; i < arr.length; i++) {
        if ((words[arr[i]].name === 'DROP') && (words[arr[i-1]].use[3])) { return 0; } // drop fear
    }
    return 1;
}

function good_lit_slot (arr) {
    var i, count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[4]; // tail
    }
    if (count > options.lit_slots) { return 0; }
    return 1;
}

function good_r2r (arr) {
    if (options.r2r) { return 1; }
    var i;
    for (i = 1; i < arr.length; i++) {
        if ((words[arr[i]].name === 'R>') && (words[arr[i-1]].name === '>R')) { return 0; }
        if ((words[arr[i]].name === '>R') && (words[arr[i-1]].name === 'R>')) { return 0; }
    }
    return 1;
}

function good_litalu1 (arr) {
    if (options.litalu1) { return 1; }
    var i;
    for (i = 1; i < arr.length; i++) {
        if ((words[arr[i]].name === 'ALU1') && (words[arr[i-1]].name === 'LIT')) { return 0; }
    }
    return 1;
}

function good_balance (arr) {
    var i, count;

    count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[5]; // PS balance
    }
    if (count >  options.ps_push) { return 0; }
    if (count < -options.ps_pop) { return 0; }
    count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[6]; // RS balance
    }
    if (count >  options.rs_push) { return 0; }
    if (count < -options.rs_pop) { return 0; }
    return 1;
}

function good_to_go (arr) {
    return good_alu(arr)
        && good_loadstore(arr)
        && good_dropfear(arr)
        && good_r2r(arr)
        // && good_litalu1(arr)
        && good_balance(arr)
        && good_lit_slot(arr);
}

function print_row (arr) {
    var i, ret, count;

    ret = '<tr> <td> ';
    for (i = 0; i < arr.length; i++) {
        ret += words[arr[i]].name + ' ';
    }
    ret += ' </td> <td> ';
    count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[5];
    }
    ret += count + ' </td> <td> ';
    count = 0;
    for (i = 0; i < arr.length; i++) {
        count += words[arr[i]].use[6];
    }
    ret += count + ' </td>\n';
    return ret;
}

exports.dump = function (arr) {
    arr[0].forEach(function (e) {
        console.log(
            (
                e.reduce(function (a, i) {
                    return a + ' ' + words[i].name;
                }, '') + ' '.repeat(50)
            ).slice(0, 40) +
            (
                e.reduce(function (a, i) {
                    return a + words[i].use[5];
                }, 0) + ' '.repeat(5)
            ).slice(0, 5) +
            (
                e.reduce(function (a, i) {
                    return a + words[i].use[6];
                }, 0) + ' '.repeat(5)
            ).slice(0, 5)
        );
    });
    console.log('%s particles of %s quarks', arr[1], arr[0][0].length);
};

exports.run1 = function run1 () {
    var i,
        count = 0,
        ret = [];

    for (i = 0; i < words.length; i++) {
        if (good_to_go([i])) {
            ret.push([i]);
            count += 1;
        }
    }
    return [ret, count];
};

exports.run2 = function run2 () {
    var i0, i1,
        count = 0,
        branch = options.branch,
        ret = [];

    for (i0 = 0; i0 < words.length; i0++) {
        if (!(branch && (words[i0].use[0]))) { // branch slot
        for (i1 = 0; i1 < words.length; i1++) {
            if (good_to_go([i0, i1])) {
                ret.push([i0, i1]);
                count += 1;
            }
        }}
    }
    return [ret, count];
};

exports.run3 = function run3 (reports) {
    var i0, i1, i2,
        count = 0,
        branch = options.branch,
        ret = [];

    for (i0 = 0; i0 < words.length; i0++) {
        if (!(branch && (words[i0].use[0]))) { // branch slot
        for (i1 = 0; i1 < words.length; i1++) {
            if (!(branch && (words[i1].use[0]))) { // branch slot
            for (i2 = 0; i2 < words.length; i2++) {
                if (good_to_go([i0, i1, i2])) {
                    if (count < reports) { ret.push([i0, i1, i2]); }
                    count += 1;
                }
            }}
        }}
    }
    return [ret, count];
};

exports.run4 = function run4 (reports) {
    var i0, i1, i2, i3,
        count = 0,
        branch = options.branch,
        ret = [];

    for (i0 = 0; i0 < words.length; i0++) {
        if (!(branch && (words[i0].use[0]))) { // branch slot
        for (i1 = 0; i1 < words.length; i1++) {
            if (!(branch && (words[i1].use[0]))) { // branch slot
            for (i2 = 0; i2 < words.length; i2++) {
                if (!(branch && (words[i2].use[0]))) { // branch slot
                for (i3 = 0; i3 < words.length; i3++) {
                    if (good_to_go([i0, i1, i2, i3])) {
                        if (count < reports) { ret.push([i0, i1, i2, i3]); }
                        if (count > 1000000) {
                            return [ret, count];
                        }
                        count += 1;
                    }
                }}
            }}
        }}
    }
    return [ret, count];
};

exports.run5 = function run5 (reports) {
    var i0, i1, i2, i3, i4,
        count = 0,
        branch = options.branch,
        ret = [];

    for (i0 = 0; i0 < words.length; i0++) {
        if (!(branch && (words[i0].use[0]))) { // branch slot
        for (i1 = 0; i1 < words.length; i1++) {
            if (!(branch && (words[i1].use[0]))) { // branch slot
            for (i2 = 0; i2 < words.length; i2++) {
                if (!(branch && (words[i2].use[0]))) { // branch slot
                for (i3 = 0; i3 < words.length; i3++) {
                    if (!(branch && (words[i3].use[0]))) { // branch slot
                    for (i4 = 0; i4 < words.length; i4++) {
                        if (good_to_go([i0, i1, i2, i3, i4])) {
                            if (count < reports) { ret.push([i0, i1, i2, i3, i4]); }
                            if (count > 1000000) {
                                return [ret, count];
                            }
                            count += 1;
                        }
                    }}
                }}
            }}
        }}
    }
    return [ret, count];
};
