#!/usr/bin/env bash

echo "[ INFO ] Building Image and Push to Google GCR starting ..."
echo "[ INFO ] Docker Image  : ${IMAGE_NAME}"
echo "[ INFO ] Image Version : ${VERSION}"
echo "[ INFO ] GCR Repository: ${REPOSITORY}"

echo "[ INFO ] 1 -  Build docker image. : ${IMAGE_NAME}:${VERSION}"
docker build -t ${IMAGE_NAME}:${VERSION} -f docker/Dockerfile .

echo "[ INFO ] 2 -  Tag docker image. : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"
docker tag ${IMAGE_NAME}:${VERSION} ${REPOSITORY}/${IMAGE_NAME}:${VERSION}

echo "[ INFO ] 3 - Push docker image. : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"
gcloud docker -- push ${REPOSITORY}/${IMAGE_NAME}:${VERSION}

echo "[ INFO ] Built and pushed Image to Google Registry : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"

echo "[ INFO ] 4 - Remove local docker image. : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"
docker rmi ${REPOSITORY}/${IMAGE_NAME}:${VERSION}

echo "[ INFO ] 5 - Remove local docker image. : ${IMAGE_NAME}:${VERSION}"
docker rmi ${IMAGE_NAME}:${VERSION}


