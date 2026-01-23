# Claude Code Shell Completion

Shell completion scripts for [Claude Code](https://claude.com/claude-code), providing tab completion for commands, subcommands, and options in both bash and zsh.

## Features

- **Command completion**: Tab complete `claude` subcommands (`mcp`, `plugin`, `setup-token`, `doctor`, `update`, `install`)
- **Option completion**: All CLI options and flags are completable
- **Contextual suggestions**: Option values are suggested where applicable
  - Output formats: `text`, `json`, `stream-json`
  - Permission modes: `acceptEdits`, `bypassPermissions`, `default`, `delegate`, `dontAsk`, `plan`
  - Models: `sonnet`, `opus`, `haiku`, etc.
  - Setting sources: `user`, `project`, `local`
- **File path completion**: For options that expect file paths (e.g., `--settings`, `--mcp-config`, `--add-dir`, `--file`)

## Installation

### Bash

#### Method 1: System-wide installation

```bash
sudo cp claude-completion.bash /etc/bash_completion.d/claude
```

Then reload your shell or run:
```bash
source /etc/bash_completion.d/claude
```

#### Method 2: User-level installation

```bash
mkdir -p ~/.local/share/bash-completion/completions
cp claude-completion.bash ~/.local/share/bash-completion/completions/claude
```

Add to your `~/.bashrc`:
```bash
source ~/.local/share/bash-completion/completions/claude
```

#### Method 3: Manual sourcing

Add to your `~/.bashrc`:
```bash
source /path/to/claude-completion.bash
```

### Zsh

#### Method 1: System-wide installation

```bash
sudo cp _claude /usr/local/share/zsh/site-functions/_claude
```

Then reload completion:
```zsh
rm -f ~/.zcompdump; compinit
```

#### Method 2: User-level installation with oh-my-zsh

```bash
mkdir -p ~/.oh-my-zsh/custom/plugins/claude
cp _claude ~/.oh-my-zsh/custom/plugins/claude/_claude
```

Add to your `~/.zshrc`:
```zsh
plugins=(... claude)
```

#### Method 3: Manual fpath

Add to your `~/.zshrc` before `compinit`:
```zsh
fpath=(/path/to/cc-completion $fpath)
autoload -Uz compinit && compinit
```

## Usage Examples

After installation, you can use tab completion with the `claude` command:

```bash
# Complete subcommands
claude <TAB>
# Shows: mcp plugin setup-token doctor update install

# Complete options
claude --<TAB>
# Shows: --debug --verbose --print --model --help ...

# Complete option values
claude --output-format <TAB>
# Shows: text json stream-json

claude --permission-mode <TAB>
# Shows: acceptEdits bypassPermissions default dontAsk plan

claude --model <TAB>
# Shows: sonnet opus haiku claude-sonnet-4-5-20250929

# Complete install targets
claude install <TAB>
# Shows: stable latest --help

# File path completion
claude --settings <TAB>
# Shows files and directories
```

## Supported Commands

- `mcp` - Configure and manage MCP servers
- `plugin` - Manage Claude Code plugins
- `setup-token` - Set up a long-lived authentication token
- `doctor` - Check the health of your Claude Code auto-updater
- `update` - Check for updates and install if available
- `install` - Install Claude Code native build

## Supported Options

All Claude Code CLI options are supported, including:

- Session management: `--continue`, `--resume`, `--fork-session`
- Model selection: `--model`, `--fallback-model`
- Output control: `--print`, `--output-format`, `--input-format`
- Permissions: `--permission-mode`, `--dangerously-skip-permissions`
- Tools: `--tools`, `--allowed-tools`, `--disallowed-tools`
- MCP: `--mcp-config`, `--strict-mcp-config`
- File resources: `--file`
- And many more...

## Testing

To verify the installation:

```bash
# For bash
type _claude_completion

# For zsh
which _claude
```

Try tab completion:
```bash
claude --mod<TAB>
# Should complete to: claude --model
```

## Troubleshooting

### Bash completion not working

1. Ensure `bash-completion` package is installed:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install bash-completion

   # macOS (Homebrew)
   brew install bash-completion@2
   ```

2. Verify bash-completion is loaded in your shell:
   ```bash
   type _init_completion
   ```

### Zsh completion not working

1. Ensure `compinit` is called in your `~/.zshrc`:
   ```zsh
   autoload -Uz compinit && compinit
   ```

2. Rebuild completion cache:
   ```zsh
   rm -f ~/.zcompdump*; compinit
   ```

3. Verify the completion function is loaded:
   ```zsh
   which _claude
   ```

## Contributing

If you find missing commands or options, please update the completion scripts:

- For bash: Edit `claude-completion.bash`
- For zsh: Edit `_claude`

## License

MIT
