# Modern Unix commands
##### From gh:Jackson-soft/dotfiles/zsh/zshrc.zsh
##### See gh:ibraheemdev/modern-unix
```sh
	zinit wait lucid as"null" from"gh-r" for \
		sbin"zoxide" atclone"zoxide init zsh > z.zsh" atpull"%atclone" src"z.zsh" ajeetdsouza/zoxide \
		sbin'**/delta' atload"alias diff='delta -ns'" dandavison/delta \
		sbin'**/rg' mv"**/complete/_rg -> $ZINIT[COMPLETIONS_DIR]" BurntSushi/ripgrep \
		sbin'**/fd' mv"**/autocomplete/_fd -> $ZINIT[COMPLETIONS_DIR]" @sharkdp/fd \
		sbin'**/bat' atload"alias cat='bat'" mv"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" @sharkdp/bat \
		sbin"**/vivid" atload'export LS_COLORS="$(vivid generate one-dark)"' @sharkdp/vivid \
		sbin'**/exa' atload"alias ls='exa --color=auto --group-directories-first --time-style=long-iso';alias ll='ls -lh';alias la='ls -abghHliS';alias tree='ls -T'" \
		mv"**/exa.zsh -> $ZINIT[COMPLETIONS_DIR]/_exa" sbin"**/exa" ogham/exa \
		sbin'cheat* -> cheat' cheat/cheat \
		sbin'jq* -> jq' stedolan/jq \
		sbin'buf* -> buf' bufbuild/buf \
		sbin'**/golangci-lint' golangci/golangci-lint \
		sbin'bin/lua-language-server' sumneko/lua-language-server \
		sbin'hadolint* -> hadolint' hadolint/hadolint \
		sbin"**/shellcheck" koalaman/shellcheck \
		sbin'**/shfmt* -> shfmt' @mvdan/sh
```
