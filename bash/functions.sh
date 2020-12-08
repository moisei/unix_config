# run the container so the user and the  group are set to the current user
# timezone is set to the host timezone
# user home is maounted over container's user home
# current path becomes the current path iside of the container
function dockersh () {
    image=$1
    shell=$2
    docker run --rm -it                             \
            -v /etc/localtime:/etc/localtime:ro     \
            -v /etc/localzone:/etc/localzone:ro     \
            -v /etc/passwd:/etc/passwd:ro           \
            -v /etc/group:/etc/group:ro             \
            -u `id -u`:`id -g`                      \
            -e HOME                                 \
            -v $HOME:$HOME                          \
            -w $PWD                                 \
            --entrypoint $shell                     \
        $1
}


function ngsh ()     { dockersh 'trion/ng-cli:latest' 'bash' ; }; typeset -xf gradlesh
function nodejssh () { dockersh 'node' 'bash' ; }; typeset -xf gradlesh
function gradlesh () { dockersh 'gradle:6.2.2-jdk11' 'bash' ; }; typeset -xf gradlesh
function mvnsh ()    { dockersh 'maven:3-adoptopenjdk-11' 'bash' ; }; typeset -xf mvnsh
function pythonsh () { dockersh 'python:alpine' 'sh' ; }; typeset -xf pythonsh
function cppsh ()    { dockersh 'grpc-dev' 'bash' ; }; typeset -xf cppsh

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
