#!/bin/bash

docker build . -t drawio-api:latest
mkdir received_files > /dev/null 2>&1
docker run -v $(pwd)/received_files:/opt/drawio-api/received_files -p 8000:8000 drawio-api:latest 