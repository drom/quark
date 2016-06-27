#!/usr/bin/env node
'use strict';

var fs = require('fs'),
    path = require('path'),
    yargs = require('yargs'),
    template = require('lodash.template');

function index (dirName) {
    var expo = {};
    var res = '';
    var fullPath = path.resolve(process.cwd(), dirName);
    // res += '// ' + fullPath + '\n';
    var fileList = fs.readdirSync(fullPath, 'utf8');
    fileList.forEach(function (e, i) {
        var fullFileName = path.resolve(fullPath, e);
        // res += '// ' + fullFileName + '\n';
        res += 'var f__' + i + ' = ' + template(fs.readFileSync(fullFileName, 'utf8')) + '\n';
        expo[e] = 'f__' + i;
    });
    res += 'module.exports = {';
    res += Object.keys(expo).map(function (name) {
        return '\n  \'' + name + '\': ' + expo[name];
    }).join(',');
    res += '\n};';
    return res;
}

var argv = yargs.argv;

if (argv._.length === 1) {
    console.log(index(argv._[0]));
} else {
    console.log(argv);
}
