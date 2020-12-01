#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

# This is a collection of bash functions used by different scripts

ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/xkeycloak.com/orderers/orderer.xkeycloak.com/msp/tlscacerts/tlsca.xkeycloak.com-cert.pem
PEER0_ORG1_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.xkeycloak.com/peers/peer0.org1.xkeycloak.com/tls/ca.crt
PEER0_ORG2_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.xkeycloak.com/peers/peer0.org2.xkeycloak.com/tls/ca.crt
PEER0_ORG3_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org3.xkeycloak.com/peers/peer0.org3.xkeycloak.com/tls/ca.crt

# Set OrdererOrg.Admin globals
setOrdererGlobals() {
  CORE_PEER_LOCALMSPID="OrdererMSP"
  CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/xkeycloak.com/orderers/orderer.xkeycloak.com/msp/tlscacerts/tlsca.xkeycloak.com-cert.pem
  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/xkeycloak.com/users/Admin@xkeycloak.com/msp
}

# Set environment variables for the peer org
setGlobals() {
  ORG=$1
  if [ $ORG -eq 1 ]; then
    CORE_PEER_LOCALMSPID="Org1MSP"
    CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.xkeycloak.com/users/Admin@org1.xkeycloak.com/msp
    CORE_PEER_ADDRESS=peer0.org1.xkeycloak.com:7051
  elif [ $ORG -eq 2 ]; then
    CORE_PEER_LOCALMSPID="Org2MSP"
    CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.xkeycloak.com/users/Admin@org2.xkeycloak.com/msp
    CORE_PEER_ADDRESS=peer0.org2.xkeycloak.com:9051
  elif [ $ORG -eq 3 ]; then
    CORE_PEER_LOCALMSPID="Org3MSP"
    CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org3.xkeycloak.com/users/Admin@org3.xkeycloak.com/msp
    CORE_PEER_ADDRESS=peer0.org3.xkeycloak.com:11051
  else
    echo "================== ERROR !!! ORG Unknown =================="
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    echo "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
    echo
    exit 1
  fi
}
