'use strict';

var lib = require('../lib');

function printf (r) {
    return '[' + r.res.hi   + ',' + r.res.lo   + '] ='
        + ' [' + r.left.hi  + ',' + r.left.lo  + '] +'
        + ' [' + r.right.hi + ',' + r.right.lo + ']\n';
}

describe('sklansky', function () {
    it('8', function (done) {
        var res = '';
        lib.sklansky(8, r => res += printf(r) );
        console.log(res);
        done();
    });
    it('7', function (done) {
        var res = '';
        lib.sklansky(7, r => res += printf(r) );
        console.log(res);
        done();
    });
    it('9', function (done) {
        var res = '';
        lib.sklansky(9, r => res += printf(r) );
        console.log(res);
        done();
    });
});
