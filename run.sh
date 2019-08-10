#!/bin/bash
set -x
CONTAINSER_NAME='seeingtheworld'
IMAGES_NAME='aiformankind/seeingtheworld'

is_images_exist=$(docker images -a | grep "$IMAGES_NAME")
if [ ! -z is_images_exist ]; then
  docker build -t $IMAGES_NAME:0.0.1 --build-arg TRAING_STEPS=1000 .
fi

is_container_exist=$(docker ps | grep "$CONTAINSER_NAME")
if [ -z "$is_container_exist" ]; then
  docker run -i -p 8888:8888 -p 6006:6006 --name=$CONTAINSER_NAME $IMAGES_NAME:0.0.1
else
  docker stop $CONTAINSER_NAME
  docker rm $CONTAINSER_NAME
  docker run -i -p 8888:8888 -p 6006:6006 --name=$CONTAINSER_NAME $IMAGES_NAME:0.0.1
fi
