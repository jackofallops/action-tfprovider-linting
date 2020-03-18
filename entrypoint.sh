#!/usr/bin/env bash

while getopts ":bpt" opt; do
    case ${opt} in
        b )
        PULLREQUESTREF=$OPTARG
        ;;
        p )
        PROVIDERNAME=$OPTARG
        ;;
        t )
        LINTTASK=$LINTTASK
        ;;
    esac
done

git clone --mirror git@github.com:terraform-providers/${PROVIDERNAME}.git
git checkout ${PULLREQUESTREF}

# Exit Codes
PROVIDERNOTSUPPORTED=1
TASKNOTSUPPORTED=2

case INPUT_PROVIDER in
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

func lint-azurerm() {
    make tools
    case INPUT_LINTTASK in
        lintrest )
            make lintrest
            ;;
        tflint )
            make tflint
            ;;
        website-lint )
            make website-lint
            ;;
        * )
            echo "Lint task '${LINTTASK}' not supported"
            exit $TASKNOTSUPPORTED
            ;;
}

func lint-azuread() {
    make tools
    case INPUT_LINTTASK in
        lint )
            make lint
            ;;
        tflint )
            make tflint
            ;;
        website-lint )
            make website-lint
            ;;
        * )
            echo "Lint task not supported for provider ${INPUT_PROVIDER}"
            exit $TASKNOTSUPPORTED
            ;;
}

