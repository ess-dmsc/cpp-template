#!/usr/bin/env bash

echo "Activating run environment"

source /BUILD_DIR/activate_run.sh

echo "Launching <PROJECT NAME>"

/BUILD_DIR/executable --cli-args

