#!/usr/bin/env node
'use strict';

var fs = require('fs-extra'),
    range = require('lodash.range'),
    lib = require('../lib'),
    rangeRight = require('lodash.rangeright'),
    path = require('path'),
    yargs = require('yargs'),
    t = require('../t');

function signalWidth (width) {
    var aWidth = Math.abs(width);
    if (aWidth === 1) {
        return '          ';
    } else {
        return ('       [' + (aWidth - 1) + ':0] ').slice(-10);
    }
}

var obj = {
    range: range,
    sklansky: lib.sklansky,
    rangeRight: rangeRight,
    core: function () {
        var _io = { clk: 1, reset_n: 1 };
        var _logic = [];
        return {
            logic: function (width) {
                var obj = {
                    width: width
                };
                _logic.push(obj);
                return obj;
            },
            scan: function () {
                _io.ti = 1;
                _io.te = 1;
                _io.to = -1;
            },
            get: {
                list: function () {
                    return Object.keys(_io).join(', ');
                },
                ports: function () {
                    return Object.keys(_io).map(function (e) {
                        return ((_io[e] > 0) ? 'input ' : 'output') + signalWidth(_io[e]) + e + ';\n' ;
                    }).join('');
                },
                wires: function () {
                    return '// declarations';
                },
                body: function () {
                    var res = 'always @(';
                    res += _logic.map(function (e, i) { return 'l' + i; }).join(', ');
                    res += ')\nbegin\n';
                    _logic.forEach(function (e, i) {
                        res += 'l' + i + '\n';
                    });
                    res += 'end\n';
                    return res;
                }
            }
        };
    }
};

Object.keys(t).forEach(function (fileName) {
    var res = t[fileName](obj);
    fs.outputFileSync(
        path.resolve(process.cwd(), 'v/', fileName),
        res
    );
});
