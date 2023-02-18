#!/bin/zsh
git apply --directory=Loop <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/manualBolusThreshold.patch)
git apply --directory=LoopKit <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/overlappingOverride.patch)
git apply --directory=OmniBLE <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/siteChange.patch)
git apply --directory=CGMBLEKit <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/g6_sensor_start.patch)
git apply --directory=CGMBLEKit <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/upload_readings.patch)
git apply --directory=Loop <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/preMeal.patch)
