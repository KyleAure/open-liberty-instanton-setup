# Open Liberty InstantOn Setup
Setup script for getting a development environment setup on RHEL 9.0 or Ubuntu 22.04 for Liberty InstantOn

Run the provided `instanton-setup.sh` using the `-j` option to point to a build of
the Semeru that includes CRIU Support.  For example, the latest Semeru Java 21 release: https://github.com/ibmruntimes/semeru21-binaries/releases/download/jdk-21.0.6%2B7_openj9-0.49.0/ibm-semeru-open-jdk_x64_linux_21.0.6_7_openj9-0.49.0.tar.gz

For example:

```
./instanton-setup.sh -j https://github.com/ibmruntimes/semeru21-binaries/releases/download/jdk-21.0.6%2B7_openj9-0.49.0/ibm-semeru-open-jdk_x64_linux_21.0.6_7_openj9-0.49.0.tar.gz
```
