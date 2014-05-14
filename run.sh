#!/bin/sh
docker_id=$(docker run -d -p 127.0.0.1:2022:22 -P jmatis/ubuntu )
echo $docker_id
docker logs -f ${docker_id}
