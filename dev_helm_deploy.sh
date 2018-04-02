#!/usr/bin/env bash

GIT_REPO_WITH_ACCESS_TOKEN="https://Tiroshan:64adac21fb70a9d0570eaaafd34c6839693f096e@github.com/Tiroshan/hello-world-helm-development.git"
GIT_REPO_NAME="hello-world-helm-development"

COMMIT_TIMESTAMP=`date +'%Y-%m-%d %H:%M:%S %Z'`
GIT_EMAIL='tiroshanm@gmail.com'
GIT_USERNAME='Tiroshan'

echo "[INFO] Helm Kubernetes Script Updating..."
echo "[INFO] Clone development helm script repository..."

cd ../
ls
git init
git config user.email ${GIT_EMAIL}
git config user.name ${GIT_USERNAME}
git clone ${GIT_REPO_WITH_ACCESS_TOKEN}
ls
cd ${GIT_REPO_NAME}


sed "s,PLC_REPOSITORY,${REPOSITORY},g;s,PLC_TAG,${VERSION},g;" _hw_values_template.yaml > values.yaml
git add --all
git commit -m "Auto update the Helm script based on module:${REPOSITORY} ${VERSION} - ${COMMIT_TIMESTAMP}"
git push ${GIT_REPO_WITH_ACCESS_TOKEN} master