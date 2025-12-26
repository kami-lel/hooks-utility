# hooks-utility CHANGELOG

[^format]

<!-- BUG branch protection: \n in line get interpreted -->













## [Unreleased]

### Added

*Get Commit Type*:

- option `-r` of `hooks_utility_get_commit_type`: show `"regular"` instead of empty string
- `hooks_utility_debug_commit_type`

*Branch Protection*:

- function of `SKIP_BRANCH_PROTECTION`

*Ensure File Modified*:

- calling of `hooks_utility_ensure_version_updated()` with arguments,
  allowing checking multiple files for version information

### Changed
### Deprecated
### Removed
### Fixed













## [2.1.0] - 2025-12-22

### Added

- module *get commit type*: provide automated improved commit message for specific types of merges
- consolidate module *get commit types* with new conditional commands
- *log style message*:

  - `-D` flag
  - `hooks_utility_skip` function

### Changed

- use `PREREQUISITE` in function documentations
- function of ensure version updated utilize environment variable














## [2.0.0] - 2025-12-19

### Added

- module *colorful print*

### Changed

- change project structure to use it as **git submodule**
- rename functionality to **branch protection** from *annotational marker check*
- rename functionality to **ensure file modified** from *ensure file change*
- rewrite logic for ensure file modified
- rewrite logic for ANSI color handling














## [1.1.1] - 2025-10-16

### Added

- finish log message in example `pre-commit`

### Fixed

- return constant `LOGGING_LEVEL` to `20`
- AM check, file fail to print multiple lines













## [1.1.0] - 2025-10-16

### Added

- **padding print** functionality
- **AM check** functionality
- **ensure file changed** functionality

### Changed

- change parameter parsing logic for *log style message* functions

  - add `SOURCE` optional argument & related logic
  - date/time format distinguishable by coloring

- update `README.md` with new functions













## [1.0.0] - 2025-10-12

### Added

- log style message















[unreleased]: https://github.com/kami-lel/kami-log-py/compare/v2.1.0...dev
[2.1.0]: https://github.com/kami-lel/kami-log-py/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/kami-lel/kami-log-py/compare/v1.1.1...v2.0.0
[1.1.1]: https://github.com/kami-lel/kami-log-py/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/kami-lel/kami-log-py/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/kami-lel/kami-log-py/releases/tag/v1.0.0













[^format]: CHANGELOG format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); Version scheme adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).