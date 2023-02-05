#Loop patches
The patches are designed for the pre-patched loop and learn version of Loop 3.0 using the Xcode build method.

You need to be in the LoopWorkspace folder when these commands are executed

##Manual Bolus Threshold
Separate suspend threshold for meal and manual bolusing, 54 mg/dL (3 mmol/L) - this value can easily be modified after the patch is applied.
curl https://raw.githubusercontent.com/bjorkert/patches/master/manualBolusThreshold.patch | git apply --directory=Loop



curl https://raw.githubusercontent.com/bjorkert/patches/master/lf_blue_line.patch| git apply 
