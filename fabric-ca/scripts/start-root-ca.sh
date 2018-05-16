#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Initialize the root CA
fabric-ca-server init -b $BOOTSTRAP_USER_PASS

#cp /data/ca-cert.pem $FABRIC_CA_SERVER_HOME/ca-cert.pem

#cp /data/ca-key.pem $FABRIC_CA_SERVER_HOME/msp/keystore/e55a6536e96e09d0af9e8499f8e8d7e26f63005275440854d4e61ab449d1eea5_sk

# Copy the root CA's signing certificate to the data directory to be used by others
cp $FABRIC_CA_SERVER_HOME/ca-cert.pem $TARGET_CERTFILE

# Add the custom orgs
for o in $FABRIC_ORGS; do
   aff=$aff"\n   $o: []"
done
aff="${aff#\\n   }"
sed -i "/affiliations:/a \\   $aff" \
   $FABRIC_CA_SERVER_HOME/fabric-ca-server-config.yaml



# Start the root CA
fabric-ca-server start
