#!/bin/sh

while getopts t:l:j:p:f:a:d: option
do
  case "${option}"
    in
      j) JAVA_IMAGE=${OPTARG};;
  esac
done

if [ -z "$JAVA_IMAGE" ]; then
  echo "Must specify -j for the URL to the J9 CRIU support java image."
  echo "For example, a nightly build from https://openj9-artifactory.osuosl.org/artifactory/ci-openj9/Build_JDK11_x86-64_linux_criu_Nightly/ or release from https://developer.ibm.com/languages/java/semeru-runtimes/downloads/ like https://github.com/ibmruntimes/semeru21-binaries/releases/download/jdk-21.0.6%2B7_openj9-0.49.0/ibm-semeru-open-jdk_x64_linux_21.0.6_7_openj9-0.49.0.tar.gz"
  exit 1
fi

# Install requird CRIU for InstantOn
subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms;

dnf install -y git podman maven glibc-locale-source make automake gcc gcc-c++ kernel-devel asciidoc git vim protobuf protobuf-c protobuf-c-devel protobuf-compiler protobuf-devel nftables libcap-devel libnet-devel libnl3-devel pkg-config xmlto libcap python3 python3-protobuf python3-pip ant ant-junit ant-junit5;

pip install importlib-metadata

git clone -b 0.45.0-release https://github.com/ibmruntimes/criu.git;
cd criu;
make install;

mkdir -p /etc/ld.so.conf.d/;
echo /usr/local/lib64 > /etc/ld.so.conf.d/criu.conf; \
ldconfig;

cp /usr/local/sbin/criu /usr/sbin/criu
setcap cap_checkpoint_restore,cap_sys_ptrace=eip /usr/local/sbin/criu;
setcap cap_checkpoint_restore,cap_sys_ptrace=eip /usr/sbin/criu;

cd ..;


# Install required OpenJ9 CRIU support
curl -LfSo /tmp/openjdk.tar.xz $JAVA_IMAGE

mkdir -p /opt/java/openjdk; 
tar -xf /tmp/openjdk.tar.xz --directory=/opt/java/openjdk --strip-components=1; 
rm -rf /tmp/openjdk.tar.xz;
export JAVA_HOME=/opt/java/openjdk
echo "JAVA_HOME=/opt/java/openjdk" >> /etc/environment

alternatives --install /usr/bin/java java /opt/java/openjdk/bin/java 2
alternatives --set java /opt/java/openjdk/bin/java

# clone and build latest open-liberty and run checkpoint fat
git clone https://github.com/OpenLiberty/open-liberty.git
cd open-liberty/dev
./gradlew cnf:initialize
./gradlew assemble
./gradlew io.openliberty.checkpoint_fat:buildandrun

