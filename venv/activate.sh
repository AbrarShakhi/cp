#!/usr/bin/env bash
# Activate the cp dev environment.
# Usage: source venv/activate.sh

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "activate.sh must be sourced, not executed." >&2
    echo "  Use: source venv/activate.sh" >&2
    exit 1
fi

if [[ -n "${CP_VENV:-}" ]]; then
    echo "cp venv already active (CP_ROOT=$CP_ROOT)" >&2
    return 0
fi

CP_VENV_DIR="$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd
)"

export CP_ROOT="$(dirname "$CP_VENV_DIR")"
export CP_OLD_PATH="$PATH"
export CP_OLD_PS1="${PS1:-}"

export PATH="$CP_VENV_DIR/scripts:$PATH"
export CP_VENV=1

PS1="(cp) ${PS1:-}"
export PS1

echo "cp venv activated (CP_ROOT=$CP_ROOT)"
echo "available: rcpp, rrs, rkt"
