#!/bin/bash

# Constants
GOOGLE_DEPLOY='GOOGLE'
AMAZON_DEPLOY='AMAZON'
DOCKER_DEPLOY='DOCKER'

IMAGE_NAME='hello-world-flask'

# expected environment varaibles
#DEPLOY_TYPE - deployment type - GOOGLE, AMAZON, DOCKER
#REPOSITORY - image repository
#REGION - required when AMAZON_DEPLOY='AMAZON'

echo "[ INFO ] Building module starting........"

echo "[ INFO ] Checking expected environment variables"

if [ -z ${DEPLOY_TYPE} ] && [ -z ${REPOSITORY} ]
then
    echo "[ ERROR ] One or more values are empty"
    echo "[ INFO ] DEPLOY_TYPE : ${DEPLOY_TYPE}"
    echo "[ INFO ] REPOSITORY : ${REPOSITORY}"
    echo "[ INFO ] REGION : ${REGION}"

    IS_SUCCESS=false
else
    echo "[ INFO ] DEPLOY_TYPE : ${DEPLOY_TYPE}"
    echo "[ INFO ] REPOSITORY : ${REPOSITORY}"
    echo "[ INFO ] REGION : ${REGION}"

    IS_SUCCESS=true
fi


if [ ${IS_SUCCESS} = true ]
then
    echo "[ INFO ] Set up environment"
    #export PATH=$PATH:/home/ubuntu/sonar-runner/sonar-runner-2.4/bin

    echo "[ INFO ] Creating virtual environment"
    python3 -m venv venv
    source venv/bin/activate

    echo "[ INFO ] Install requirements"
    pip install pybuilder
    pip install -r requirements.txt

    echo "[ INFO ] Build project"
    pyb

    echo "[ INFO ] Create Image tag based on the git commit hash"
    VERSION=$(git rev-parse --short HEAD 2> /dev/null | sed "s/\(.*\)/@\1/")

    echo "[ INFO ] VERSION : ${VERSION}"

    echo "[ INFO ] Creating component image & push for latest commit: ${VERSION}"
    if [ ${DEPLOY_TYPE} = ${GOOGLE_DEPLOY} ]
    then
        bash google_image_deploy.sh

    elif [ ${DEPLOY_TYPE} = ${AMAZON_DEPLOY} ]
    then
        bash amazon_image_deploy.sh

    elif [ ${DEPLOY_TYPE} = ${DOCKER_DEPLOY} ]
    then
        bash docker_image_deploy.sh
    fi

# Always Build tool deploy the dev_latest image to the development environment
    echo "[ INFO ] Create Image tag as dev_latest"
    VERSION='dev_latest'

    echo "[ INFO ] VERSION : ${VERSION}"

    echo "[ INFO ] Creating component image & push"
    if [ ${DEPLOY_TYPE} = ${GOOGLE_DEPLOY} ]
    then
        bash google_image_deploy.sh

    elif [ ${DEPLOY_TYPE} = ${AMAZON_DEPLOY} ]
    then
        bash amazon_image_deploy.sh

    elif [ ${DEPLOY_TYPE} = ${DOCKER_DEPLOY} ]
    then
        bash docker_image_deploy.sh
    fi

else
    echo "[ ERROR ] Project build failed"
fi






