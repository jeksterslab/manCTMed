#!/bin/bash

git clone git@github.com:jeksterslab/manCTMed.git
rm -rf "$PWD.git"
mv manCTMed/.git "$PWD"
rm -rf manCTMed
