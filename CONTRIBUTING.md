# Contributing to the Project

We're delighted that you want to contribute to our project. Your contribution helps improve our software and make it better for all users. Before you get started, please read these guidelines to understand how to contribute effectively.

## Git Branch Naming Conventions

Branches in this repository follow specific naming conventions to maintain order and consistency in development. Here are the conventions for branch names:

- **Main Branch**:
   - `main`: Represents the main development branch. Stable and deployment-ready code is stored here.

- **Development Branch**:
   - `develop`: Used for continuous development. New features and bug fixes are merged into this branch.

- **Feature Branches**:
   - `feature/<feature-name>`: Create a separate branch for each new feature.

- **Bugfix Branches**:
   - `bugfix/<bug-name>`: Create a branch to fix a specific bug.

- **Release Branches**:
   - `release/<version>`: Used to prepare a specific version of the application.

- **Version Hotfix Branches**:
   - `hotfix/<fix-name>`: For urgent version fixes.

- **Documentation Branches**:
   - `docs/<documentation-name>`: Used for project documentation.

- **Experiment Branches**:
   - `experiment/<experiment-name>`: For experimental explorations.

- **Individual Work Branches**:
   - `user/<username>`: Some teams use personal branches for individual work.

Be sure to follow these branch naming conventions to maintain a consistent and organized version control.

## Commit Types

Commit messages also follow specific conventions. Here are the accepted commit types:

- **feat**: Adds a new feature.
- **fix**: Fixes a bug.
- **docs**: Updates documentation.
- **style**: Improves code style (formatting, indentation, etc.).
- **refactor**: Makes code refactors that don't fix a bug or add a feature.
- **chore**: Performs general maintenance tasks.

Each commit message should adhere to the following format:

<type>(<scope>): <description>

<optional body>
<optional footer>
```

- type: The commit type (as mentioned above).
- scope: (Optional) The scope of the commit, i.e., the project section it relates to.
- description: A concise description of the change.
- body: (Optional) A more detailed description of the change.
- footer: (Optional) Ticket closing notes, if applicable.

## Contribution Process
To contribute to the project, follow these steps:

1. Fork the project to your own GitHub account.
2. Create a branch with a descriptive name based on the branch naming conventions (see above).
3. Work on your contribution in this branch.
4. Ensure to test and document your code.
5. Create a Pull Request (PR) to the project's main branch.

## Code Standards

We adhere to strict code standards. Make sure your code complies with these standards. Use static analysis tools or linters to identify and rectify issues.

## Issue Reporting

If you find a bug or wish to suggest an improvement, please create an issue report in this repository. Be sure to provide as much information as possible.
