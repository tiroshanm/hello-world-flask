#!/usr/bin/env bash

echo "[ INFO ] Building Image and Push to Amazon ECR starting ..."
echo "[ INFO ] Docker Image  : ${IMAGE_NAME}"
echo "[ INFO ] Image Version : ${VERSION}"
echo "[ INFO ] ECR Repository: ${REPOSITORY}"

docker_login=$(aws ecr get-login --region ${REGION})

echo "[ INFO ] 1 - Login to Amazon ECR."
echo "$docker_login"
eval $docker_login

echo "[ INFO ] 2 -  Build docker image. : ${IMAGE_NAME}:${VERSION}"
docker build -t ${IMAGE_NAME}:${VERSION} -f docker/Dockerfile .

echo "[ INFO ] 3 -  Tag docker image. : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"
docker tag ${IMAGE_NAME}:${VERSION} ${REPOSITORY}/${IMAGE_NAME}:${VERSION}

echo "[ INFO ] 4 - Push docker image. : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"
docker push ${REPOSITORY}/${IMAGE_NAME}:${VERSION}

echo "[ INFO ] Built and pushed image to Amazon ECR : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"

echo "[ INFO ] 5 - Remove local docker image. : ${REPOSITORY}/${IMAGE_NAME}:${VERSION}"
docker rmi ${REPOSITORY}/${IMAGE_NAME}:${VERSION}

echo "[ INFO ] 6 - Remove local docker image. : ${IMAGE_NAME}:${VERSION}"
docker rmi ${IMAGE_NAME}:${VERSION}
