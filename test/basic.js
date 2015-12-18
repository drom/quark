'use strict';

var dut = require('../lib/combiner');

describe('combiner', function () {
    it('run1', function (done) {
        dut.dump(dut.run1(10000));
        done();
    });
    it('run2', function (done) {
        dut.dump(dut.run2(10000));
        done();
    });
    it('run3', function (done) {
        dut.dump(dut.run3(10000));
        done();
    });
    it('run4', function (done) {
        dut.dump(dut.run4(10000));
        done();
    });
    it('run5', function (done) {
        dut.dump(dut.run5(10000));
        done();
    });
});
