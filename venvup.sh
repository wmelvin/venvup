#!/usr/bin/env bash

# Terminal color codes.
BG="\x1b[1m\x1b[32m"  # Bright Green
GR="\x1b[32m"         # GReen
YE="\x1b[1m\x1b[33m"  # YEllow (bright)
NC="\x1b[0m"          # No Color (reset)

CWD=$(pwd)

if [ -d "venv" ]; then
    printf "\n${BG}Virtual environment directory 'venv' already exists.${NC}\n"
    printf "Nothing to do.\n"
    exit 1
fi

printf "\nCreate Python virtual environment (venv) in directory \n"
printf "${GR}${CWD}${NC}\n\n"
read -p "Enter 'y' to continue: " ANS
case "$ANS" in
  [yY1] ) echo '' ;;
  * ) exit 1 ;;
esac

if [ ! -d "venv" ]; then
    if [ $# -ge 1 ]; then
        # If arguments were passed, use the first one as a prompt prefix.
        printf "\nRUN: python3 -m venv --prompt $1-venv venv\n"
        python3 -m venv  --prompt "$1-venv" venv
    else
        printf "\nRUN: python3 -m venv venv\n"
        python3 -m venv venv
    fi
fi

if [ ! -d "venv" ]; then
    printf "\n${YE}ERROR: Failed to create 'venv'.${NC}\n"
    printf "'python3-venv' must be installed for this to work.\n"
    exit 1
fi

printf "\nRUN: source venv/bin/activate\n"

source venv/bin/activate

printf "\nRUN: pip install --upgrade pip setuptools\n"

pip install --upgrade pip setuptools

REQ="requirements-dev.txt"
if [ -f "$REQ" ]; then
    printf "\nRUN: pip install -r $REQ\n"
    pip install -r "$REQ"
fi

REQ="requirements.txt"
if [ -f "$REQ" ]; then
    printf "\nRUN: pip install -r $REQ\n"
    pip install -r "$REQ"
fi

printf "\n${BG}Python version:${NC} $(python3 --version)\n$(which python3)\n\n"

printf "${BG}Installed packages:${NC}\n$(pip freeze)\n\n"

printf "${YE}Unless this script was sourced, the virtual environment activated "
printf "during its execution will not be available in the current shell.\n"
printf "Run '${BG}source venv/bin/activate${YE}' to activate it.${NC}\n\n"
