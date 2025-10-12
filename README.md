# hooks-utility README

a collections of utility functions for **git hooks**

<!-- todo installation instructions -->

<!-- ## Installation

enable git hooks:

```bash
git config core.hooksPath scripts/hooks
```












## Functionality

### log message

-->






### merging annotation marker (AM) check

<!-- 

Annotation markers:

- `TODO`s, `BUG`s, `FIXME`s, `HACK`s:
- `Todo`s, ...:
- `todo`s, ...: -->

```mermaid
flowchart TD        
    feature[Feature Branches] --> a
    a{"asserts no
    TODOs"} -->|merge| dev
    a -->|failure| feature
    dev["**dev**" Branch ] --> b & c
    b{"asserts no
    TODOs"} -->|merge| main
    b -->|failure| dev
    c{"asserts no
    Todos"} -->|merge| main
    c -->|failure| dev
    main["**main**" Branch ]
```
