#!/bin/bash

# Download jar file from Nexus
# Because Nexus 3 doesn't provide REST API to download jar file, so we need use workaround to download it
#
# Reference: https://stackoverflow.com/questions/14783859/sonatype-nexus-rest-api-fetch-latest-build-version/39485361#39485361
#
# Usage:   ./download_snapshot_jar_from_nexus3.sh <repository_id> <group_id> <artifact_id> <version> <destination_dir>
# Example: ./download_snapshot_jar_from_nexus3.sh "maven-snapshots" "com.example" "demo" "0.0.1-SNAPSHOT" "./artifacts"


# Locate shell script path
SCRIPT_DIR=$(dirname $0)
if [ ${SCRIPT_DIR} != '.' ]
then
  cd ${SCRIPT_DIR}
fi


NEXUS_URL="http://localhost:8081/repository"
REPOSITORY_ID="$1"
GROUP_ID="$2"
ARTIFACT_ID="$3"
VERSION="$4"
DESTINATION_DIR="$5"



# Get the latest artifact version from maven-metadata.xml

# Example: http://localhost:8081/repository/maven-snapshots/com/example/demo/0.0.1-SNAPSHOT/maven-metadata.xml

GROUP_ID_URL=$(echo "${GROUP_ID}" | sed "s/\./\//g")
ARTIFACT_URL="${NEXUS_URL}/${REPOSITORY_ID}/${GROUP_ID_URL}/${ARTIFACT_ID}/${VERSION}"

MAVEN_METADATA_FILE_URL="${ARTIFACT_URL}/maven-metadata.xml"
echo "The maven-metadata.xml is ${MAVEN_METADATA_FILE_URL}"


LATEST_ARTIFACT_VERSION=$(curl -s "${MAVEN_METADATA_FILE_URL}" | \
grep "<value>.*</value>" | \
sort | uniq | head -n1 | \
sed -e "s#\(.*\)\(<value>\)\(.*\)\(</value>\)\(.*\)#\3#g")


echo "The latest artifact version is: ${LATEST_ARTIFACT_VERSION}"


# Download the jar file from Nexus

# Example: http://localhost:8081/repository/maven-snapshots/com/example/demo/0.0.1-SNAPSHOT/demo-0.0.1-20180523.040344-2.jar
LATEST_ARTIFACT_URL="${ARTIFACT_URL}/${ARTIFACT_ID}-${LATEST_ARTIFACT_VERSION}.jar"


echo "Download ${LATEST_ARTIFACT_URL} to ${DESTINATION_DIR}"
curl -o "${DESTINATION_DIR}/${ARTIFACT_ID}-${VERSION}.jar" "${LATEST_ARTIFACT_URL}"
