#!/bin/bash

set -e

rm -rf ../infra/build/package
mkdir -p ../infra/build/package

pip3 install --no-cache-dir -r ../infra/src/requirements.txt -t ../infra/build/package
cp ../infra/src/lambda_function.py ../infra/build

cd ../infra/build/package
zip -r ../lambda.zip .

cd ..
zip lambda.zip lambda_function.py

zipinfo -1 lambda.zip

echo ""
echo "Done! Lambda zip created."