'use strict';

var lib = require('../lib');

function printf (r) {
    return '[' + r.hi   + ',' + r.lo   + ']';
}

function printa (r) {
    return printf(r.res) + ' = '
        + printf(r.left) + ' + ' + printf(r.right) + '\n';
}

describe('sklansky', function () {
    it('8', function (done) {
        var res = '';
        lib.sklansky(8, r => res += printa(r) );
        console.log(res);
        done();
    });
    it('7', function (done) {
        var res = '';
        lib.sklansky(7, r => res += printa(r) );
        console.log(res);
        done();
    });
    it('9', function (done) {
        var res = '';
        lib.sklansky(9, r => res += printa(r) );
        console.log(res);
        done();
    });
});
