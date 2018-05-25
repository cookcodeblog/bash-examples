# Download jar from Nexus3

Since Nexus3, we can't download jar through Nexus REST API.

We have to indicate the jar path and then use `curl` or `wget` to download the jar.

When download `SNAPSHOT` jar, we have to take care of timestamp which appended in jar automatically when ran `mvn deploy`. Luckily, we can parse maven-metadata.xml to know which `SNAPSTHO` jar is the latest one. 