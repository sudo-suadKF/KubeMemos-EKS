#!/bin/bash

set -e

rm -rf ../infra/build
mkdir -p ../infra/build

pip3 install --no-cache-dir -r ../infra/src/requirements.txt -t ../infra/build/package

cp ../infra/src/lambda_function.py ../infra/build/package

zip -r ../infra/build/lambda.zip ../infra/build/package

echo "Done! Lambda zip created."