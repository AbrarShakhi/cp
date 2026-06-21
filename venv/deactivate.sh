#!/usr/bin/env bash
# Deactivate the cp dev environment.
# Usage: source venv/deactivate.sh

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "deactivate.sh must be sourced, not executed." >&2
    echo "  Use: source venv/deactivate.sh" >&2
    exit 1
fi

if [[ -z "${CP_VENV:-}" ]]; then
    echo "cp venv is not active." >&2
    return 0
fi

export PATH="$CP_OLD_PATH"
PS1="$CP_OLD_PS1"
export PS1

unset CP_ROOT CP_VENV CP_OLD_PATH CP_OLD_PS1

echo "cp venv deactivated"
