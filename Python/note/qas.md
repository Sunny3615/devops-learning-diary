# Python Questions and Answers

This note records the questions I had while doing Python practice for DevOps automation.

---

## 1. If I only use Python 3, do I still need to use `python3`?
Not always.

If `python` already points to Python 3 (for example, through an alias or inside a virtual environment), you can simply use:

```bash
python --version
```

## 2. Which Python interpreter is installed on my Mac?
```bash
which python3
/opt/homebrew/bin/python3
which python
python not found
```

## 3. Since I only have one Python version, can I alias `python` to `python3`?

Yes.

If you only have Python 3 installed and want to use the `python` command instead of `python3`, you can create an alias.

Open your `~/.zshrc` file:

```bash
nano ~/.zshrc
```

Add the following line to the end of the file:
```
alias python=python3
```

Save the file and reload your shell configuration:
```
source ~/.zshrc
```
Now verify it:
```
 which python
python: aliased to python3
python --version
Python 3.14.6
```
> which python does not show a file path because python is now a shell alias rather than an executable. To check what python actually points to, use:
```bash
type python
python is an alias for python3
```

## 4. How does the interpreter work in VS Code?

VS Code needs to know which Python interpreter should run the current project.

If VS Code uses the wrong interpreter, the code may fail even if the package is already installed somewhere else. For example:

```bash
ModuleNotFoundError: No module named 'yaml'
```
This happened to me when PyYAML is installed in one Python environment, but VS Code runs the script using another interpreter.

To check the interpreter used by the terminal:

```bash
python -c "import sys; print(sys.executable)"
```
In VS Code, the best choice is usually(create a clean env for the project)

```
/path/to/project/.venv/bin/python
```


## 5. How do I activate and deactivate a virtual environment?
Create a virtual environment:
```bash
python3 -m venv .venv
# or 
python -m venv .venv 
# since I aliased `python` to `python3`
```
Activate it on macOS:
```bash
source .venv/bin/activate
(.venv)
```
Deactivate it:
```bash
deactivate
```

