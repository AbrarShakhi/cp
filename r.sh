#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$ROOT/template"
SRC_DIR="$ROOT/src"
OUT_DIR="$ROOT/out"
IN_FILE="$ROOT/in.txt"

mkdir -p "$SRC_DIR"
mkdir -p "$OUT_DIR"

# ─── C++ ─────────────────────────────────────────────────────────────────────
_cpp_new() {
    local name="${1:?Usage: r cpp new <name>}"
    local file="$SRC_DIR/$name.cpp"

    [[ -e "$file" ]] && {
        echo "error: $file already exists"
        exit 1
    }

    cp "$TEMPLATE_DIR/Template.cpp" "$file"
    echo "created $file"
}

_cpp_run() {
    local name="${1:?Usage: r cpp run <name>}"
    local src="$SRC_DIR/$name.cpp"
    local bin="$OUT_DIR/$name.out"

    [[ ! -f "$src" ]] && {
        echo "error: $src not found"
        exit 1
    }

    g++ -std=c++17 -O2 -Wall -Wextra -o "$bin" "$src"

    echo "─── output ──────────────────────────────"
    "$bin" < "$IN_FILE"
}

_cpp_debug() {
    local name="${1:?Usage: r cpp debug <name>}"
    local src="$SRC_DIR/$name.cpp"
    local bin="$OUT_DIR/$name.dbg"

    [[ ! -f "$src" ]] && {
        echo "error: $src not found"
        exit 1
    }

    g++ -std=c++17 \
        -g -DLOCAL -DDEBUG \
        -fsanitize=address,undefined \
        -o "$bin" "$src"

    echo "─── output (debug) ──────────────────────"
    "$bin" < "$IN_FILE"
}

_cpp() {
    local sub="${1:-}"
    shift || true

    case "$sub" in
        new)   _cpp_new   "$@" ;;
        run)   _cpp_run   "$@" ;;
        debug) _cpp_debug "$@" ;;
        *)     echo "usage: r cpp {new|run|debug} <name>"; exit 1 ;;
    esac
}

# ─── Kotlin ──────────────────────────────────────────────────────────────────
_kt_new() {
    local name="${1:?Usage: r kt new <name>}"
    local file="$SRC_DIR/$name.kt"

    [[ -e "$file" ]] && {
        echo "error: $file already exists"
        exit 1
    }

    cp "$TEMPLATE_DIR/Template.kts" "$file"
    echo "created $file"
}

_kt_run() {
    local name="${1:?Usage: r kt run <name>}"
    local src="$SRC_DIR/$name.kt"
    local jar="$OUT_DIR/$name.jar"

    [[ ! -f "$src" ]] && {
        echo "error: $src not found"
        exit 1
    }

    kotlinc "$src" -include-runtime -d "$jar" 2>/dev/null

    echo "─── output ──────────────────────────────"
    java -jar "$jar" < "$IN_FILE"
}

_kt_debug() {
    local name="${1:?Usage: r kt debug <name>}"
    local src="$SRC_DIR/$name.kt"
    local jar="$OUT_DIR/$name.jar"

    [[ ! -f "$src" ]] && {
        echo "error: $src not found"
        exit 1
    }

    kotlinc "$src" -include-runtime -d "$jar"

    echo "─── output (debug) ──────────────────────"
    LOCAL=1 java -jar "$jar" < "$IN_FILE"
}

_kt() {
    local sub="${1:-}"
    shift || true

    case "$sub" in
        new)   _kt_new   "$@" ;;
        run)   _kt_run   "$@" ;;
        debug) _kt_debug "$@" ;;
        *)     echo "usage: r kt {new|run|debug} <name>"; exit 1 ;;
    esac
}

# ─── Top-level ────────────────────────────────────────────────────────────────
case "${1:-}" in
    cpp)
        shift
        _cpp "$@"
        ;;
    kt)
        shift
        _kt "$@"
        ;;
    clear)
        rm -f "$OUT_DIR"/*.out \
              "$OUT_DIR"/*.dbg \
              "$OUT_DIR"/*.jar 2>/dev/null || true
        echo "cleared out/"
        ;;
    *)
        echo "usage: r {cpp|kt|clear} ..."
        echo "       r cpp {new|run|debug} <name>"
        echo "       r kt  {new|run|debug} <name>"
        exit 1
        ;;
esac