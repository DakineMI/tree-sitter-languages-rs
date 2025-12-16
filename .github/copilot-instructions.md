---
description: AI rules derived by SpecStory from the project AI interaction history
globs: *
---

## HEADERS

(No existing content)

## TECH STACK

- tree-sitter CLI version 0.26.3
- fd CLI version 10.3.0
- Node.js v22.18.0

## PROJECT DOCUMENTATION & CONTEXT SYSTEM

(No existing content)

## CODING STANDARDS

- When generating language grammars, always ensure the `tree-sitter.json` file includes the `metadata` field.
- When working with `extern "C"` blocks in Rust, always mark them as `unsafe`.
- When calling `HighlightConfiguration::new` in `build.rs`, always provide the 5th argument for tags.
- When using `tree-sitter` to generate code, always run `git submodule update --init --recursive --force` first to ensure submodules are correctly initialized and any local changes are overwritten. This is especially important for generated files like `src/parser.c`.

## WORKFLOW & RELEASE RULES

(No existing content)

## DEBUGGING

- If `git submodule update` fails, check for uncommitted local changes in the submodules. Use `git status` to identify these changes. Resolve the conflicts by either committing, stashing, or discarding the changes as appropriate.
- When troubleshooting feature-related issues, ensure that all necessary features are enabled, especially when running examples or tests. The `required-features = ["all"]` directive in `Cargo.toml` can be used to ensure all features are enabled.
- When troubleshooting `cargo test` failures, redirect the output to a file (`cargo test > test_output.txt 2>&1`) for detailed analysis if the terminal output is incomplete or missing.
- If encountering module-not-found errors, verify the public API of the crate and how modules are exposed (e.g., through feature gating).

## BEST PRACTICES

- Before assuming a project is ready for use in another project, always verify that:
    - `cargo build` runs without errors.
    - `cargo test` passes all unit tests and documentation tests.
    - Submodules are synchronized and configured correctly.
    - `tree-sitter.json` files have been generated for all parsers.
- When providing instructions for using the library, include both local path and Git dependency options in `Cargo.toml`.
- When adding a crate as a Git dependency, specify the branch.