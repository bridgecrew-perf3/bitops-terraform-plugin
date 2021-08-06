#!/usr/bin/env bash
set -e

echo ""
echo "Welcome to the BitOps sample plugin!"
echo "The follow environment variables are available on every plugin:"
echo "PLUGIN_DIR: The root of your plugin directory. Useful if you want to invoke other scripts!"
echo "PLUGIN_DIR=${PLUGIN_DIR}"
echo ""
echo "ENVIRONMENT_DIR: The location of your operations repo code for your plugin"
echo "ENVIRONMENT_DIR=${ENVIRONMENT_DIR}"
echo ""
echo "All the options defined in your plugin's bitops.schema.yaml. These values are overridden by bitops.config.yaml files in operations repos"
echo "MY_FAV_COLOR=${MY_FAV_COLOR}"
echo "MY_NAME=${MY_NAME}"
echo ""
echo "Lastly, options defined as cli options will be formatted and available in the CLI_OPTIONS env var"
echo "CLI_OPTIONS=${CLI_OPTIONS}"


echo "Lets test it out!"
bash $PLUGIN_DIR/scripts/print-fav-color.sh "${MY_NAME}" "${MY_FAV_COLOR}"
