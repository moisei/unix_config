#!/bin/bash
AD_USER=mrabinovitch
# AD_PASSWORD=

###############################################################################
append_profile() {
    profile_name=$1
    role_arn=$2
(cat << END_TEMPLATE
[${profile_name}]
app_id               = 1061642
subdomain            = dalet
name                 = ${profile_name}
url                  = "https://dalet.okta.com/home/amazon_aws/0oa9uzqpknN4FFHQS357/272"
username             =
provider             = Okta
mfa                  = PUSH
skip_verify          = false
timeout              = 0
aws_urn              = urn:amazon:webservices
aws_session_duration = 36000
aws_profile          = ${profile_name}
resource_id          =
role_arn             = "${role_arn}"
region               =
http_attempts_count  =
http_retry_delay     =
credentials_file     =
saml_cache           = false
saml_cache_file      =
target_url           =

END_TEMPLATE
) >> ~/.saml2aws
}

generate_saml2aws_config() {
    rm -f ~/.saml2aws
    append_profile 'saml-master-admin'   'arn:aws:iam::614323077724:role/master_admin'
    append_profile 'saml-master-r53'     'arn:aws:iam::614323077724:role/master_r53_admin'
    append_profile 'saml-research-admin' 'arn:aws:iam::209572697859:role/research_admin_admin'
    append_profile 'saml-infra-admin'    'arn:aws:iam::894385683132:role/infrastructure_admin'
}


### main
generate_saml2aws_config

echo "AWS_DEFAULT_PROFILE: ${AWS_DEFAULT_PROFILE}"

select acc in 'saml-master-admin' 'saml-master-r53' 'saml-research-admin' 'saml-infra-admin'
do
    if [ -z ${AD_USER+x} ] ; then
        DEFAULT_USER=${USER}
        echo -n "User name without @dalet.com [${DEFAULT_USER}]: "
        read AD_USER
        AD_USER=${AD_USER:-$DEFAULT_USER}
        echo
    fi
    if [ -z ${AD_PASSWORD+x} ] ; then
        echo -n "${AD_USER}@dalet.com's Password: "
        read -s AD_PASSWORD
        echo
    fi
    saml2aws login --idp-account=$acc --force --skip-prompt --username "${AD_USER}@dalet.com" --password $AD_PASSWORD
    break;
done
