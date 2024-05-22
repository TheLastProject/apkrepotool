#!/bin/bash

cd /repo || exit 1

"$HOME"/.local/bin/apkrepotool update
