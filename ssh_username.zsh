if ! [ -z "$SSH_USER_AUTH" ]; then
	key="$(cat "$SSH_USER_AUTH" | awk '{print $3}')"
	export SSH_IDENTITY="$(cat "$HOME/.ssh/authorized_keys" | grep "$key" | awk '{print $3}')"
fi
