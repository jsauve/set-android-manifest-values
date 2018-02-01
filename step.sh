#!/bin/bash

set -e

if [[ "${android_manifest_path}" != "" ]]; then

    if [[ ! -f "${android_manifest_path}" ]]; then 
        echo
        echo "--- File does not exist at path: ${android_manifest_path}"
        echo "--- Terminating..."
        echo

        exit 1
    fi

    echo
    echo "-- Android manifest path: ${android_manifest_path}"
    echo

    if [[ "${package_identifier}" != "" ]]; then

        package_identifier_orig=$(xmlstarlet sel -t -v "/manifest/@package" "${android_manifest_path}")
        bash -c "$(xmlstarlet ed --inplace -u "/manifest/@package" -v "${package_identifier}"  "${android_manifest_path}")"
        package_identifier_new=$(xmlstarlet sel -t -v "/manifest/@package" "${android_manifest_path}")

        echo
        echo "Replaced 'package' attribute value of <manifest> xml node:"
        echo "---------------------------------------------------"
        echo "--- Old value: $package_identifier_orig"
        echo "--- New Value: $package_identifier_new"
        echo
    fi

    if [[ "${app_label}" != "" ]]; then

        app_label_orig=$(xmlstarlet sel -t -v "/manifest/application/@android:label" "${android_manifest_path}")
        bash -c "$(xmlstarlet ed --inplace -u "/manifest/application/@android:label" -v "${app_label}"  "${android_manifest_path}")"
        app_label_new=$(xmlstarlet sel -t -v "/manifest/application/@android:label" "${android_manifest_path}")

        echo
        echo "Replaced 'android:label' attribute value of <application> xml node:"
        echo "---------------------------------------------------"
        echo "--- Old value: $app_label_orig"
        echo "--- New Value: $app_label_new"
        echo
    fi

    if [[ "${version_code}" != "" ]]; then

        version_code_orig=$(xmlstarlet sel -t -v "/manifest/@android:versionCode" "${android_manifest_path}")
        bash -c "$(xmlstarlet ed --inplace -u "/manifest/@android:versionCode" -v "${version_code}"  "${android_manifest_path}")"
        version_code_new=$(xmlstarlet sel -t -v "/manifest/@android:versionCode" "${android_manifest_path}")

        echo
        echo "Replaced 'android:versionCode' attribute value of <manifest> xml node:"
        echo "---------------------------------------------------"
        echo "--- Old value: $version_code_orig"
        echo "--- New Value: $version_code_new"
        echo
    fi

    if [[ "${version_name}" != "" ]]; then

        version_name_orig=$(xmlstarlet sel -t -v "/manifest/@android:versionName" "${android_manifest_path}")
        bash -c "$(xmlstarlet ed --inplace -u "/manifest/@android:versionName" -v "${version_name}"  "${android_manifest_path}")"
        version_name_new=$(xmlstarlet sel -t -v "/manifest/@android:versionName" "${android_manifest_path}")

        echo
        echo "Replaced 'android:versionName' attribute value of <manifest> xml node:"
        echo "---------------------------------------------------"
        echo "--- Old value: $version_name_orig"
        echo "--- New Value: $version_name_new"
        echo
    fi

fi
