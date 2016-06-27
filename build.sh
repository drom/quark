#!/usr/bin/sh
export QUARTUS=${HOME}/programs/eda/altera_lite/15.1/quartus
bin/tmp.js src > t/index.js
bin/gen.js v
${QUARTUS}/bin/quartus_map quark
${QUARTUS}/bin/quartus_fit quark
${QUARTUS}/bin/quartus_sta --tcl_eval project_open quark\; create_timing_netlist\; report_timing -npaths 100 > quark.sta.rpt
${QUARTUS}/bin/quartus_sta --do_report_timing quark
cat output_files/quark.sta.rpt | grep MHz
../sta/bin/quartus.js quark.sta.rpt > quark.sta.json
../sta/bin/sta.js quark.sta.json > quark.svg
