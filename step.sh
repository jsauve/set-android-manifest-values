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

echo 
echo "--- BEGIN Test Android Manifest Values"
echo "---------------------------------------------------"
echo
fail_count=0
package_identifier_test=$(xmlstarlet sel -t -v "/manifest/@package" "${android_manifest_path}")
if [[ $package_identifier_test != "${package_identifier}" ]]; then
	echo "--- FAIL: package_identifier did not set successfully"
	((fail_count++))
else
	echo "--- PASS: package_identifier was set successfully!"
fi
app_label_test=$(xmlstarlet sel -t -v "/manifest/application/@android:label" "${android_manifest_path}")
if [[ $app_label_test != "${app_label}" ]]; then
	echo "--- FAIL: app_label did not set successfully"
	((fail_count++))
else
	echo "--- PASS: app_label was set successfully!"
fi
version_code_test=$(xmlstarlet sel -t -v "/manifest/@android:versionCode" "${android_manifest_path}")
if [[ $version_code_test != "${version_code}" ]]; then
	echo "--- FAIL: version_code did not set successfully"
	((fail_count++))
else
	echo "--- PASS: version_code was set successfully!"
fi
version_name_test=$(xmlstarlet sel -t -v "/manifest/@android:versionName" "${android_manifest_path}")
if [[ $version_name_test != "${version_name}" ]]; then
	echo "--- FAIL: version_name did not set successfully"
	((fail_count++))
else
	echo "--- PASS: version_name was set successfully!"
fi
echo 
echo "---------------------------------------------------"
echo "--- END Test Android Manifest Values"
echo
if fail_count > 0; then
	exit 1
fi
