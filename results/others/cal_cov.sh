#!/bin/bash

cd $WORKDIR/topstream

rm -f topstream.gcda topstream.gcno

make clean all > /dev/null 2>&1

for file in $1/*
do
	echo 'Running' $(basename $file)
	{
	pkill -9 service
	./service 127.0.0.1 9999 &
	./topstream-gcov 127.0.0.1 8888 127.0.0.1 9999 &
	aflnet-replay $file TOPSTREAM 8888
	} > /dev/null 2>&1
done