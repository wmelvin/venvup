#!/usr/bin/env bash

# ----------------------------------------------------------------------
#  Create a Python virtual environment (venv) in the current directory.
#  Also install requirements via pip if a 'requirements.txt' and/or a
#  'requirements-dev.txt' file is found.
#
#  Source: https://github.com/wmelvin/venvup
#
#  Modified: 2023-12-12
# ----------------------------------------------------------------------

# Terminal color codes.
BG="\x1b[1m\x1b[32m"  # Bright Green
GR="\x1b[32m"         # GReen
YE="\x1b[1m\x1b[33m"  # YEllow (bright)
NC="\x1b[0m"          # No Color (reset)

CWD=$(pwd)

if [ -d "venv" ]; then
    printf "\n%bVirtual environment directory 'venv' already exists.%b\n" "$BG" "$NC"
    printf "Nothing to do.\n"
    exit 1
fi

printf "\nCreate Python virtual environment (venv) in directory \n"
printf "%b%s%b\n\n" "$GR" "$CWD" "$NC"
read -r -p "Enter 'y' to continue: " ANS
case "$ANS" in
  [yY1] ) echo '' ;;
  * ) exit 1 ;;
esac

if [ ! -d "venv" ]; then
    if [ $# -ge 1 ]; then
        # If arguments were passed, use the first one as a prompt prefix.
        printf "\nRUN: python3 -m venv --prompt %s-venv venv\n" "$1"
        python3 -m venv  --prompt "$1-venv" venv
    else
        printf "\nRUN: python3 -m venv venv\n"
        python3 -m venv venv
    fi
fi

if [ ! -d "venv" ]; then
    printf "\n%bERROR: Failed to create 'venv'.%b\n" "$YE" "$NC"
    printf "'python3-venv' must be installed for this to work.\n"
    exit 1
fi

printf "\nRUN: source venv/bin/activate\n"

source venv/bin/activate

printf "\nRUN: pip install --upgrade pip setuptools\n"

pip install --upgrade pip setuptools

REQ="requirements-dev.txt"
if [ -f "$REQ" ]; then
    printf "\nRUN: pip install -r %s\n" "$REQ"
    pip install -r "$REQ"
fi

REQ="requirements.txt"
if [ -f "$REQ" ]; then
    printf "\nRUN: pip install -r %s\n" "$REQ"
    pip install -r "$REQ"
fi

printf "\n%bPython version:%b $(python3 --version)\n$(which python3)\n\n" "$BG" "$NC"

printf "%bInstalled packages:%b\n$(pip freeze)\n\n" "$BG" "$NC"

printf "%bUnless this script was sourced, the virtual environment activated " "$YE"
printf "during its execution will not be available in the current shell.\n"
printf "Run '%bsource venv/bin/activate%b' to activate it.%b\n\n" "$BG" "$YE" "$NC"
