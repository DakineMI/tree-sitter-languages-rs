#!/bin/bash
# Deep Research CLI Tool Dependencies
# This script sets up all required dependencies for the deep-researcher Rust project
# Run with: chmod +x dependencies.sh && ./dependencies.sh
# Run dry-run: ./dependencies.sh --dry-run

set -e  # Exit on any error

# Detect and navigate to project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR"

if [ ! -f "./Cargo.toml" ]; then
    echo "Error: Cargo.toml not found in current directory. Please run this script from the project root."
    exit 1
fi

add_sitter() {
    local repo=$1
    # Extract repository name and create sitter path
    local base_name=$(basename "$repo" .git)
    local path="sitters/$base_name"

    # Navigate to project root
    cd "$PROJECT_ROOT" || exit 1

    # Create sitters directory if it doesn't exist
    if [ ! -d "sitters" ]; then
        echo "Creating sitters directory..."
        if [ "$DRY_RUN" = false ]; then
            mkdir -p sitters
        else
            echo "📦 Would create sitters directory"
        fi
    fi

    # Check if submodule already exists
    if [ -d "$path/.git" ] || git config --file .gitmodules submodule."$path".url >/dev/null 2>&1; then
        echo "✓ $path sitter already exists - skipping"
        return 0
    fi

    if [ "$DRY_RUN" = false ]; then
        echo "📦 Adding sitter $repo..."

        # Add the submodule
        if ! git submodule add --quiet "$repo" "$path" 2>/dev/null; then
            echo "❌ Failed to add sitter $repo"
            return 1
        fi

        # Verify the submodule was added to .gitmodules
        if ! git config --file .gitmodules --get "submodule.$path.url" >/dev/null 2>&1; then
            echo "❌ Failed to verify sitter $repo was added"
            return 1
        fi

        echo "✓ $path submodule added successfully"
    else
        echo "📦 Would add sitter $repo to $path..."
    fi
}

# Programming language parsers and utilities (sorted alphabetically)
add_sitter https://github.com/tree-sitter/tree-sitter-bash || true
add_sitter https://github.com/tree-sitter/tree-sitter-c || true
add_sitter https://github.com/tree-sitter/tree-sitter-cpp || true
add_sitter https://github.com/tree-sitter/tree-sitter-c-sharp || true
add_sitter https://github.com/tree-sitter/tree-sitter-css || true
add_sitter https://github.com/tree-sitter-grammars/tree-sitter-csv || true
add_sitter https://github.com/gdamore/tree-sitter-d || true
add_sitter https://github.com/UserNobody14/tree-sitter-dart || true
add_sitter https://github.com/ValdezFOmar/tree-sitter-editorconfig || true
add_sitter https://github.com/elixir-lang/tree-sitter-elixir || true
add_sitter https://github.com/WhatsApp/tree-sitter-erlang || true
add_sitter https://github.com/tree-sitter/tree-sitter-go || true
add_sitter https://github.com/tree-sitter/tree-sitter-haskell || true
add_sitter https://github.com/tree-sitter/tree-sitter-html || true
add_sitter https://github.com/justinmk/tree-sitter-ini|| true
add_sitter https://github.com/tree-sitter/tree-sitter-java || true
add_sitter https://github.com/tree-sitter/tree-sitter-javascript || true
add_sitter https://github.com/tree-sitter/tree-sitter-json || true
add_sitter https://github.com/tree-sitter/tree-sitter-julia || true
add_sitter https://github.com/fwcd/tree-sitter-kotlin || true
add_sitter https://github.com/MunifTanjim/tree-sitter-lua || true
add_sitter https://github.com/tree-sitter-grammars/tree-sitter-markdown || true
add_sitter https://github.com/tree-sitter-perl/tree-sitter-perl || true
add_sitter https://github.com/tree-sitter/tree-sitter-php || true
add_sitter https://github.com/tree-sitter/tree-sitter-python || true
add_sitter https://github.com/r-lib/tree-sitter-r || true
add_sitter https://github.com/tree-sitter/tree-sitter-ruby || true
add_sitter https://github.com/tree-sitter/tree-sitter-rust || true
add_sitter https://github.com/tree-sitter/tree-sitter-scala || true
add_sitter https://github.com/alex-pinkus/tree-sitter-swift || true
add_sitter https://github.com/tree-sitter-grammars/tree-sitter-toml || true
add_sitter https://github.com/tree-sitter/tree-sitter-typescript || true
add_sitter https://github.com/neovim/tree-sitter-vim || true
add_sitter https://github.com/tree-sitter-grammars/tree-sitter-xml || true
add_sitter https://github.com/tree-sitter-grammars/tree-sitter-yaml || true
add_sitter https://github.com/keidax/tree-sitter-crystal || true
add_sitter https://github.com/alaviss/tree-sitter-nim || true

# Data formats and configuration
add_sitter https://github.com/camdencheek/tree-sitter-dockerfile || true
add_sitter https://github.com/ObserverOfTime/tree-sitter-requirements || true

# Build systems and automation
add_sitter https://github.com/uyha/tree-sitter-cmake || true
add_sitter https://github.com/airbus-cert/tree-sitter-powershell || true

# Database and query languages
add_sitter https://github.com/DerekStride/tree-sitter-sql || true

# Infrastructure and DevOps
add_sitter https://github.com/MichaHoffmann/tree-sitter-hcl || true

# Web technologies and frameworks
add_sitter https://github.com/Himujjal/tree-sitter-svelte || true
add_sitter https://github.com/tree-sitter-grammars/tree-sitter-vue || true

cd "$PROJECT_ROOT"
git pull --recurse-submodules --ff-only --all
git submodule update --init 
fd '^grammar.js$' . -x tree-sitter generate {} ;
