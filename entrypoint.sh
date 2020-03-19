#!/usr/bin/env bash

set -ex

while getopts ":b:p:t:" opt; do
    case ${opt} in
        b )
        PULLREQUESTREF=$OPTARG
        ;;
        p )
        PROVIDERNAME=$OPTARG
        ;;
        t )
        LINTTASK=$OPTARG
        ;;
        * )
        echo "Invalid option specified"
        ;;
    esac
done

# git clone --mirror git@github.com:terraform-providers/${PROVIDERNAME}.git
git clone --depth=1 https://github.com/terraform-providers/"${PROVIDERNAME}".git
cd "${PROVIDERNAME}"
git fetch origin "${PULLREQUESTREF}":lint
git checkout lint

# Exit Codes
PROVIDERNOTSUPPORTED=1
TASKNOTSUPPORTED=2

lint-azurerm () {
    
    case ${LINTTASK} in
        lintrest )
            make tools
            make lintrest
            ;;
        tflint )
            make tools
            make tflint
            ;;
        website-lint )
            make tools
            make website-lint
            ;;
        lint-all )
            make tools
            make lintrest
            make tflint
            make website-lint
            ;;
        * )
            echo "Lint task '${LINTTASK}' not supported"
            exit $TASKNOTSUPPORTED
            ;;
    esac
}

lint-azuread () {
    case ${LINTTASK} in
        lint )
            make tools
            make lint
            ;;
        tflint )
            make tools
            make tflint
            ;;
        website-lint )
            make tools
            make website-lint
            ;;
        lint-all )
            make tools
            make lint
            make tflint
            make website-lint
            ;;
        * )
            echo "Lint task not supported for provider ${INPUT_PROVIDER}"
            exit $TASKNOTSUPPORTED
            ;;
    esac
}

case ${PROVIDERNAME} in
    terraform-provider-azurerm )
        lint-azurerm
        ;;

    terraform-provider-azuread )
        lint-azuread
        ;;

    * )
        echo "provider ${PROVIDERNAME} not currently supported"
        exit $PROVIDERNOTSUPPORTED
        ;;
esac

