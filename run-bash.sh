#!/bin/sh
docker run -i -p 2022:2022 --net=host -t jmatis/ubuntu  /bin/bash
