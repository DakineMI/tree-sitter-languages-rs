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

        # Check if config exists and has metadata
        if [ -f "$config_file" ]; then
            if grep -q "metadata" "$config_file"; then
                echo "✓ $parser_name has valid tree-sitter.json"
                continue
            else
                echo "⚠ $parser_name has invalid tree-sitter.json - regenerating..."
            fi
        fi

        echo "Creating tree-sitter.json for $parser_name..."

        # Create basic configuration
        cat > "$config_file" << EOF
{
  "grammars": [
    {
      "name": "$parser_name",
      "camelcase": "$parser_name",
      "scope": "source.$parser_name",
      "path": ".",
      "file-types": [
        "$parser_name"
      ],
      "highlights": [
        "queries/highlights.scm"
      ],
      "injection-regex": "^$parser_name$"
    }
  ],
  "metadata": {
    "version": "0.21.0",
    "license": "MIT",
    "description": "$parser_name grammar for tree-sitter",
    "authors": [
      {
        "name": "tree-sitter",
        "email": "community@tree-sitter.io"
      }
    ],
    "links": {
      "repository": "https://github.com/tree-sitter/tree-sitter-$parser_name"
    }
  },
  "bindings": {
    "c": true,
    "go": true,
    "node": true,
    "python": true,
    "rust": true,
    "swift": true
  }
}
EOF

        echo "✓ Created tree-sitter.json for $parser_name"
    fi
done

echo "All tree-sitter.json files created!"
echo "Note: You may want to manually adjust file types and injection regexes for specific languages."