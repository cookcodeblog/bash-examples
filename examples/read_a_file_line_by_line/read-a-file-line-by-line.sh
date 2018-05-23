#!/usr/bin/env bash


# Read a file line by line
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Read line: ${line}"
done < "${BUILD_FILE}"


# Read a file line by line, and ignore lines start with '#' and empty lines
while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" != \#* && "$line" != "" ]]
    then
        echo "Downloading component: ${line}"
	    ./download_component_from_nexus3.sh "${line}" ""
    fi
done < "${BUILD_FILE}"