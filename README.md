# wt-cli

Small Git worktree helper for T3-style worktrees.

## Install

```zsh
# ~/.zshrc
source "$HOME/Docs/GitHub/trogui/wt-cli/shell/wt.zsh"
```

Then reload your shell:

```zsh
source ~/.zshrc
```

## Usage

```zsh
wt
```

List existing worktrees with `fzf` and `cd` into the selected one.

```zsh
wt feature/my-branch
```

Create or enter the worktree for a branch:

- if the branch already has a worktree, `cd` into it
- if the branch exists locally without a worktree, create one and `cd` into it
- if the branch does not exist, create it from the current `HEAD`, create a worktree, and `cd` into it

New worktrees are created under:

```text
~/.t3/worktrees/<repo>/<branch-with-slashes-replaced>
```

Delete T3 worktrees:

```zsh
wt delete
wt delete --force
```

`wt delete` only lists worktrees inside `~/.t3/worktrees/`, never the main repo in `~/Docs/GitHub/twave/`.

## Requirements

- macOS/Linux shell with `zsh`
- `git`
- `fzf`

```zsh
brew install fzf
```

## Direct CLI

The executable is `bin/wt-cli`. It prints target directories to stdout; the shell wrapper performs `cd` in your current shell.
