#!/bin/bash

curl -X POST -H "Content-Type:application/octet-stream" \
 --data-binary @example.vsdx http://localhost:8000/convert-vsdx > converted_file.svg