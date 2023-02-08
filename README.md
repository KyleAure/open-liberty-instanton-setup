# Open Liberty InstantOn Setup
Setup script for getting a development environment setup on RHEL 9.0 or Ubuntu 22.04 for Liberty InstantOn

Run the provided `instanton-setup.sh` using the `-j` option to point to a build of
the Open J9 JVM with CRIU Support.  For example a build from
https://openj9-artifactory.osuosl.org/artifactory/ci-openj9/Build_JDK11_x86-64_linux_criu_Nightly/

For example:

```
./instanton-setup.sh -j https://openj9-artifactory.osuosl.org/artifactory/ci-openj9/Build_JDK11_x86-64_linux_criu_Nightly/212/OpenJ9-JDK11-x86-64_linux_criu-20230131-012749.tar.gz
```
