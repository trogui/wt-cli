# wt-cli

Small Git worktree helper.

## Install

```zsh
# ~/.zshrc
source "/path/to/wt-cli/shell/wt.zsh"
```

Then reload your shell:

```zsh
source ~/.zshrc
```

Recommended first-run setup:

```zsh
wt setup
```

This stores your personal settings in:

```text
~/.config/wt-cli/config
```

You can inspect them with:

```zsh
wt config show
wt config path
```

During `wt setup` you can use:

- `.` to use the current repo or current folder
- `~` and relative paths; they are expanded and stored as absolute paths
- `:pick` to open a macOS folder picker

## Usage

```zsh
wt
```

List existing worktrees with `fzf` and `cd` into the selected one.

If you run `wt setup`, it can persist:

- a default repo to use when you run `wt` outside a Git repo
- the root folder where worktrees are created and listed

```zsh
wt feature/my-branch
wt --current feature/my-branch
```

Create or enter the worktree for a branch:

- if the branch already has a worktree, `cd` into it
- if the branch exists locally without a worktree, create one and `cd` into it
- if the branch only exists as `origin/<branch>`, create a local tracking branch from it
- if the branch does not exist, fetch `origin/develop` and create it from there

By default, new branches are created from the latest `origin/develop`, not from the branch you are on when you run `wt`. Use `--current` (or `-c`) to create from the current branch instead.

Remote-looking inputs such as `origin/feature/my-branch` and
`remotes/origin/feature/my-branch` are normalized to `feature/my-branch`.
They will fail if the remote-tracking branch does not exist, instead of
creating a local branch named `origin/...`.

New worktrees are created under:

```text
$WT_WORKTREE_ROOT/<repo>/<branch-with-slashes-replaced>
```

Delete worktrees:

```zsh
wt delete
wt delete --force
```

`wt delete` only lists worktrees inside `WT_WORKTREE_ROOT`, never the main repo outside that root.

## Config

The recommended configuration mechanism is the per-user config file created by
`wt setup`. This avoids hardcoded machine-specific paths in the repo and avoids
depending on shell environment variables that may disappear between sessions.

Environment variables are still supported as overrides for advanced use:

```zsh
export WT_DEFAULT_REPO="$HOME/path/to/your/main-repo"
export WT_WORKTREE_ROOT="$HOME/.t3/worktrees"
```

## Requirements

- macOS/Linux shell with `zsh`
- `git`
- `fzf`

```zsh
brew install fzf
```

## Direct CLI

The executable is `bin/wt-cli`. It prints target directories to stdout; the shell wrapper performs `cd` in your current shell.
