# hooks-utility README

a collections of utility functions for **git hooks**

<!-- todo auto generate better commit/merge message -->
<!-- bug branch protection: \n in line get interpreted -->











## Usage as Git Submodule

Include the entire project as a Git Submodule of your working project:

```bash
git submodule add git@github.com:kami-lel/hooks-utility.git scripts/hooks_utility
```

(run at your working project root)

This would add *hooks utility* as a submodule at `./scripts/hooks_utility/`

----

Resulted project structure:

```
.
└── scripts
    └── hooks_utility
        ├── hooks_utility.sh
        ├── README.md
        └── ...
```

Resulted content of `.gitmodules`:

```
[submodule "scripts/hooks_utility"]
	path = scripts/hooks_utility
	url = git@github.com:kami-lel/hooks-utility.git
```













## Usage as File

Use `hooks_utility.sh` file (which contains all functionality) by place it alongside git hooks scripts.

Typical folder structure:

```
.
└── scripts
    ├── hooks_utility.sh
    └── hooks
        ├── pre-merge-commit
        └── ...
```

And in the git hook scripts (e.g. `pre-merge-commit` above,)
**source** the `hooks_utility.sh`:

```bash
source "$(dirname "${BASH_SOURCE[0]}")/../hooks_utility.sh"
```















## Functionality

### ANSI colorful print

Utilize **ANSI color escape code** for printing:

Use the generic function:

```bash
printf '%s' "Content in Red\n" | hooks_utility_colorful_print "\e[0;31m"
```

Use specific color:

```bash
printf '%s' "Content in Red\n" | hooks_utility_print_in_red
```

Print specific *keywords*:

```bash
hooks_utility_colorful_print_pass
```





### log style message

Print log style message (i.e. prefixed with `DEBUG`, `ERROR`, ...)
to `stdout` or `stderr`, using these 5 functions, e.g.:

```bash
echo "Debug Message Content" | hooks_utility_debug
echo "Warning Message Content"  | hooks_utility_warning -dt "MainScript"
```

Outputs:

```
DEBUG:  Debug Message Content
2025-10-12 16:23:16 WARN (MainScript):   Warning Message Content
```





### padding print

Print the message from stdin with its right/left space filled with padding.

E.g.:

```bash
echo "Book Title" | hooks_utility_padding_left_just '='
```

Output:

```
Book Title  ====================================================================
```




### branch protection

Protect some branches from having different levels of annotation markers.

AMs:

- primary AM: `TODO`, `BUG`, `FIXME`, `HACK`
- secondary AM: `Todo`, `Bug`, `Fixme`, `Hack`
- tertiary AM: `todo`, `bug`, `fixme`, `hack`

Protected branches:

| AM     | primary | secondary | tertiary |
|--------|---------|-----------|----------|
| `main` | ❌      | ❌        | ✔️       |
| `dev`  | ❌      | ✔️        | ✔️       |

(✔️: allowed, ❌: disallowed)

E.g., in `pre-commit`:

```
hooks_utility_protect_branch
```

Checks will be performed during merge,
it will be rejected if incoming branch contains disallowed AM.





### ensure file modification

In `pre-commit`, ensure some file is edited.

E.g., in `pre-commit`

```
hooks_utility_ensure_file_edit 'CHANGELOG.md' 'merge-binary-finish_feature'
```

Ensure `CHANGELOG.md` is modified when finishing a feature branch
and merge into `dev` branch.

