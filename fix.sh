#!/bin/bash
#
set -euxo pipefail
prettier -w ./index.html ./html/*.html
