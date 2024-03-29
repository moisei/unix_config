#!/bin/bash

declare -A profiles=()
profiles['saml-research-dev']='arn:aws:iam::209572697859:role/research_admin_dev'
profiles['saml-master-r53']='arn:aws:iam::614323077724:role/master_r53_admin'
# profiles['saml-infra-admin']='arn:aws:iam::894385683132:role/infrastructure_admin'
# profiles['saml-master-admin']='arn:aws:iam::614323077724:role/master_admin'
# profiles['saml-research-admin']='arn:aws:iam::209572697859:role/research_admin_admin'
profiles['saml-storefront-admin']='arn:aws:iam::474346169220:role/store_front_dev_admin'

okta_url='https://dalet.okta.com/home/amazon_aws/0oa9uzqpknN4FFHQS357/272'
LAST_LOGIN_ENV_FILE="${HOME}/.saml-login-last"


[ -f "${LAST_LOGIN_ENV_FILE}" ] && source $LAST_LOGIN_ENV_FILE

aws_region=${AWS_DEFAULT_REGION:-'us-east-1'}
profile=${SAML_PROFILE}
if [[ -z ${profile} ]]; then
    [[ ! -z ${AWS_DEFAULT_PROFILE} ]] && echo "Current AWS_DEFAULT_PROFILE is ${AWS_DEFAULT_PROFILE}"
    select profile in "${!profiles[@]}"; do
        echo "logging in AWS with $profile profile";
        break;
    done
fi

user=${SAML_USER}
if [[ -z ${user} ]]; then
    echo -n "User name without @dalet.com [${USER:-no-default}]: "
    read user
    user=${user:-${USER}}
fi

password=${SAML_PASSWORD}
if [[ -z ${password} ]]; then
    echo -n "${user}'s Password: "
    read -s password
    echo
fi

rm -f "${LAST_LOGIN_ENV_FILE}"
echo "LAST_SAML_AWS_REGION=${aws_region}" >> "${LAST_LOGIN_ENV_FILE}"
echo "LAST_SAML_PROFILE=${profile}" >> "${LAST_LOGIN_ENV_FILE}"
echo "LAST_SAML_USER=${user}" >> "${LAST_LOGIN_ENV_FILE}"

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
