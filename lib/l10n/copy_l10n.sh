#!/bin/bash

GEN_PATH="./.dart_tool/flutter_gen/gen_l10n"
DEST_PATH="./lib/src/l10n"
mkdir -p $DEST_PATH
cp $GEN_PATH/*.dart $DEST_PATH
echo "Files copied to $DEST_PATH"
