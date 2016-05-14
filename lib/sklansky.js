'use strict';

function cut (r) {
    var lo = r.lo;
    var hi = r.hi;
    var tlen = hi - lo + 1;
    var llen = Math.pow(2, Math.ceil(Math.log(tlen)/Math.log(2)) - 1);
    return {
        lo: { lo: lo, hi: lo + llen - 1},
        hi: { lo: lo + llen, hi: hi}
    };
}

function sklansky (len, fn) {
    function rec (r) {
        var tmp, i;
        if (r.lo !== r.hi) {
            tmp = cut(r);
            rec(tmp.lo);
            rec(tmp.hi);
            for (i = tmp.hi.lo; i <= tmp.hi.hi; i++) {
                fn({
                    res:   { lo: tmp.lo.lo, hi: i },
                    left:  { lo: tmp.hi.lo, hi: i },
                    right: { lo: tmp.lo.lo, hi: tmp.lo.hi }
                });
            }
        }
    }
    rec({ lo: 0, hi: len - 1 });
}

module.exports = sklansky;
