#!/bin/bash

set -e

PACKAGE_DIR="../infra/build/package"
PG_MODULE="$PACKAGE_DIR/pg/_pg.cpython-314-x86_64-linux-gnu.so"

rm -rf ../infra/build/package
mkdir -p ../infra/build/package

pip3 install --no-cache-dir -r ../infra/src/requirements.txt -t ../infra/build/package
cp ../infra/src/lambda_function.py ../infra/build

ldd "$PG_MODULE" | awk '/=>/ {print $3}' \
| while read lib; do
    echo "Copying $(basename "$lib")"
    cp -L "$lib" "$PACKAGE_DIR"
done

cd ../infra/build/package
zip -r ../lambda.zip .

cd ..
zip lambda.zip lambda_function.py

echo ""
zipinfo -1 lambda.zip

echo ""
echo "Done! Lambda zip created."