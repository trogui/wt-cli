#!/bin/sh

set -eu

SCRIPT_DIR=$(
  CDPATH= cd -- "$(dirname -- "$0")" && pwd
)
INSTALL_DIR="${WT_INSTALL_DIR:-$HOME/.local/share/wt-cli}"

mkdir -p "$(dirname -- "$INSTALL_DIR")"

if [ -e "$INSTALL_DIR" ] && [ ! -L "$INSTALL_DIR" ] && [ "$INSTALL_DIR" != "$SCRIPT_DIR" ]; then
  echo "wt: install target exists and is not a symlink: $INSTALL_DIR" >&2
  echo "wt: move it away or set WT_INSTALL_DIR to another path" >&2
  exit 1
fi

if [ "$INSTALL_DIR" != "$SCRIPT_DIR" ]; then
  ln -sfn "$SCRIPT_DIR" "$INSTALL_DIR"
fi

case "$(basename "${SHELL:-zsh}")" in
  zsh)
    RC_FILE="$HOME/.zshrc"
    ;;
  bash)
    RC_FILE="$HOME/.bashrc"
    ;;
  *)
    RC_FILE="$HOME/.zshrc"
    ;;
esac

cat <<EOF
Installed wt-cli at:
  $INSTALL_DIR

Add this line to $RC_FILE:
  source "$INSTALL_DIR/shell/wt.zsh"

Then reload your shell and run:
  wt setup
EOF
