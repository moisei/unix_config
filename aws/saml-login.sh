#!/bin/bash

declare -A profiles=()
profiles['saml-infra-admin']='arn:aws:iam::894385683132:role/infrastructure_admin'
profiles['saml-master-admin']='arn:aws:iam::614323077724:role/master_admin'
profiles['saml-master-r53']='arn:aws:iam::614323077724:role/master_r53_admin'
profiles['saml-research-admin']='arn:aws:iam::209572697859:role/research_admin_admin'

okta_url='https://dalet.okta.com/home/amazon_aws/0oa9uzqpknN4FFHQS357/272'
aws_region=${AWS_DEFAULT_REGION:-'us-east-1'}

profile=${SAML_PROFILE}
if [[ -z ${profile+x} ]]; then
    [[ ! -z ${AWS_DEFAULT_PROFILE+x} ]] && echo "Current AWS_DEFAULT_PROFILE is ${AWS_DEFAULT_PROFILE}"
    select profile in "${!profiles[@]}"; do
        echo "logging in AWS with $profile profile"; 
        break; 
    done
fi

user=${SAML_USER}
if [[ -z ${user+x} ]]; then
    echo -n "User name without @dalet.com [${USER:-no-default}]: "
    read user
    user=${user:-${USER}}
fi

password=${SAML_PASSWORD}
if [[ -z ${password+x} ]]; then
    echo -n "${user}'s Password: "
    read -s password
    echo
fi

SAML2AWS_IDP_PROVIDER='Okta' saml2aws login \
    --skip-prompt                           \
    --force                                 \
    --idp-account "${profile}"              \
    --username "${user}@dalet.com"       \
    --password "${password}"             \
    --profile "${profile}"                  \
    --url "${okta_url}"                     \
    --mfa 'PUSH'                            \
    --aws-urn 'urn:amazon:webservices'      \
    --session-duration '36000'              \
    --region "${aws_region}"                \
    --role "${profiles[$profile]}"
