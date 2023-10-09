#!/usr/bin/env bash

PYTHON=$(which python3)

if [ -z "$PYTHON" ]; then
    echo "Python3 not found. Please install Python3 and try again."
    exit 1
fi

echo "Please enter your OpenAI API key:"
# shellcheck disable=SC2162
read OPENAI_API_KEY

echo "Python3 found at $PYTHON"
echo "Creating virtual environment under the home directory .aiconsole"
# creating virtual environment under the home directory .aiconsole
$PYTHON -m venv ~/.aiconsole

echo "Activating virtual environment"
# activating virtual environment
# shellcheck disable=SC1090
source ~/.aiconsole/bin/activate

echo "Installing aiconsole"
# installing dependencies
pip install aiconsole

# create bin_public directory inside the .aiconsole if not exists
mkdir -p ~/.aiconsole/bin_public

# link the aiconsole binary to the bin_public directory
ln -sf ~/.aiconsole/bin/aiconsole ~/.aiconsole/bin_public/aiconsole

# TODO update logic with handling different shells
# currently, it will skip for linux versions, for windows there should be a different script used
if [[ "$OSTYPE" == "darwin"* ]]; then
  # for macos the current default shell is zsh
  touch ~/.zshrc
fi

# add the bin_public directory to the PATH depends on the shell
if [ -f ~/.bashrc ]; then
    echo "export PATH=\$PATH:~/.aiconsole/bin_public" >> ~/.bashrc
    echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> ~/.bashrc
    # shellcheck disable=SC1090
    source ~/.bashrc
elif [ -f ~/.zshrc ]; then
    echo "export PATH=\$PATH:~/.aiconsole/bin_public" >> ~/.zshrc
    echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> ~/.zshrc
    # shellcheck disable=SC1090
    source ~/.zshrc
else
    echo "No .bashrc or .zshrc found. Please add ~/.aiconsole/bin_public to your PATH."
fi

# deactivating virtual environment
deactivate
