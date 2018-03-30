#!/usr/bin/env bash

GIT_REPO_WITH_ACCESS_TOKEN="https://Tiroshan:acb9b7a0339923b523395a242aeb7428aaa8a0a5@github.com/Tiroshan/hello-world-helm-development.git"
GIT_REPO_NAME="hello-world-helm-development"

echo "[INFO] Helm Kubernetes Script Updating..."
echo "[INFO] Clone development helm script repository..."

cd ../
ls
git init
git clone ${GIT_REPO_WITH_ACCESS_TOKEN}
ls
cd ${GIT_REPO_NAME}


sed "s,PLC_REPOSITORY,${REPOSITORY},g;s,PLC_TAG,${VERSION},g;" _hw_values_template.yaml > values.yaml

git commit -m "Auto update the Helm script based on module:${REPOSITORY} ${VERSION}"
git push origin master