#!/bin/bash

# Download jar file from Nexus
# Because Nexus 3 doesn't provide REST API to download jar file, so we need use workaround to download it
#
# Reference: https://stackoverflow.com/questions/14783859/sonatype-nexus-rest-api-fetch-latest-build-version/39485361#39485361
#
# Usage:   ./download_jar_from_nexus3.sh <repository_id> <group_id> <artifact_id> <version> <destination_dir>
# Example: ./download_jar_from_nexus3.sh "maven-snapshots" "com.example" "demo" "2.0.0" "./artifacts"


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

GROUP_ID_URL=$(echo "${GROUP_ID}" | sed "s/\./\//g")
ARTIFACT_URL="${NEXUS_URL}/${REPOSITORY_ID}/${GROUP_ID_URL}/${ARTIFACT_ID}/${VERSION}"


# Download the jar file from Nexus
# Example: http://localhost:8081/repository/maven-releases/com/example/demo/2.0.0/demo-2.0.0.jar
LATEST_ARTIFACT_URL="${ARTIFACT_URL}/${ARTIFACT_ID}-${VERSION}.jar"


echo "Download ${LATEST_ARTIFACT_URL} to ${DESTINATION_DIR}"
curl -o "${DESTINATION_DIR}/${ARTIFACT_ID}-${VERSION}.jar" "${LATEST_ARTIFACT_URL}"
