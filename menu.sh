#!/bin/bash
function menu() {
    local name="$1"
    local patch_file="$2"
    local directory="$3"

    # Check if the patch has already been applied
    if git apply --reverse --check "${mytmpdir}/${patch_file}.patch" --directory="${directory}" >/dev/null 2>&1; then
        echo "${name} *** Patch is applied ***"
    else
        # Try to apply the patch
        if git apply --check "${mytmpdir}/${patch_file}.patch" --directory="${directory}" >/dev/null 2>&1; then
            echo "${name}" # - Patch can be applied
        else
            echo "${name} !!! Patch can't be applied !!!"
        fi
    fi
}

function apply() {
    local name="$1"
    local patch_file="${mytmpdir}/$2.patch"
    local directory="$3"
    echo 
    # Check if the patch has already been applied
    if git apply --reverse --check "${patch_file}" --directory="${directory}" >/dev/null 2>&1; then
        echo "${name} *** Patch is applied ***"
    else
        # Try to apply the patch
        if git apply --check "${patch_file}" --directory="${directory}" >/dev/null 2>&1; then
            echo "${name} - Applying..."
            git apply "${patch_file}" --directory="${directory}"
            exit_code=$?
            if [ $exit_code -eq 0 ]; then
                echo "Successful!"
            else
                echo "Failed!"
            fi
        else
            echo "${name} !!! Patch can't be applied !!!"
        fi
    fi
}

function revertmenu() {
    local name="$1"
    local patch_file="$2"
    local directory="$3"

    # Check if the patch has already been applied
    if git apply --reverse --check "${mytmpdir}/${patch_file}.patch" --directory="${directory}" >/dev/null 2>&1; then
        echo "${name}" # - Patch can be reverted
    else
        # Try to apply the patch
        if git apply --check "${mytmpdir}/${patch_file}.patch" --directory="${directory}" >/dev/null 2>&1; then
            echo "${name} *** Patch is not applied ***"
        else
            echo "${name} !!! Reverting or applying the patch is not possible !!!"
        fi
    fi
}

function revert() {
    local name="$1"
    local patch_file="${mytmpdir}/$2.patch"
    local directory="$3"
    echo 
    if git apply --reverse --check "${patch_file}" --directory="${directory}" >/dev/null 2>&1; then
        echo "${name} - Reversing..."
        git apply --reverse "${patch_file}" --directory="${directory}"
        exit_code=$?
        if [ $exit_code -eq 0 ]; then
            echo "Successful!"
        else
            echo "Failed!"
        fi
    else
        if git apply --check "${mytmpdir}/${patch_file}.patch" --directory="${directory}" >/dev/null 2>&1; then
            echo "${name} *** Patch is not applied ***"
        else
            echo "${name} !!! Reverting or applying the patch is not possible !!!"
        fi
    fi
}

function add_patch() {
    name+=("$1")
    file+=("$2")
    folder+=("$3")
}

# Deletes the temp directory
function cleanup {      
  echo "Deleting temp working directory $mytmpdir"
  rm -r "$mytmpdir"
  tput cuu1 && tput el
}

if [ "$(basename "$PWD")" != "LoopWorkspace" ]; then
    target_dir="$(find /Users/$USER/Downloads/BuildLoop -maxdepth 2 -type d -name LoopWorkspace -exec dirname {} \; -exec stat -f "%B %N" {} \; | sort -rn | awk '{print $2}' | head -n 1)"
    if [ -z "$target_dir" ]; then
        echo "Error: No folder containing LoopWorkspace found."
    else
        echo "Navigating to $target_dir"
        cd "$target_dir"
    fi
fi

echo "Loop patch selection"

# Verify current folder
if [ $(basename $PWD) = "LoopWorkspace" ]; then
    echo "Creating temporary folder"
    workingdir=$PWD
    mytmpdir=$(mktemp -d)

    # Check if tmp dir was created
    if [[ ! "$mytmpdir" || ! -d "$mytmpdir" ]]; then
        echo "Could not create temporary folder"
        exit 1
    fi
    tput cuu1 && tput el

    # Register the cleanup function to be called on the EXIT signal
    trap cleanup EXIT

    #DEBUG
    #echo $mytmpdir

    #Declare all patches
    #Using simple arrays since bash 3 which is shipped with mac does not support associative arrays
    name=()
    file=()
    folder=()

    add_patch "Manual bolus threshold" "manualBolusThreshold" "Loop"
    add_patch "Omnipod Dash Site Change" "siteChange" "OmniBLE"
    add_patch "Dexcom G6 - Sensor Change" "g6_sensor_start" "CGMBLEKit"
    add_patch "Dexcom G6 - Upload Readings" "upload_readings" "CGMBLEKit"
    add_patch "View PreMeal in Nightscout" "preMeal" "Loop"
    add_patch "Future carbs 90 minutes" "90m" "Loop"
    add_patch "Required carbs" "updateRequiredCarbs" ""

    echo "Downloading patches, please wait..."
    cd $mytmpdir
    for i in ${!name[@]}
    do
        curl -fsSLOJ "https://raw.githubusercontent.com/bjorkert/patches/master/${file[$i]}.patch"
    done
    tput cuu1 && tput el

    cd $workingdir

    while true; do
        echo
        echo "Select a patch you want to apply:"
        echo "a) Apply all patches"
        for i in ${!name[@]}
        do
            menu "${i}) ${name[$i]}" "${file[$i]}" "${folder[$i]}";
        done        

        echo "r) Revert a patch"
        echo "q) Quit"

        read -p "Enter your choice: " choice
        if [[ $choice =~ ^[0-9]+$ && $choice -ge 0 && $choice -lt ${#name[@]} ]]; then
            apply "${name[$choice]}" "${file[$choice]}" "${folder[$choice]}";
        elif [[ $choice == "r" ]]; then
            echo 
            echo "Select a patch to revert:"
            for i in ${!name[@]}
            do
                revertmenu "${i}) ${name[$i]}" "${file[$i]}" "${folder[$i]}";
            done        
            echo "*) Any other key will exit to last menu"
            read -p "Enter your choice: " choice
            if [[ $choice =~ ^[0-9]+$ && $choice -ge 0 && $choice -lt ${#name[@]} ]]; then
                revert "${name[$choice]}" "${file[$choice]}" "${folder[$choice]}";
            fi
        elif [[ $choice == "a" ]]; then
            for i in ${!name[@]}
            do
                apply "${name[$i]}" "${file[$i]}" "${folder[$i]}";
            done        
        elif [[ $choice == "q" ]]; then
            exit 0
        else
            echo
            echo "Invalid choice. Try again."
        fi
    done
else
    exit 1
fi
