# venvup

**UPDATE 2025-02-24:** I am archiving this repository because I am now using [uv](https://github.com/astral-sh/uv#readme) to manage virtual environments. *-Bill Melvin*

---

**venvup** is a bash script that creates a Python virtual environment (venv) in the current directory. It also installs requirements via *pip* if a `requirements.txt` and/or a `requirements-dev.txt` file is found.

The script was built to run on Linux and has only been used by the author on Ubuntu (and *flavours* thereof).

It assumes using `venv` to create a virtual environment with the name `venv`, not `.venv`.

If an argument is passed when running the script, it is used as a prefix in naming the prompt for the venv. Only the first argument is used. For example, if you run `venvup test` the prompt will be `(test-venv)` when the virtual environment is activated.

### Links

[venv](https://docs.python.org/3/library/venv.html) - Creation of virtual environments - Python documentation

[terminal - List of ANSI color escape sequences](https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences) - Stack Overflow
