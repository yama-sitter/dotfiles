# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managed by chezmoi (v2.63.0+). The repository contains configurations for:
- Neovim (Lua-based, using lazy.nvim)
- Zsh (with sheldon plugin manager)
- Git (with GPG signing and difftastic)
- WezTerm (terminal emulator)
- Development tools (installed via Homebrew)

## Chezmoi File Naming Conventions

Chezmoi uses special prefixes and suffixes for file management:

- `dot_` prefix → translates to `.` in the target system
  - Example: `dot_gitconfig.tmpl` → `~/.gitconfig`
- `private_` prefix → sets file permissions to 0600
  - Example: `private_dot_zshrc.tmpl` → `~/.zshrc` (with restricted permissions)
- `.tmpl` suffix → indicates the file is a template with variables
  - Variables like `{{ .email }}`, `{{ .gpg_key }}` are replaced when applied

## Common Commands

### Chezmoi Operations

```bash
# View what would change (dry run)
chezmoi diff

# Apply all changes to the system
chezmoi apply

# Add a new file to chezmoi management
chezmoi add <file>

# Edit a managed file (opens in editor, auto-applies on save)
chezmoi edit <file>

# Re-apply a specific file
chezmoi apply <file>

# Check for differences between source and target
chezmoi status
```

### Homebrew Management

```bash
# Install all packages from Brewfile
brew bundle install

# Remove packages not listed in Brewfile
brew bundle cleanup

# Check what would be installed/removed
brew bundle check
```

### Neovim Plugin Management

Plugins are managed by lazy.nvim and automatically installed on first launch.

```bash
# Open Neovim
nvim

# Inside Neovim, check plugin status
:Lazy

# Update all plugins
:Lazy update

# Clean unused plugins
:Lazy clean
```

### Zsh Plugin Management

Plugins are managed by sheldon:

```bash
# Edit plugin configuration
sheldon edit  # or: s (alias)

# Update all plugins
sheldon lock --update

# Reload zsh configuration
relogin  # or: exec $SHELL -l
```

## Architecture

### Neovim Configuration Structure

Location: `dot_config/nvim/`

```
nvim/
├── init.lua                    # Entry point, loads all config modules
├── lazy-lock.json             # Lock file for lazy.nvim plugins
└── lua/
    ├── config/                # Core configuration
    │   ├── options.lua       # Vim options (tabstop, expandtab, etc.)
    │   ├── keymaps.lua       # Key mappings
    │   ├── autocmds.lua      # Auto commands
    │   ├── functions.lua     # Custom functions
    │   ├── filetypes.lua     # Filetype-specific settings
    │   └── lazy.lua          # lazy.nvim plugin manager setup
    └── plugins/               # Plugin configurations (lazy.nvim auto-loads)
        ├── lsp.lua           # LSP configuration
        ├── cmp.lua           # Completion (nvim-cmp)
        ├── search.lua        # Telescope/search plugins
        ├── git.lua           # Git integration (gitsigns, etc.)
        ├── debug.lua         # DAP debugging
        ├── theme.lua         # Color schemes and UI
        ├── buffer.lua        # Buffer management
        ├── cursor.lua        # Cursor movements
        ├── sintax.lua        # Syntax highlighting (treesitter)
        ├── md.lua            # Markdown support
        └── view.lua          # View management
```

**Key Points:**
- lazy.nvim automatically loads all files in `lua/plugins/`
- Each plugin file should return a lazy.nvim plugin spec
- Configuration follows a modular structure: core settings in `config/`, plugin-specific in `plugins/`

### Zsh Configuration

Location: `private_dot_zshrc.tmpl`

**Key Features:**
- **Plugin Manager:** sheldon (config: `dot_config/sheldon/plugins.toml`)
- **Prompt:** starship (config: `dot_config/starship.toml`)
- **Fuzzy Finder:** fzf with custom key bindings
  - `Ctrl+R`: Command history search
  - `Ctrl+T`: File search
  - `Ctrl+Z`: Jump to frecent directories (z integration)
  - `Ctrl+V`: Jump to ghq repositories
  - `Ctrl+X`: Git branch checkout
  - `Ctrl+O`: Open file in nvim
  - `Ctrl+G`: Grep and open in nvim

**Custom Functions:**
- `z-cd`: fzf-powered directory jumping (Ctrl+Z)
- `fzf-cd` / `fcd`: Interactive directory navigation
- `root-cd` / `rcd`: Jump to git repository root
- `fzf-ghq-cd`: Navigate ghq-managed repositories
- `fzf-git-checkout`: Interactive branch checkout
- `fzf-edit-vim`: Search and edit files
- `fzf-grep-vim`: Grep and edit files
- `fzf-git-branch-delete` / `fgbd`: Multi-select branch deletion

### Git Configuration

Location: `dot_gitconfig.tmpl`

**Template Variables:**
- `{{ .email }}`: User email address
- `{{ .gpg_key }}`: GPG signing key ID
- `{{ .git_diff_highlight_path }}`: Path to diff-highlight tool

**Key Features:**
- GPG commit signing enabled by default
- Difftastic as the default diff tool
- Auto-stash for pull/rebase operations
- Zdiff3 conflict style
- Auto-squash for fixup commits
- Histogram diff algorithm
- HTTPS to SSH URL rewriting for GitHub

**Notable Aliases:**
- `git rb`: Interactive rebase from merge-base (useful for feature branches)
- `git wt`: Shortcut for worktree commands

### WezTerm Configuration

Location: `dot_wezterm.lua`

**Key Bindings:**
- `Shift+Cmd+|`: Split horizontally
- `Shift+Cmd+_`: Split vertically
- `Shift+Cmd+R`: Enter resize mode
- `Shift+Cmd+H/J/K/L`: Navigate panes
- `Shift+Cmd+Z`: Toggle pane zoom

**Default Layout:**
On startup, automatically creates a split layout (bottom pane at 10% height, left pane at 90% width).

## Important Notes

### Working with Template Files

When modifying `.tmpl` files:
1. Template variables are defined in chezmoi's data (check with `chezmoi data`)
2. After editing, always run `chezmoi apply` to see the actual rendered output
3. Never manually edit files in `~/` - always edit through chezmoi

### Testing Changes

Before applying changes system-wide:
```bash
# Review what would change
chezmoi diff

# Apply to a specific file only
chezmoi apply --dry-run --verbose <file>
chezmoi apply <file>
```

### Neovim Plugin Development

When adding/modifying plugins:
1. Create or edit a file in `dot_config/nvim/lua/plugins/`
2. Return a lazy.nvim plugin spec (table or array of tables)
3. Restart Neovim or run `:Lazy reload` to load changes
4. Check for errors with `:Lazy log` or `:checkhealth`
