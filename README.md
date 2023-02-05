# Loop patches
The patches are designed for the pre-patched loop and learn version of Loop 3.0 using the Xcode build method.

You need to be in the LoopWorkspace folder when these commands are executed

## Manual Bolus Threshold
Separate suspend threshold for meal and manual bolusing, 54 mg/dL (3 mmol/L) - this value can easily be modified after the patch is applied.
```console
curl https://raw.githubusercontent.com/bjorkert/patches/master/manualBolusThreshold.patch | git apply --directory=Loop
```

## Overlaping override bug
There is a bug in Loop when it comes to overlapping overrides. If you manage to get overlapping overrides, Loop will crash and will not be able to start again until 48 hours has passed. I have made a pull request to resolve this, and the fix is available here until the pull request is approved.
```console
curl https://raw.githubusercontent.com/bjorkert/patches/master/overlappingOverride.patch | git apply --directory=LoopKit
```

## Omnipod Dash Site Change
This patch automatically updates Nightscout with a "Site Site Change"-treatment when replacing a pod. This results in updated "CAGE"-pill and pod change reminder in Loop Follow.
```console
curl https://raw.githubusercontent.com/bjorkert/patches/master/siteChange.patch | git apply --directory=OmniBLE
```


# Loop Follow patches
curl https://raw.githubusercontent.com/bjorkert/patches/master/lf_blue_line.patch| git apply 
