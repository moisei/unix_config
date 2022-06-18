#!/bin/bash

declare -A profiles=()
profiles['saml-infra-admin']='arn:aws:iam::894385683132:role/infrastructure_admin'
profiles['saml-master-admin']='arn:aws:iam::614323077724:role/master_admin'
profiles['saml-master-r53']='arn:aws:iam::614323077724:role/master_r53_admin'
profiles['saml-research-admin']='arn:aws:iam::209572697859:role/research_admin_admin'

okta_url='https://dalet.okta.com/home/amazon_aws/0oa9uzqpknN4FFHQS357/272'
aws_region=${AWS_DEFAULT_REGION:-'us-east-1'}

if [[ ! -z ${AWS_DEFAULT_PROFILE+x} ]]; then
  echo "Current AWS_DEFAULT_PROFILE is ${AWS_DEFAULT_PROFILE}"
fi

if [[ ! -z ${SAML_PROFILE+x} ]]; then
    profile=${SAML_PROFILE}
else
    select profile in "${!profiles[@]}"; do echo "logging in AWS with $profile profile"; break; done
fi

if [ -z ${AD_USER+x} ] ; then
    echo -n "User name without @dalet.com [${USER:-no-default}]: "
    read AD_USER
    AD_USER=${AD_USER:-${USER}}
fi
if [ -z ${AD_PASSWORD+x} ] ; then
    echo -n "${AD_USER}'s Password: "
    read -s AD_PASSWORD
    echo
fi

SAML2AWS_IDP_PROVIDER='Okta' saml2aws login                          \
    --skip-prompt                       \
    --force                             \
    --idp-account "${profile}"     \
    --username "${AD_USER}@dalet.com"   \
    --password "${AD_PASSWORD}"         \
    --profile "${profile}"         \
    --url "${okta_url}"                 \
    --mfa 'PUSH'                        \
    --aws-urn 'urn:amazon:webservices'  \
    --session-duration '36000'          \
    --region "${aws_region}"            \
    --role "${profiles[$profile]}"
