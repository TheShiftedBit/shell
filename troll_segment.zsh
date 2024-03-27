function prompt_ssh_identity() {
    if ! [ -z "$SSH_IDENTITY" ] && [[ "$SSH_IDENTITY" != "Ian" ]] && [[ "$SSH_IDENTITY" != "ian.pudney.git@gmail.com" ]]; then
	    p10k segment -b $[RANDOM%256] -f $[RANDOM%256] -t "%BHello $SSH_IDENTITY"
    fi
}

function self-insert() {
  _p9k_precmd
  zle reset-prompt
  zle .self-insert
}

if ! [ -z "$SSH_IDENTITY" ] && [[ "$SSH_IDENTITY" != "Ian" ]]; then
	zle -N self-insert
fi
