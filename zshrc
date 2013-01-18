if [ -z "${TMUX:+x}" ]; then
	tmux -u2 a || tmux -u2
else
	[ -f /etc/zsh/zprofile ] && . /etc/zsh/zprofile

	zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' completions 1
	zstyle ':completion:*' glob 1
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' max-errors 1
	zstyle ':completion:*' menu select=long
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' substitute 1
	autoload -Uz compinit colors
	compinit
	colors
	HISTFILE=~/.histfile
	HISTSIZE=2048
	SAVEHIST=2048
	setopt appendhistory autocd extendedglob notify nonomatch PROMPT_SUBST
	unsetopt beep
	bindkey -v

	autoload -Uz vcs_info

	zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
	zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
	zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
	zstyle ':vcs_info:*' enable git hg bzr svn

	PROMPT='%M %{${fg[blue]}%}%~ ${vcs_info_msg_0_}%# %{${reset_color}%}'

	if [ "$EUID" = "0" ] || [ "$USER" = "root" ] ; then
		PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${ROOTPATH}"
		PROMPT="%{${fg_bold[red]}%}${PROMPT}"
	else
		PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"
		PROMPT="%{${fg_bold[green]}%}%n@${PROMPT}"
	fi

	local _myhosts
	if [ -d ~/.ssh ]; then
		if [ -f ~/.ssh/known_hosts ];then
			_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
		fi
	fi

	zstyle ':completion:*' hosts $_myhosts
	zstyle ':completion:*:*:(ssh|scp):*:*' hosts $_myhosts

	sudo() {
		su - -c "$@"
	}

	precmd(){
		vcs_info
		[[ $(tty) = /dev/pts/* ]] && print -Pn "\e]0;%n@%M:%~\a"
	}

	bindkey -a 'b' backward-word
	bindkey -a 'é' forward-word
	bindkey '[3~' delete-char
	bindkey '[4~' end-of-line
	bindkey '[1~' beginning-of-line
	# On remappe pour le bépo
	bindkey -a c vi-backward-char
	bindkey -a r vi-forward-char
	bindkey -a t vi-down-line-or-history
	bindkey -a s vi-up-line-or-history
	bindkey -a $ vi-end-of-line
	bindkey -a 0 vi-digit-or-beginning-of-line 
	bindkey -a h vi-change
	bindkey -a H vi-change-eol
	bindkey -a dd vi-change-whole-line
	bindkey -a l vi-replace-chars
	bindkey -a L vi-replace
	bindkey -a k vi-substitute

	# On remet le ^r pour l'historique
	bindkey -M viins '^r' history-incremental-search-backward
	bindkey -M vicmd '' history-incremental-search-backward

	autoload -U zmv

	alias ls='ls --color=auto'
	alias ll='ls -ogh'
	alias ssh='autossh -M 0'
	alias g='git'
	alias mmv='noglob zmv -W'
	#alias tree='tree -uh'
	alias showbig='du -sh * | grep -e "^[0-9,]\+G"'
	alias grep='grep --color=auto'

	c-c () {
		cd ~/projets/clever-cloud/$1
	}

	export AKKA_HOME=/opt/akka-actors-1.1.2
	export PATH=$PATH:~/.local/bin


	shopts=$-
	setopt nullglob
	for sh in /etc/profile.d/*.sh ; do
		[ -r "$sh" ] && . "$sh"
	done
	unsetopt nullglob
	set -$shopts
	unset sh shopts

	RPROMPT="%{${fg[blue]}%}[%{${fg[red]}%}%?%{${fg[blue]}%}][%{${fg[red]}%}%*%{${fg[blue]}%} - %{${fg[red]}%}%D{%d/%m/%Y}%{${fg[blue]}%}]%{${reset_color}%}"

	. /home/judu/.nvm/nvm.sh
	nvm use 0.9
fi
