#!/usr/bin/env bash
# Bash completion script for Claude Code
# Install: source this file or place it in /etc/bash_completion.d/

_claude_completion() {
    local cur prev words cword
    _init_completion || return

    # Commands
    local commands="mcp plugin setup-token doctor update install"

    # Global options
    local global_opts="
        --debug --verbose --print --output-format --json-schema
        --include-partial-messages --input-format --mcp-debug
        --dangerously-skip-permissions --allow-dangerously-skip-permissions
        --max-budget-usd --replay-user-messages --allowedTools --allowed-tools
        --tools --disallowedTools --disallowed-tools --mcp-config
        --system-prompt --append-system-prompt --permission-mode
        --continue --resume --fork-session --no-session-persistence
        --model --agent --betas --fallback-model --settings --add-dir
        --ide --strict-mcp-config --session-id --agents --setting-sources
        --plugin-dir --disable-slash-commands --version --help
        -d -p -c -r -v -h
    "

    # Handle subcommands
    local i cmd
    for ((i=1; i < cword; i++)); do
        if [[ ${words[i]} != -* ]]; then
            cmd=${words[i]}
            break
        fi
    done

    # If we're completing the first argument (command or option)
    if [[ $cword -eq 1 ]] || [[ -z $cmd ]]; then
        case "$cur" in
            -*)
                COMPREPLY=($(compgen -W "$global_opts" -- "$cur"))
                return 0
                ;;
            *)
                COMPREPLY=($(compgen -W "$commands" -- "$cur"))
                return 0
                ;;
        esac
    fi

    # Subcommand-specific completion
    case "$cmd" in
        mcp)
            local mcp_opts="--help -h"
            COMPREPLY=($(compgen -W "$mcp_opts" -- "$cur"))
            ;;
        plugin)
            local plugin_opts="--help -h"
            COMPREPLY=($(compgen -W "$plugin_opts" -- "$cur"))
            ;;
        setup-token)
            local setup_token_opts="--help -h"
            COMPREPLY=($(compgen -W "$setup_token_opts" -- "$cur"))
            ;;
        doctor)
            local doctor_opts="--help -h"
            COMPREPLY=($(compgen -W "$doctor_opts" -- "$cur"))
            ;;
        update)
            local update_opts="--help -h"
            COMPREPLY=($(compgen -W "$update_opts" -- "$cur"))
            ;;
        install)
            local install_opts="--help -h --options stable latest"
            case "$prev" in
                install)
                    COMPREPLY=($(compgen -W "stable latest --help" -- "$cur"))
                    ;;
                *)
                    COMPREPLY=($(compgen -W "$install_opts" -- "$cur"))
                    ;;
            esac
            ;;
    esac

    # Option-specific value completion
    case "$prev" in
        --output-format)
            COMPREPLY=($(compgen -W "text json stream-json" -- "$cur"))
            ;;
        --input-format)
            COMPREPLY=($(compgen -W "text stream-json" -- "$cur"))
            ;;
        --permission-mode)
            COMPREPLY=($(compgen -W "acceptEdits bypassPermissions default dontAsk plan" -- "$cur"))
            ;;
        --model|--fallback-model)
            COMPREPLY=($(compgen -W "sonnet opus haiku claude-sonnet-4-5-20250929" -- "$cur"))
            ;;
        --setting-sources)
            COMPREPLY=($(compgen -W "user project local" -- "$cur"))
            ;;
        --json-schema|--system-prompt|--append-system-prompt|--agents)
            # These expect custom input, don't suggest anything
            COMPREPLY=()
            ;;
        --mcp-config|--settings|--plugin-dir|--add-dir)
            # File/directory completion
            _filedir
            ;;
        --max-budget-usd|--session-id|--debug)
            # Custom values, no completion
            COMPREPLY=()
            ;;
        -r|--resume)
            # Could potentially list session IDs, but skip for now
            COMPREPLY=()
            ;;
        *)
            # Default: suggest global options if not in a subcommand
            if [[ -z $cmd ]]; then
                COMPREPLY=($(compgen -W "$global_opts" -- "$cur"))
            fi
            ;;
    esac

    return 0
}

complete -F _claude_completion claude
