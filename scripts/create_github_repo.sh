# http://stackoverflow.com/questions/2423777/is-it-possible-to-create-a-remote-repo-on-github-from-the-cli-without-ssh
GITHUB_USER='xxx@gmail.com'
curl -u $GITHUB_USER https://api.github.com/user/repos -d '{"name":"unix_config","description":"Useful unix scripts and configurations"}'
