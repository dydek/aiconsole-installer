#!/usr/bin/env bash

PYTHON=$(which python3)

if [ -z "$PYTHON" ]; then
    echo "Python3 not found. Please install Python3 and try again."
    exit 1
fi

# creating virtual environment under the home directory .aiconsole
$PYTHON -m venv ~/.aiconsole

# activating virtual environment
source ~/.aiconsole/bin/activate

# installing dependencies
pip install aiconsole

# create a symbolic link to the executable file and add it to the system path
ln -s ~/.aiconsole/bin/aiconsole /usr/local/bin/aiconsole

# deactivating virtual environment
deactivate
