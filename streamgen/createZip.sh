#!/bin/bash

cd "$(dirname "$0")"

folderName="streamgen_v_1_0"
mkdir $folderName

echo move data to new folder
cp -R config_build $folderName/
cp -R data_provider $folderName/
cp -R display $folderName/
cp -R streamgen $folderName/
cp stream_help.m $folderName/
cp runUnitTests.m $folderName/


zip -r streamgen_v_1_0.zip $folderName
rm -rf $folderName/

mv streamgen_v_1_0.zip /home/denis/master/masterThesis/master-thesis/releases



