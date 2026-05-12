# Shell wrapper for wt-cli.
# Source this file from ~/.zshrc so `wt` can cd in the current shell.

wt() {
  local wt_cli target exit_code
  wt_cli="${WT_CLI_BIN:-$HOME/Docs/GitHub/trogui/wt-cli/bin/wt-cli}"

  if [ ! -x "$wt_cli" ]; then
    echo "wt: executable not found: $wt_cli" >&2
    return 1
  fi

  case "${1:-}" in
    -h|--help|help|delete|del|remove|rm)
      "$wt_cli" "$@"
      return
      ;;
  esac

  target="$($wt_cli "$@")"
  exit_code=$?
  [ "$exit_code" -ne 0 ] && return "$exit_code"

  if [ -n "$target" ]; then
    cd "$target"
  fi
}
