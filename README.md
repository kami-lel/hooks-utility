# hooks-utility README

a collections of utility functions for **git hooks**

<!-- todo auto generate better commit/merge message -->
<!-- todo read configurations from env? -->
<!-- fixme in _search_am_from_git_diff_cached
print lines, with format of line number & coloring AM -->
<!-- todo merge into main (i.e. release,)  make sure version is updated -->










## Installation

Use `hooks_utility.sh` by place it alongside git hooks scripts.

Typical folder structure:

```
.
└── scripts
    └── hooks
        ├── hooks_utility.sh
        ├── pre-merge-commit
        └── ...
```

And in the git hook scripts (e.g. `pre-merge-commit` above,)
**source** the `hooks_utility.sh`:

```bash
source "$(dirname "${BASH_SOURCE[0]}")/hooks_utility.sh"
```















## Functionality

### log style message

Print log style message (i.e. prefixed with `DEBUG`, `ERROR`, ...)
to `stdout` or `stderr`, using these 5 functions, e.g.:

```bash
echo "Debug Message Content" | hooks_utility_debug 
echo "Warning Message Content"  | hooks_utility_warning -dt  "MainScript"
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




### AM check

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
hooks_utility_am_check
```

Checks will be performed during merge,
it will be rejected if incoming branch contains disallowed AM.





### ensure file changed

In `pre-commit`, ensure some file is edited.

E.g., in `pre-commit`

```
hooks_utility_ensure_file_edit 'CHANGELOG.md' 'merge-binary-finish_feature'
```

Ensure `CHANGELOG.md` is modified when finishing a feature branch
and merge into `dev` branch.