#!/usr/bin/env bash

# Replace '.' with '/' in a string
# Example: replace "aa.bb.cc" to "aa/bb/cc"
GROUP_ID_URL=$(echo "${GROUP_ID}" | sed "s/\./\//g")

# Replace text in a file
# Example: Replace placeholder "MAVEN_POM_VERSION" with its value in a file named Dockerfile
sed -i "s/MAVEN_POM_VERSION/${MAVEN_POM_VERSION}/g" Dockerfile
