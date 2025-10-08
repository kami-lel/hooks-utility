# hooks-utility

a collections of utility functions for **git hooks**

## Installation

<!-- TODO installation instructions -->

enable git hooks:

```bash
git config core.hooksPath scripts/hooks
```












## Functionality

### log message





### annotation marker (AM) check

```mermaid
flowchart TD        
    feature[Feature Branches] --> |assert no ...| a
    a{TODOs} -->|merge| dev
    dev["**dev**" Branch ] -->|assert no ...| b & c
    b{TODOs} -->|merge| main
    c{Todos} -->|merge| main
    main["**main**" Branch ]
```
