---
name: Bug Report
about: Report a bug with the product
title: "[BUG] New bug report"
labels: "type :: bug"
assignees: ''
body:
  - type: textarea
    id: expected-behavior
    attributes:
      label: Expected Behavior
      description: What is the expected behavior?
    validations:
      required: true

  - type: textarea
    id: current-behavior
    attributes:
      label: Current Behavior
      description: What is the current behavior?
    validations:
      required: true

  - type: textarea
    id: information
    attributes:
      label: Information
      description: Please help provide information about the bug
    validations:
      required: true

  - type: textarea
    id: reproduction-steps
    attributes:
      label: Reproduction Steps
      description: Please provide detailed steps for reproducing the issue
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: Log Files (If Applicable)
      description: Please include any relevant log snippets or files here
      render: shell
    validations:
      required: false

---

# Expected Behavior
<!-- Please describe the behavior you are expecting !-->

# Current Behavior
<!-- What is the current behavior? !-->

# Information
<!-- Please help provide information about the failure if this is a bug. If it is not a bug, please remove the rest of this template. !-->

## Reproduction Steps
<!-- Please provide detailed steps for reproducing the issue.

1. step 1
2. step 2
3. you get it... !-->

## Failure Logs (If Applicable)
<!-- Please include any relevant log snippets or files here. !-->
