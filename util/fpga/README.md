# FPGA Splice flow
This is a FPGA utiity script which embedds the generated rom elf file into FPGA bitstream.
Script assumes there is pre-generated fpga bit file in the build directory.The boot rom mem file is auto generated.

## How to run the script
Utility script to load MEM contents into BRAM FPGA bitfile.
* Usage:
```console
$ cd $REPO_TOP
$ ./util/fpga/splice_nexysvideo.sh
```

Updated output bitfile located : at the same place as raw vivado bitfile @
`build/lowrisc_systems_top_earlgrey_nexysvideo_0.1/synth-vivado/lowrisc_systems_top_earlgrey_nexysvideo_0.1.splice.bit`

This directory contains following files
* splice_nexysvideo.sh - master script
* bram_load.mmi - format which vivado tool understands on which FPGA BRAM locations the SW contents should go
* addr4x.py - utility script used underneath to do address calculation to map with FPGA BRAM architecture
