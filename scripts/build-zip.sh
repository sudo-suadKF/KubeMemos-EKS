#!/bin/bash

set -e

PACKAGE_DIR="../src/package"
PG_MODULE="$PACKAGE_DIR/pg/_pg.cpython-314-x86_64-linux-gnu.so"

rm -rf "$PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR"

pip3 install --no-cache-dir -r ../src/requirements.txt -t "$PACKAGE_DIR"

ldd "$PG_MODULE" | awk '/=>/ {print $3}' \
| while read lib; do
    echo "Copying $(basename "$lib")"
    cp -L "$lib" "$PACKAGE_DIR"
done

cd "$PACKAGE_DIR"
zip -r ../lambda.zip .

cd ..
zip lambda.zip lambda_function.py

echo ""
zipinfo -1 lambda.zip

echo ""
echo "Done! Lambda zip created."
