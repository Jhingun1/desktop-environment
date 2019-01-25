# Desktop environment container user
DESKTOP_ENVIRONMENT_USER=jackson
DESKTOP_ENVIRONMENT_HOME=/$DESKTOP_ENVIRONMENT_USER/home

# Desktop environment configuration
echo DESKTOP_ENVIRONMENT_HOME=$DESKTOP_ENVIRONMENT_HOME
echo DESKTOP_ENVIRONMENT_USER=$DESKTOP_ENVIRONMENT_USER

# Desktop environment cache volumes
echo DESKTOP_ENVIRONMENT_CACHE_CHROME=$DESKTOP_ENVIRONMENT_HOME/.cache/google-chrome
echo DESKTOP_ENVIRONMENT_CACHE_CODE=$DESKTOP_ENVIRONMENT_HOME/.vscode
echo DESKTOP_ENVIRONMENT_CACHE_YARN=$DESKTOP_ENVIRONMENT_HOME/.cache/yarn

# Desktop environment configuration volumes
echo DESKTOP_ENVIRONMENT_CONFIG_CHROME=$DESKTOP_ENVIRONMENT_HOME/.config/google-chrome
echo DESKTOP_ENVIRONMENT_CONFIG_CODE=$DESKTOP_ENVIRONMENT_HOME/.config/Code
echo DESKTOP_ENVIRONMENT_CONFIG_GITHUB=$DESKTOP_ENVIRONMENT_HOME/.config/github/hub
