#!/bin/bash
dconfdir=/org/gnome/terminal/legacy/profiles:


get_profile_uuid() {
    # Print the UUID linked to the profile name sent in parameter
    local profile_ids=($(dconf list $dconfdir/ | grep ^: |\
                        sed 's/\///g' | sed 's/://g'))
    local profile_name="$1"
    for i in ${!profile_ids[*]}; do
        if [[ "$(dconf read $dconfdir/:${profile_ids[i]}/visible-name)" == \
            "'$profile_name'" ]]; then
            echo "${profile_ids[i]}"
            return 0
        fi
    done
}

id=$(get_profile_uuid $1)
echo $id
