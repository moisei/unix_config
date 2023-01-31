USER_CFG_DIR=$HOME/.config_private

# bash
alias a="alias"
# a docker='podman'
alias ra="source $USER_CFG_DIR/bash/aliases.sh"
alias ef="nano $USER_CFG_DIR/bash/functions.sh"
alias ea="nano $USER_CFG_DIR/bash/aliases.sh"

alias del="rm"
alias ren="mv"
alias rmdir="rm -rf"

alias g="grep"
alias gi="grep -i"
alias gv="grep -v"
alias gvi="grep -vi"

alias +="more"

alias cd..="cd .."

alias cls='clear'

alias h='history'
alias hg='history | grep -i'
#alias hg5='hg | tail -n 5'
#alias hg1='hg | tail -n 1'

# git
alias gst='git status'
# alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'
alias gl='git log --pretty=format:"%C(White)%h%C(Yellow)  %an%C(Green) %ad %C(White)%s" --name-status --date=format:"%d-%m-%Y %H:%M:%S"'

alias ga='(git config --get-regexp alias | sed -r s/"alias\.([^ ]+) (.*)"/"git \1\t\2"/ & alias | grep git) | sort'
alias gag='ga | grep'
alias gorig='git remote get-url origin'

# todo github new repo: ghnew() { curl -u 'moisei' https://api.github.com/user/repos -d '{"name":"askbot-devel"}' ;}

alias grepo='git init; git config user.email "moisei@nowhere.com"; git config user.name "Moisei"'
alias grepobb='git init; git config user.email "mrabinovitch@dalet.com"; git config user.name "Moisei Rabinovich"'

# docker

# Docker Machine
# alias docker='sudo docker'

alias dmachine='cd ~/Downloads/dmachine'
alias dm='docker-machine'
alias dml='docker-machine ls'
alias devstar='docker-machine start dev'
alias denv='env | grep  DOCKER'
alias dkenv='eval "$(sudo docker-machine env dev)"'
alias dmc='docker-machine create'
alias dmip='docker-machine ip'
alias dmub='docker run -d -p ubuntu /bin/bash'
alias dmstar='docker-machine start'
alias dmstop='docker-machine stop'
alias mstar='docker-machine start'
alias mstop='docker-machine stop'
dmeval_f() { eval "$(docker-machine env $@)" ;}
alias dmeval='dmeval_f'
alias dm-recert='docker-machine ls -q | xargs docker-machine regenerate-certs -f'


#Get IP addresses
dockexecl() { docker exec -i -t $(docker ps -l -q) bash ;}
exec_dbash() { docker exec -i -t $@ bash ;}
exec_sh() { docker exec -i -t $@ sh ;}
bash_onetime() { docker run -it --rm $@ /bin/bash ;}
sh_onetime() { docker run -it --rm $@ /bin/sh ;}
#dock_run_exec() { docker rm -fv $@; docker run -d --name $@ $@ && sleep 2 && docker exec -it $@ /bin/bash ;}
#alias drbash='dock_run_exec'
alias dbash='exec_dbash'
alias dsh='exec_sh'
alias dbash1='bash_onetime'
alias dsh1='sh_onetime'

alias dockip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias dockipl='docker inspect --format "{{ .NetworkSettings.IPAddress }}" $(docker ps -q)'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias dipl='docker inspect --format "{{ .NetworkSettings.IPAddress }}" $(docker ps -q)'

# Start/Stop the last container created
alias mstar1='docker-machine start $(docker-machine ls | tail -1 | awk "{print $1}")'
alias mstop1='docker-machine stop $(docker-machine ls | tail -1 | awk "{print $1}")'
alias dmk='docker-machine kill'

# Inspect the last container created
alias dmin='docker-machine inspect $(docker-machine ls | tail -1 | awk "{print $1}")'

# Remove the last container created
alias dmrm='docker-machine rm $(docker-machine ls | tail -1 | awk "{print $1}")'

# Docker Engine aliases
alias d='docker'
alias di='docker images'
alias di5='docker images | head -n5'
alias dlg='docker logs'
alias dlgf='docker logs -f'
alias drmi='docker rmi'
alias drm='docker rm'
alias drmf='docker rm -fv'
alias dls='docker ps -a'
alias dlsl='docker ps -l'
alias dac='docker attach'

# Inspect the last container created
alias dmin='docker-machine inspect $(docker-machine ls | tail -1 | awk "{print $1}")'
# Delete all containers matching the passed paramater
# Example: "delcon ubuntu" or 'anything matching in docker ps output'
delcon() { docker rm -f $(docker ps  -a | grep $@ | awk '{print $1}') ;}
# Stop all containers matching the passed paramater.
stopcon() { docker stop $(docker ps  -a | grep $@ | awk '{print $1}') ;}
alias da='docker attach --sig-proxy=false'
alias dstop='docker stop'
alias dstart='docker start'
alias dins='docker inspect'
alias dp='docker port $(docker ps -l -q)'
dvp_f() { docker volume inspect $@ | grep Mountpoint | cut -d '"' -f 4 ; }
alias dvp='dvp_f'
alias db='docker build -t'
alias dbc='docker build -t --no-cache'
#alias drm='docker ps -l -q | xargs docker stop | xargs docker rm'

alias dexec='docker exec'
dexl() { docker exec -i -t $(docker ps -l -q)  bash ;}
dex() { docker exec -i -t $@ /bin/bash ;}
alias dbash='dex'
#dbash() {docker exec -it $@ bash --init-file <(echo ". \"$HOME/.bashrc\"; export TERM=xterm")}
alias dlog='docker logs $(docker ps -l -q)'
alias drun='docker run -i -t -name'
alias dport='docker port $(docker ps -l -q)'

# On demand foreground OS bash shells that delete on shell exit
alias ubunturm='docker run -it --rm ubuntu'
alias debianrm='docker run -it --rm debian'
alias fedorarm='docker run -it --rm fedora'
alias centosrm='docker run -it --rm centos'
alias busyrm='docker run -it --rm busybox'
alias nethostrm='docker run -it --rm --net=host ubuntu'

# On demand foreground OS bash shells that stops on shell exit
alias ubuntu='docker run -it ubuntu'
alias debian='docker run -it debian'
alias fedora='docker run -it fedora'
alias busy='docker run -it busybox'
alias nethost='docker run -it --net=host ubuntu'

# On demand background OS bash shells running in daemon mode
alias ubuntud='docker run -itd ubuntu'
alias debiand='docker run -itd debian'
alias fedorad='docker run -itd fedora'
alias busyd='docker run -itd busybox'

# Delete all containers matching the passed paramater
delimg() { docker rmi $(docker images | grep $@ | awk '{print $3}') ;}
# Delete all with a <none> label
delnone() { docker rmi $(docker images | grep none | awk '{print $3}') ;}


a dps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}' | sed 's/0.0.0.0://g' | sed 's/\/tcp//g' |  sed 's/\/udp//g'"
a dpsa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}" | sed "s/0.0.0.0://g" | sed "s/\/tcp//g" |  sed "s/\/udp//g" | (read -r; printf "%s\n" "$REPLY"; sort -k 2,2 -k 1,1 -r)'

f_dsl() { docker start $@ && docker logs -f $@ ;}
alias dsl='f_dsl'

alias dc='docker-compose'
alias dcup='dc up -d'
alias dcdown='dc down'
alias dcdownf='dc down -v --remove-orphans'
alias dcreup='dcdown; dcup'
alias dcreupb='dcdown; dcup --build'
alias dcreupf='dcdownf; dcup'
alias dclf='dc logs -f'

alias ds='docker service'

alias ll='LC_COLLATE=C ls -alF'
alias l='LC_COLLATE=C ls -lF'
alias lld='ll --group-directories-first'
alias ld='l --group-directories-first'
alias lg='l | g'

alias duh='du -h * | sort -n'
alias duhs='du -sh * | sort -n'


alias df='df -h'
alias df.='df -h .'
alias deld='rm -rf'
alias ag='alias | grep'
alias psg='ps -aef | grep'
alias pg='pgrep -af'
alias subgit='docker run --rm -v $PWD:$PWD -w $PWD "dalet/subgit:1" subgit'

alias gita='git -C $USER_CFG_DIR'
alias pa='gita commit -a -m "." && gita push'
alias ua='gita pull'

alias route_to_max='sudo route add -net 172.17.1.0 netmask 255.255.255.0 gw 172.18.1.1'

# aws creds from file
a awsf='docker run --rm -v $(pwd):/aws -v ~/.aws:/root/.aws mikesir87/aws-cli aws'
# aws shell
# a awss='docker run --rm -it -e AD_EMAIL -e AD_PASSWORD -v $(pwd):/aws -v ~/.aws:/root/.aws mikesir87/aws-cli'
a awss='docker run --rm -it -e AD_EMAIL -e AD_PASSWORD -v $(pwd):/aws -w /aws -v ~/.aws:/root/.aws --entrypoint bash amazon/aws-cli'
# aws creds from env
a awse='docker run --rm -e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-east-1} -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} -v $(pwd):/aws mikesir87/aws-cli aws'
a awswhoami='aws sts get-caller-identity'

# mount s3 bucket dalet-sandbox to /mnt/mydata
a s3mount='sudo umount /mnt/s3fs &> /dev/null; docker rm -fv s3fs &> /dev/null; docker run -d --name s3fs -v ~/.s3fs:/root/.s3fs --security-opt apparmor:unconfined --cap-add mknod --cap-add sys_admin --device=/dev/fuse -v /mnt/s3fs:/mnt/mydata:shared xueshanf/s3fs /usr/bin/s3fs -f -o allow_other -o use_cache=/tmp -o passwd_file=/root/.s3fs -o use_path_request_style  'dalet-sandbox' /mnt/mydata'
# jq from docker container
a jqd='docker run -i --rm mwendler/jq'
a jq.='jq -C -S "."'
# docker inspect pretty print
dinsp() (for c in `docker ps -a --format {{.Names}} | grep "$@"`; do echo $c; docker inspect --format="{{json .Config}}" $c | jq -C -S "."; done)

dex() { docker exec -i -t $@ /bin/bash ;}

title() { export PS_SAVE=$PS1; PS_SAVE='`pwd` # '; echo -e '\033]2;'$1'\007' ;}

# ssh from .ssh dir
sshl() { pushd ~/.ssh; eval "ssh $*"; popd ;}
a wa='watch -n 1'

a bfg='docker run -it --rm -v "$PWD":/data --workdir /data soodesune/bfg-repo-cleaner'

# sort preserving header row! https://stackoverflow.com/questions/14562423/is-there-a-way-to-ignore-header-lines-in-a-unix-sort
a sorth='(sed -u 1q; sort)'

# terraform

a tfa='tf apply   -auto-approve'
a tfd='tf destroy -auto-approve'
a tf='terraform'

# WSL
if [ $IS_WSL ]; then
    a code='"/mnt/c/Program Files/Microsoft VS Code/bin/code"'
    a c='code &> /dev/null'
    a c.='code "${PWD}" &> /dev/null &'
    a cnh='nohup bash "/mnt/c/Program Files/Microsoft VS Code/bin/code" . &> "/tmp/nohup-code-`basename $PWD`-`date +%Y-%m-%d-%H-%M-%S`.out" &'
fi

a psg='ps aux | grep -v " grep " | grep -i'
# a bbuser='git config user.email "mrabinovitch@dalet.com"; git config user.name "Moisei Rabinovich"; git config core.autocrlf true'
a bbuser='git config user.email "mrabinovitch@dalet.com"; git config user.name "Moisei Rabinovich"'
a ghuser='git config user.email "moisei@nowhere.com"; git config user.name "Moisei"'
a idea='nohup idea . &> $(mktemp /tmp/idea.XXXXXXXXX)&'
a gw='./gradlew'
a s='source'
a exp='explorer.exe'
a e.='explorer.exe .'

a k='kubectl'
a ka='kubectl get --all-namespaces'

a st='steampipe'
a stq='st query'
a stj='stq --output json'


a trivy='docker run --rm -it  -v /var/run/docker.sock:/var/run/docker.sock -v ~/.trivy/cache:/.trivy/cache -v $PWD:/work aquasec/trivy --cache-dir /.trivy/cache'
# a trivy='docker run --rm -it -u `id -u`:`id -g` -v /var/run/docker.sock:/var/run/docker.sock -v ~/.trivy/cache:/.trivy/cache -v $PWD:/work --cache-dir aquasec/trivy --cache-dir /.trivy/cache'
#__trivy_tmpl__='{{- $critical := 0 }}{{- $high := 0 }}{{- $medium := 0 }}{{- $low := 0 }}{{- range . }}{{- range .Vulnerabilities }}{{- if  eq .Severity "CRITICAL" }}{{- $critical = add $critical 1 }}{{- end }}{{- if  eq .Severity "HIGH" }}{{- $high = add $high 1 }}{{- end }}{{- end }}{{- end }}Critical: {{ $critical }}, High: {{ $high }},  Medium: {{ $medium }}, Low: {{ $low }}, {{printf "\n"}}'
__trivy_tmpl__='{{- $critical := 0 }}{{- $high := 0 }}{{- $medium := 0 }}{{- $low := 0 }}{{- range . }}{{- range .Vulnerabilities }}{{- if  eq .Severity "CRITICAL" }}{{- $critical = add $critical 1 }}{{- end }}{{- if  eq .Severity "HIGH" }}{{- $high = add $high 1 }}{{- end }}{{- if  eq .Severity "MEDIUM" }}{{- $medium = add $medium 1 }}{{- end }}{{- if  eq .Severity "LOW" }}{{- $low = add $low 1 }}{{- end }}{{- end }}{{- end }}Critical: {{ $critical }}, High: {{ $high }},  Medium: {{ $medium }}, Low: {{ $low }}, {{printf "\n"}}'
a trs='trivy image --format template --template "$__trivy_tmpl__"'

a trsi='trivy image'

a tp='telepresence'
a tp-daemon='rm -rf "$HOME/.cache/telepresence/logs" "$HOME/.config/telepresence"; mkdir "$HOME/.cache/telepresence/logs" "$HOME/.config/telepresence"; sudo "/usr/local/bin/telepresence" daemon-foreground "$HOME/.cache/telepresence/logs" "$HOME/.config/telepresence"'
a tpq='tp quit -u'

###
source "`dirname ${BASH_SOURCE[0]}`/functions.sh"
###
