# Loop patches
These patches are intended for Loop 3.0 or 3.2, with or without loop n learn patches.  
If you are missing a patch here, head over to LnL since some has been moved there.

## How to apply a patch when building with Xcode:
First, download Loop by using the loop and learn build script described here: https://www.loopandlearn.org/build-select/

### To select apply (or revert) patches, run the following command:
```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bjorkert/patches/master/menu.sh)"
```
Copy the command using the copy-button (as shown in the picture below), paste (⌘ V) it into your terminal, and press Enter.
 
![Loop](img/copy_command.png)

## How to apply a patch when building with github:
Use this page to select the patches you want:  
https://htmlpreview.github.io/?https://github.com/bjorkert/patches/blob/master/loop_patches.html  
Copy the code using the copy-button
In github, edit ".github/workflows/build_loop.yml" and paste the code there.  
Make sure "- name: Customize Loop..." is not already in the file, in that case remove the duplicate.

&nbsp;

## Manual Bolus Threshold
This patch provides a separate suspend threshold for meal and manual bolusing at 54 mg/dL (3 mmol/L), which can be easily modified after applying the patch.
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
## Dash Fast Forward
When pairing a new pod, the abundance of unnecessary clicks and confirmations in Loop 3.x can be quite cumbersome. As an experienced looper, you likely breeze through them as quickly as possible without actually reading them. This patch streamlines the process by eliminating the unnecessary dialogs and retaining only the essential ones—"Pair Pod" and "Insert Cannula"—where actual actions take place. As a result, the patch effectively reduces clicks and enhances the user experience.
&nbsp;
## Basic I:C Bolus Calculation
**Please note that this patch is still in testing and may receive changes.**

The patch introduces a new feature in the meal bolus screen that presents a basic calculation for an insulin-to-carb (I:C) bolus that does not factor in the glucose prediction. This feature provides users with decision support for manually adjusting their bolus based on their personal experience. An example of when this feature could be useful is if a user has recently treated a low or trending low without entering the treatment into Loop. In such a scenario, Loop may underestimate the amount of insulin needed for a meal and even recommend against bolusing - Loop would then wait with the insulin until blood glucose rises, possibly resulting in a spike.

The Basic I:C Bolus Calc row displays the calculated bolus based on the user's insulin-to-carb ratio, the entered carbohydrates, and existing carbs on board. It ignores current bg value, glucose predictions, and override, but considers positive insulin on board (IOB) and ignores negative IOB to avoid over-bolusing. The suggested bolus value is displayed in red, indicating that it is calculated differently from Loop's default recommendation.

>**Warning: This feature is designed as a basic calculation tool and does not consider all factors that may affect blood sugar levels. The calculated bolus provided by the "Basic I:C Bolus Calc" is _not_ a recommended bolus and the feature may not be suitable for all users. Giving too much insulin can be dangerous and cause low blood sugar levels. Always consult with your healthcare provider before making any changes to your diabetes management plan.**

To use this feature, tap the "Basic I:C Bolus Calc" row, and the app will update the bolus entry field with the calculated value. Users can then if desired adjust the value and deliver the bolus. Loop's normal calculation and recommendation remains the default. There are scenarios where Loop would recommend more insulin than the basic calculation, such as when the blood glucose value is too high and Loop includes a correction in the dosage.

Calculation Example:  
Assume a user has an insulin-to-carb ratio of 1:10. They enter a meal with 50 grams of carbohydrates, their current positive IOB is 1 unit, and they have 20 grams of carbs on board. Using the Basic I:C Bolus Calc, the calculation would be as follows:  
Total carbs: 50 grams of entered carbs + 20 grams of carbs on board = 70 grams  
Unadjusted bolus: 70 grams of total carbs / 10 (I:C ratio) = 7 units of insulin  
Bolus with IOB: 7 units (unadjusted) - 1 unit (positive IOB) = 6 units  
The Basic I:C Bolus Calc would show a 6-unit bolus value.

Additionally, this patch restores the feature to click on Loop's recommended value to copy it to the entered bolus value. This feature was removed in Loop 3.
&nbsp;
## 2 hours Lolipop
This patch reverts the carb absorption time for the lollipop (fast) icon in Loop 3 to its original value of 2 hours, which was used in Loop 2. The other default carb absorption times remain unchanged, so the taco (medium) icon remains at 3 hours, and the pizza (slow) icon remains at 5 hours, which is the same as in Loop 3. It's worth noting that Loop 2 had a carb absorption time of 4 hours for the pizza (slow) icon.
&nbsp;
&nbsp;
# Loop Follow patches
These patches are intended for the development branch of Loop Follow.
## How to apply a patch:
First, download Loop Follow dev by using the loop and learn build script described here: https://www.loopandlearn.org/build-select/
### Run the command below to select the patches you want to apply or revert
```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bjorkert/patches/master/lf.sh)"
```
Please use the copy-button (as shown in the picture below) to copy the command, then paste it (⌘ V) into your terminal and press Enter.

![Loop](img/copy_command.png)

## PreMeal
The graph displays the PreMeal period as an orange band located below the green override band.
&nbsp;
