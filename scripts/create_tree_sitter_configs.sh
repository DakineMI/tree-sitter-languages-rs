#!/bin/bash

# Script to create tree-sitter.json files for all parser folders
# Run from the project root directory

set -e

echo "Creating tree-sitter.json files for all parser folders..."

# Get list of parser directories
for dir in sitters/tree-sitter-*/; do
    if [ -d "$dir" ]; then
        # Extract parser name (remove tree-sitter- prefix and trailing slash)
        parser_name=$(basename "$dir" | sed 's|^tree-sitter-||')
        config_file="${dir}tree-sitter.json"

        # Skip if config already exists
        if [ -f "$config_file" ]; then
            echo "✓ $parser_name already has tree-sitter.json"
            continue
        fi

        echo "Creating tree-sitter.json for $parser_name..."

        # Create basic configuration
        cat > "$config_file" << EOF
{
  "name": "tree-sitter-$parser_name",
  "version": "0.21.0",
  "description": "$parser_name grammar for tree-sitter",
  "keywords": [
    "parser",
    "lexer"
  ],
  "author": {
    "name": "tree-sitter",
    "url": "https://github.com/tree-sitter"
  },
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/tree-sitter/tree-sitter-$parser_name"
  },
  "main": "bindings/node",
  "types": "bindings/node/index.d.ts",
  "tree-sitter": [
    {
      "scope": "source.$parser_name",
      "file-types": [
        "$parser_name"
      ],
      "highlights": [
        "queries/highlights.scm"
      ],
      "injection-regex": "^$parser_name$"
    }
  ],
  "files": [
    "/bindings/node/",
    "/src/",
    "/grammar.js",
    "/LICENSE",
    "/README.md"
  ]
}
EOF

        echo "✓ Created tree-sitter.json for $parser_name"
    fi
done

echo "All tree-sitter.json files created!"
echo "Note: You may want to manually adjust file types and injection regexes for specific languages."