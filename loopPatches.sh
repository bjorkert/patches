#!/bin/bash
git apply --directory=Loop <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/manualBolusThreshold.patch)
git apply --directory=LoopKit <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/overlappingOverride.patch)
git apply --directory=OmniBLE <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/siteChange.patch)
