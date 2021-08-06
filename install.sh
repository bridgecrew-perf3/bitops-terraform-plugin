#!/usr/bin/env bash
set -e

echo ""
echo "When including a plugin in a BitOps install, this script will be called during docker build."
echo "It should be used to install any dependencies required to actually run your plugin."
echo "BitOps uses alpine linux as its base, so you'll want to use apk commands (Alpine Package Keeper)"
echo ""

apk info

export TERRAFORM_VERSIONS=$(cat build.config.yaml | shyaml get-values terraform.versions)
export HELM_VERSION=$(cat build.config.yaml | shyaml get-value helm.version)
export KUBECTL_VERSION=$(cat build.config.yaml | shyaml get-value kubectl.version)
export CLOUD_PLATFORM=$(cat build.config.yaml | shyaml get-value cloud_platform.name)
export CI_PLATFORM=$(cat build.config.yaml | shyaml get-value ci_platform.name)
export AWS_REGION=$(cat build.config.yaml | shyaml get-value cloud_platform.region)
export CURRENT_ENVIRONMENT=$(cat build.config.yaml | shyaml get-value environment.default)


mkdir -p /opt/download
cd /opt/download

function install_terraform() {
    while IFS='' read -r version; do
        TERRAFORM_DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip"
        echo ${TERRAFORM_DOWNLOAD_URL}
        curl -LO ${TERRAFORM_DOWNLOAD_URL} && unzip terraform_${version}_linux_amd64.zip -d ./
        mv terraform /usr/local/bin/terraform-${version}
        chmod +x /usr/local/bin/terraform-${version}
    done <<< "$TERRAFORM_VERSIONS"
}

install_terraform
