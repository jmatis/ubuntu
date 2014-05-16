#!/bin/sh
docker_id=$(docker run -d --net=host -p 2022:2022 -P jmatis/ubuntu )
echo $docker_id
docker logs -f ${docker_id}
