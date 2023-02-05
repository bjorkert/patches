# Loop patches
These patches are designed for the pre-patched loop and learn version of Loop 3.0 using the Xcode build method.

You need to be in the "LoopWorkspace" folder when these commands are executed.

## Manual Bolus Threshold
Separate suspend threshold for meal and manual bolusing, 54 mg/dL (3 mmol/L) - this value can easily be modified after the patch is applied.
```console
git apply --directory=Loop <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/manualBolusThreshold.patch)
```

## Overlapping override bug
There is a bug in Loop when it comes to overlapping overrides. If you manage to get overlapping overrides, Loop will crash and will not be able to start again until 48 hours has passed. I have made a pull request to resolve this (https://github.com/LoopKit/LoopKit/pull/449), a fix is available here until the pull request is approved.
```console
git apply --directory=LoopKit <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/overlappingOverride.patch)
```

## Omnipod Dash Site Change
This patch automatically updates Nightscout with a "Pump Site Change"-treatment when replacing a pod. This results in updated "CAGE"-pill and pod change reminder in Loop Follow.
```console
git apply --directory=OmniBLE <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/siteChange.patch)
```

# Loop Follow patches
These patches are designed for the dev branch of Loop Follow using the Xcode build method.

You need to be in the "LoopFollow" folder when these commands are executed.

## Blue Line -30 minutes
A blue line 30 minutes back in time to get a clearer view of what boluses has started to give effect.
I described it in this issue, resulted in some modifications but but the blue line. https://github.com/jonfawcett/LoopFollow/issues/110
```console
git apply <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/lf_blue_line.patch)
```

## Protein line -90 minutes
Another line, this one 90 minutes back in time to get an indication of if a meal is causing a bs raise 90 minutes later due to protein.
```console
git apply <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/proteinLine.patch)
```

## Duplicate blood glucose entries
Loop 3 is uploading duplicate svg entries, this messes up the LoopFollow graphs and statistics. This can also happen if you have both bridge enabled in nightscout as well as Loop "upload readings". This patch solves that problem by filtering out 1 reading per 5 minutes. I have made a pull request for this fix: https://github.com/jonfawcett/LoopFollow/pull/178
```console
git apply <<< $(curl -s https://raw.githubusercontent.com/bjorkert/patches/master/removeSVGDuplicates.patch)
```