# rs-tree-sitter-languages

A collection of tree sitter parsers packaged into a single crate with `tree-sitter-highlight` support.
The `build.rs` is also tuned to statically link parsers that depend on `libstdc++`.

Every parser is included as a git submodule and has it's own Cargo Feature.

## Usage

Enable the parsers you need through cargo features, by default all features are enabled.

```rust
// Get the TreeSitter language
let _ = rs_tree_sitter_languages::bash::language();
// Get a new `HighlightConfiguration` for the language.
let _ = rs_tree_sitter_languages::bash::highlight();

// Queries are accessible module constants.
let _ = rs_tree_sitter_languages::bash::HIGHLIGHT_QUERY;
```

## Parsers

Currently includes the following parsers:

* Bash
* C
* C++
* CSS
* D
* Go
* Haskell
* Html
* Java
* JavaScript
* Json
* Lua
* Markdown
* Python
* Rust
* Toml
* Typescript / TSX
* Vim
* Yaml
