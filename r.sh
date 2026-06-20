#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$ROOT/snippets"
SRC_DIR="$ROOT/src"
OUT_DIR="$ROOT/out"
IN_FILE="$ROOT/in.txt"

mkdir -p "$SRC_DIR" "$OUT_DIR"
[[ ! -e "$IN_FILE" ]] && touch "$IN_FILE"

# ─── Language Config ──────────────────────────────────────────────────────────
#
#  Each language registers itself by calling `register_lang` with:
#
#    register_lang  <id>  <ext>  <template>  <compile_fn>  <run_fn>  [<debug_compile_fn>]
#
#  where:
#    id               – the CLI token (cpp / kt / rs)
#    ext              – source file extension
#    template         – filename inside $TEMPLATE_DIR
#    compile_fn       – shell function: compile_fn <src> <out>
#    run_fn           – shell function: run_fn <out> (runs the compiled artifact)
#    debug_compile_fn – (optional) alternate compile that injects debug flags;
#                       if omitted the release compile_fn is reused

declare -A LANG_EXT
declare -A LANG_TEMPLATE
declare -A LANG_COMPILE
declare -A LANG_RUN
declare -A LANG_DEBUG_COMPILE
declare -a LANG_IDS

register_lang() {
    local id="$1" ext="$2" tmpl="$3" compile_fn="$4" run_fn="$5"
    local debug_compile_fn="${6:-$compile_fn}"   # default: same as release

    LANG_IDS+=("$id")
    LANG_EXT["$id"]="$ext"
    LANG_TEMPLATE["$id"]="$tmpl"
    LANG_COMPILE["$id"]="$compile_fn"
    LANG_RUN["$id"]="$run_fn"
    LANG_DEBUG_COMPILE["$id"]="$debug_compile_fn"
}

# ─── C++ ─────────────────────────────────────────────────────────────────────
_cpp_compile()       { g++ -std=c++17 -O2 -Wall -Wextra -o "$2" "$1"; }
_cpp_compile_debug() { g++ -std=c++17 -g -DLOCAL -DDEBUG -fsanitize=address,undefined -o "$2" "$1"; }
_cpp_run()           { "$1" < "$IN_FILE"; }

register_lang cpp cpp Template.cpp _cpp_compile _cpp_run _cpp_compile_debug

# ─── Kotlin ──────────────────────────────────────────────────────────────────
_kt_compile()        { kotlinc "$1" -include-runtime -d "$2"; }
_kt_compile_debug()  { kotlinc "$1" -include-runtime -d "$2"; }   # same build, env var differs
_kt_run()            { java -jar "$1" < "$IN_FILE"; }
_kt_run_debug()      { LOCAL=1 java -jar "$1" < "$IN_FILE"; }

register_lang kt kt Template.kts _kt_compile _kt_run _kt_compile_debug

# ─── Rust ────────────────────────────────────────────────────────────────────
_rs_compile()        { rustc -o "$2" "$1"; }
_rs_run()            { "$1" < "$IN_FILE"; }

register_lang rs rs Template.rs _rs_compile _rs_run

# ─── Generic header writer ────────────────────────────────────────────────────
_write_header() {
    local ext="$1"   # cpp | kt | rs
    local timestamp
    timestamp=$(date "+%d-%m-%Y %H:%M:%S")

    case "$ext" in
        rs)  printf '//    author:  AbrarShakhi\n//    created: %s\n\n' "$timestamp" ;;
        *)   printf '/**\n *    author:  AbrarShakhi\n *    created: %s\n **/\n\n' "$timestamp" ;;
    esac
}

# ─── Generic operations ───────────────────────────────────────────────────────
_lang_new() {
    local id="$1" name="$2"
    local ext="${LANG_EXT[$id]}"
    local file="$SRC_DIR/$name.$ext"
    local tmpl="$TEMPLATE_DIR/${LANG_TEMPLATE[$id]}"

    [[ -e "$file" ]] && { echo "error: $file already exists"; exit 1; }

    { _write_header "$ext"; cat "$tmpl"; } > "$file"
    echo "created $file"
}

_lang_run() {
    local id="$1" name="$2"
    local ext="${LANG_EXT[$id]}"
    local src="$SRC_DIR/$name.$ext"
    local bin="$OUT_DIR/$name.out"

    [[ ! -f "$src" ]] && { echo "error: $src not found"; exit 1; }

    "${LANG_COMPILE[$id]}" "$src" "$bin"
    echo "─── output ──────────────────────────────"
    "${LANG_RUN[$id]}" "$bin"
}

_lang_debug() {
    local id="$1" name="$2"
    local ext="${LANG_EXT[$id]}"
    local src="$SRC_DIR/$name.$ext"
    local bin="$OUT_DIR/$name.dbg"

    [[ ! -f "$src" ]] && { echo "error: $src not found"; exit 1; }

    "${LANG_DEBUG_COMPILE[$id]}" "$src" "$bin"
    echo "─── output (debug) ──────────────────────"

    # Kotlin debug uses a special run function; everything else reuses the normal one
    local run_fn="${LANG_RUN[$id]}"
    [[ "$id" == "kt" ]] && run_fn="_kt_run_debug"
    "$run_fn" "$bin"
}

# ─── Generic language dispatcher ─────────────────────────────────────────────
_dispatch_lang() {
    local id="$1"
    local sub="${2:-}"
    shift 2 || true

    case "$sub" in
        new) _lang_new   "$id" "${1:?Usage: $0 $id new <name>}" ;;
        run) _lang_run   "$id" "${1:?Usage: $0 $id run <name>}" ;;
        db)  _lang_debug "$id" "${1:?Usage: $0 $id db <name>}"  ;;
        *)   echo "usage: $0 $id {new|run|db} <name>"; exit 1   ;;
    esac
}

# ─── Top-level dispatcher ────────────────────────────────────────────────────
_usage() {
    echo "usage: $0 {$(IFS='|'; echo "${LANG_IDS[*]}")|clear} ..."
    for id in "${LANG_IDS[@]}"; do
        echo "       $0 $id {new|run|db} <name>"
    done
}

cmd="${1:-}"
shift || true

# Check if cmd matches a registered language (works for any future additions too)
for id in "${LANG_IDS[@]}"; do
    if [[ "$cmd" == "$id" ]]; then
        _dispatch_lang "$id" "$@"
        exit 0
    fi
done

case "$cmd" in
    clear)
        rm -rf "$OUT_DIR" "${ROOT}/target" 2>/dev/null || true
        echo "cleared"
        ;;
    *)
        _usage
        exit 1
        ;;
esac