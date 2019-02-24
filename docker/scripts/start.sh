REPO_ROOT=$(dirname $(realpath $0))/../..

# Export desktop environment shell configuration
export $($REPO_ROOT/docker/scripts/environment.sh)

docker run \
  --cap-add SYS_PTRACE \
  --detach \
  --device /dev/bus/usb \
  --device /dev/dri \
  --device /dev/snd \
  --device /dev/usb \
  --device /dev/video0 \
  --env DESKTOP_ENVIRONMENT_USER \
  --env DISPLAY=${DISPLAY-:0} \
  --group-add audio \
  --group-add docker \
  --group-add video \
  --hostname $DESKTOP_ENVIRONMENT_REGISTRY-$DESKTOP_ENVIRONMENT_CONTAINER-$(hostname) \
  --interactive \
  --name $DESKTOP_ENVIRONMENT_CONTAINER \
  --rm \
  --security-opt seccomp:$REPO_ROOT/docker/config/chrome/chrome.json \
  --tty \
  --volume /dev/shm:/dev/shm \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /var/lib/docker:/var/lib/docker \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume $DESKTOP_ENVIRONMENT_HOME/.config/alacritty:$DESKTOP_ENVIRONMENT_HOME/.config/alacritty \
  --volume DESKTOP_ENVIRONMENT_CACHE_CERTIFICATES:$DESKTOP_ENVIRONMENT_CACHE_CERTIFICATES \
  --volume DESKTOP_ENVIRONMENT_CACHE_CHROME:$DESKTOP_ENVIRONMENT_CACHE_CHROME \
  --volume DESKTOP_ENVIRONMENT_CACHE_CODE:$DESKTOP_ENVIRONMENT_CACHE_CODE \
  --volume DESKTOP_ENVIRONMENT_CACHE_SECRETS:$DESKTOP_ENVIRONMENT_CACHE_SECRETS \
  --volume DESKTOP_ENVIRONMENT_CACHE_SSH:$DESKTOP_ENVIRONMENT_CACHE_SSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_STEMN:$DESKTOP_ENVIRONMENT_CACHE_STEMN \
  --volume DESKTOP_ENVIRONMENT_CACHE_VCSH:$DESKTOP_ENVIRONMENT_CACHE_VCSH \
  --volume DESKTOP_ENVIRONMENT_CACHE_VCSH_PRIVATE:$DESKTOP_ENVIRONMENT_CACHE_VCSH_PRIVATE \
  --volume DESKTOP_ENVIRONMENT_CACHE_YARN:$DESKTOP_ENVIRONMENT_CACHE_YARN \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZOOM:$DESKTOP_ENVIRONMENT_CACHE_ZOOM \
  --volume DESKTOP_ENVIRONMENT_CACHE_ZSH:$DESKTOP_ENVIRONMENT_CACHE_ZSH \
  --volume DESKTOP_ENVIRONMENT_STATE_CHROME:$DESKTOP_ENVIRONMENT_STATE_CHROME \
  --volume DESKTOP_ENVIRONMENT_STATE_CODE:$DESKTOP_ENVIRONMENT_STATE_CODE \
  --volume DESKTOP_ENVIRONMENT_STATE_GITHUB:$DESKTOP_ENVIRONMENT_STATE_GITHUB \
  --volume DESKTOP_ENVIRONMENT_STATE_JUMP:$DESKTOP_ENVIRONMENT_STATE_JUMP \
  --volume DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE:$DESKTOP_ENVIRONMENT_STATE_MUSIKCUBE \
  --volume DESKTOP_ENVIRONMENT_STATE_ZOOM:$DESKTOP_ENVIRONMENT_STATE_ZOOM \
  --volume DESKTOP_ENVIRONMENT_USER_DOCUMENTS:$DESKTOP_ENVIRONMENT_USER_DOCUMENTS \
  --volume DESKTOP_ENVIRONMENT_USER_DOWNLOADS:$DESKTOP_ENVIRONMENT_USER_DOWNLOADS \
  --volume DESKTOP_ENVIRONMENT_USER_HOME:$DESKTOP_ENVIRONMENT_USER_HOME \
  --volume DESKTOP_ENVIRONMENT_USER_MUSIC:$DESKTOP_ENVIRONMENT_USER_MUSIC \
  --volume DESKTOP_ENVIRONMENT_USER_PICTURES:$DESKTOP_ENVIRONMENT_USER_PICTURES \
  --volume DESKTOP_ENVIRONMENT_USER_REPOSITORIES:$DESKTOP_ENVIRONMENT_USER_REPOSITORIES \
  --volume DESKTOP_ENVIRONMENT_USER_VIDEOS:$DESKTOP_ENVIRONMENT_USER_VIDEOS \
  --workdir $DESKTOP_ENVIRONMENT_HOME \
  $DESKTOP_ENVIRONMENT_REGISTRY/$DESKTOP_ENVIRONMENT_CONTAINER:$DESKTOP_ENVIRONMENT_BRANCH

# Wait until the desktop environment container is running before proceeding
until docker inspect $DESKTOP_ENVIRONMENT_CONTAINER | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Start desktop services
# $REPO_ROOT/docker/scripts/exec-root.sh s6-svc -u /run/s6/services/gotty
# $REPO_ROOT/docker/scripts/exec-root.sh s6-svc -u /run/s6/services/keychain
# $REPO_ROOT/docker/scripts/exec-root.sh s6-svc -u /run/s6/services/rescuetime
# $REPO_ROOT/docker/scripts/exec-root.sh s6-svc -u /run/s6/services/tmux-desktop-environment
# $REPO_ROOT/docker/scripts/exec-root.sh s6-svc -u /run/s6/services/tmux-gotty-clients
# $REPO_ROOT/docker/scripts/exec-root.sh s6-svc -u /run/s6/services/webrelay