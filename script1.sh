#!/bin/bash
numOfFiles=1
numOfDirs=2
for i in `seq 1 $numOfFiles`;
do
for j in `seq 1 $numOfDirs`;
do
mkdir dir$j
cd dir$j
touch file$j'0'
cd ..
done
touch file$i
done
ln -s file1 link1
