# run the container so the user and the  group are set to the current user
# timezone is set to the host timezone
# user home is maounted over container's user home
# current path becomes the current path iside of the container
# Assuming $PWD is under $HOME
function dockersh () {
    local image=$1
    local entrypoint=${2:-bash}
    local container_port=$3
    local arg_publish_port

    if [ ! -z ${3+x} ]; then
        local arg_publish_port="-p $3:$3"
    fi
    docker run --rm -it                         \
            -e HOME                                 \
            -e USER                                 \
            -e GOPATH                               \
            -v /usr/local/bin/terraform:/usr/local/bin/terraform:ro     \
            -v /etc/localtime:/etc/localtime:ro     \
            -v /etc/localzone:/etc/localzone:ro     \
            -v /etc/passwd:/etc/passwd:ro           \
            -v /etc/group:/etc/group:ro             \
            -u `id -u`:`id -g`                      \
            -v $HOME:$HOME                          \
            -w $PWD                                 \
            $arg_publish_port                       \
            --entrypoint $entrypoint                \
        $image
}
typeset -xf dockersh

function ngsh ()     { dockersh 'trion/ng-cli:latest' 'bash' '4200'; }; typeset -xf ngsh
function nodejssh () { dockersh 'node' $*; }; typeset -xf nodejssh
function tscsh ()    { dockersh 'webnews/tools/tsc:latest' $*; }; typeset -xf tscsh
function tscsh14 ()    { dockersh 'webnews/tools/tsc:14.16' $*; }; typeset -xf tscsh14
function gradlesh () { dockersh 'gradle:6.2.2-jdk11' $* ; }; typeset -xf gradlesh
function mvnsh ()    { dockersh 'maven:3-adoptopenjdk-11' $* ; }; typeset -xf mvnsh
function pythonsh () { dockersh 'python:alpine' 'sh' ; }; typeset -xf pythonsh
function gosh ()     { dockersh 'golang' $* ; }; typeset -xf gosh
function cppsh ()    { dockersh 'grpc-dev' $* ; }; typeset -xf cppsh


# https://github.com/mikefarah/yq
# a lightweight and portable command-line YAML processor
function duh () { du -hs $* | sort -h ; }; typeset -xf duh
function yq () { docker run --rm -it -v ${PWD}:/workdir mikefarah/yq yq $* ; }; typeset -xf yq

# share current folder to cifs
# function winshare () {
#     DIR=${PWD##*/}
#     CNAME=winshare-$DIR
#     docker rm -fv $CNAME &> /dev/null
#     docker run --name $CNAME -d -p 139:139 -p 445:445 \
#             -v /etc/localtime:/etc/localtime:ro     \
#             -v /etc/localzone:/etc/localzone:ro     \
#             -v /etc/passwd:/etc/passwd:ro           \
#             -v /etc/group:/etc/group:ro             \
#             -v ${PWD}:/$DIR                         \
#         dperson/samba                               \
# 			-W                                      \
#             -u "${USER};${USER};`id -u`;`id -u`;`id -g`" \
#             -s "${DIR};/${DIR};yes;no;yes;all;${USER};${USER};Share@${PWD}"
#     echo "net use \\\\`hostname -i`\\$DIR /USER:$USER $USER"
# }
function winshare () {
    DIR="${PWD##*/}"
    CONTAINER_NAME=winshare-$DIR
    # USER=$USER
    # PASSWORD=$USER
    USER="smb1"
    PASSWORD="smb1"
    LOCAL_DIR=$PWD
    REMOTE_DIR="/${DIR}"
    SHARE_NAME="SAMBA-${DIR}"
    docker rm -fv $CONTAINER_NAME &> /dev/null
    docker run --name $CONTAINER_NAME -d    \
            -p 139:139 -p 445:445           \
            -v ${LOCAL_DIR}:${REMOTE_DIR}   \
        dperson/samba                       \
            -u "${USER};${PASSWORD}"        \
            -s "${DIR};${REMOTE_DIR}" \
            -p
    echo "net use \\\\`hostname -i`\\$DIR /USER:$USER $USER"
}
typeset -xf winshare

function todel () {
    local dir="$HOME/.todel/`date +%Y-%m-%d`"
    mkdir -p "$dir"
    mv $* "$dir"
}
typeset -xf todel
