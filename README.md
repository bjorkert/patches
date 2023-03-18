# Loop patches
These patches are intended for Loop 3.0 or 3.2, with or without loop n learn patches.

## How to apply a patch:
First, download Loop by using the loop and learn build script described here: https://www.loopandlearn.org/build-select/

### To select apply (or revert) patches, run the following command:
```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bjorkert/patches/master/menu.sh)"
```
Copy the command using the copy-button (as shown in the picture below), paste (⌘ V) it into your terminal, and press Enter.
 
![Loop](img/copy_command.png)

&nbsp;

## Manual Bolus Threshold
This patch provides a separate suspend threshold for meal and manual bolusing at 54 mg/dL (3 mmol/L), which can be easily modified after applying the patch.
&nbsp;
## Omnipod Dash Site Change
When replacing a pod, this patch ensures that Loop updates Nightscout with a 'Pump Site Change'-treatment, resulting in an updated 'CAGE'-pill and pod change reminder in Loop Follow. Please note that this will happen on the next pod change after the patch is applied, and the date of current pod will not be updated.
&nbsp;
## Dexcom G6 - Sensor Change
When replacing a sensor, this patch ensures that Loop updates Nightscout with a 'Sensor Change' treatment, resulting in an updated 'SAGE' pill and a sensor change reminder in Loop Follow. Please note that the start date of the current sensor will be populated.
&nbsp;
## Dexcom G6 - Upload Readings
This patch automatically sets the 'Upload readings' option to 'On' by default when changing the transmitter. This change addresses the common issue of users forgetting to change the setting, resulting in no blood sugar values being sent to Nightscout.
&nbsp;
## View PreMeal in Nightscout
Due to overrides now being combinable with PreMeal, PreMeal is no longer sent as an override to Nightscout, leaving Nightscout without any indication that PreMeal is active. This patch addresses this issue by sending a Temporary target to Nightscout when PreMeal is turned on, resulting in a visual band in Nightscout to indicate that PreMeal is active. When PreMeal is turned off, the temporary target band is also ended.
&nbsp;
## Future carbs 90 minutes
This patch makes it possible to enter carbs 90 minutes into the future in order to register carbs for protein and fat. Loop 3 limits the future time change allowed to 1 hour. Remember that Loop may increase insulin dosing for future carbs - make sure that they actually arrive and are not already taken care of by your basal.
&nbsp;
## Display Required Carbs on App Badge
Install this patch to see a small number on your Loop app badge, indicating the predicted amount of glucose needed to maintain your target range. This value is calculated using your current Carb Ratio (CR) and Insulin Sensitivity Factor (ISF). The code originates from the latest FreeAPS version and should not be impacted by the time zone bug.
&nbsp;
&nbsp;
# Loop Follow patches
These patches are intended for the development branch of Loop Follow and can be built using the Xcode build method.
## How to apply a patch:
First, download Loop Follow dev by using the loop and learn build script described here: https://www.loopandlearn.org/build-select/

After downloading Loop Follow, navigate to the directory where Loop Follow was downloaded. Please note that the following command is just an example, and you will need to modify the command to reflect the actual directory where Loop Follow was downloaded:
```console
cd ~/Downloads/BuildLoopFollow/LoopFollow-Dev-230226-1601/LoopFollow
```

### Run the command below to select the patches you want to apply or revert
```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bjorkert/patches/master/lf.sh)"
```
Please use the copy-button (as shown in the picture below) to copy the command, then paste it (⌘ V) into your terminal and press Enter.

![Loop](img/copy_command.png)

## Blue Line -30 minutes
A blue line is added 30 minutes prior to the current time to provide a clearer view of the boluses that have started to take effect.
I described it in this issue, resulted in some modifications but not the blue line. https://github.com/jonfawcett/LoopFollow/issues/110
&nbsp;
## Protein line -90 minutes
An additional line is added to the graph 90 minutes prior to the current time to indicate if a meal is causing a blood sugar rise 90 minutes later, which may be due to protein that typically takes about 90 minutes to show its effects.
&nbsp;
## Duplicate blood glucose entries
Loop 3 may upload duplicate svg entries, which can cause issues with LoopFollow's graphs and statistics. This issue may also arise when both bridge is enabled in Nightscout and Loop 'upload readings' are used. This patch resolves the issue by filtering out one reading every five minutes. I have submitted a pull request for this fix, which can be found at https://github.com/jonfawcett/LoopFollow/pull/178.
&nbsp;
## Carbs Today
This patch adds a new item to the 'Information Table' called 'Carbs Today.' This feature provides a sum of all registered carbs since midnight to help you keep track of your child's carb intake for the day. However, please note that this feature may not be useful if you are using fake carbs.
## PreMeal
The graph displays the PreMeal period as an orange band located below the green override band.