#!/usr/bin/env bash
### Paste in here latest File Revisions
REV=https://raw.githubusercontent.com/b23prodtm/vagrant-shell-scripts/b23prodtm-patch/vendor/cni/init_functions.sh
#REV=https://raw.githubusercontent.com/b23prodtm/vagrant-shell-scripts/87e48481c955e213de3d08453dd4dd56d1104bec/vendor/cni/balena_deploy.sh
sudo curl -SL -o /usr/local/bin/init_functions $REV
sudo chmod 0755 /usr/local/bin/init_functions
source /usr/local/bin/init_functions "${BASH_SOURCE[0]}" "$@"
