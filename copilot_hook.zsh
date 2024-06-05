# Do copilot lookup
copilot_lookup() {
    # Create a "thread"
    thread_id="$(curl --http1.1 --no-alpn --fail --silent --show-error --data '{}' -X POST \
        -H "Accept: application/vnd.github.merge-info-preview+json, application/vnd.github.nebula-preview" \
        -H "Authorization: Bearer $(gh auth token)" \
        -H "Content-type: application/json" \
        -H "User-Agent: go-gh"\
        -H "X-Github-Api-Version: 2023-07-07" \
        -H "Time-Zone: America/Detroit" \
        https://api.githubcopilot.com/github/chat/threads | jq -r '.thread_id')"

    # Make the request
    data='{
            "content": '"$(printf "%s" "$1" | jq -R -s '.')"',
            "intent": "cli-suggest",
            "references": [
                {
                "type": "cli-command",
                "program": "shell"
                }
            ]
        }'
    curl --http1.1 --no-alpn --fail --silent --show-error --data "$data" -X POST \
        -H "Accept: application/vnd.github.merge-info-preview+json, application/vnd.github.nebula-preview" \
        -H "Authorization: Bearer $(gh auth token)" \
        -H "Content-type: application/json" \
        -H "User-Agent: go-gh"\
        -H "X-Github-Api-Version: 2023-07-07" \
        -H "Time-Zone: America/Detroit" \
        https://api.githubcopilot.com/github/chat/threads/$thread_id/messages | jq -r '.message.content'
}

# Define a function to run before each command
copilot-accept-line() {
    if [[ "$BUFFER" == '?:'* ]]; then
        BUFFER="${BUFFER##?: }"
	BUFFER="${BUFFER##?:}"
    question="$BUFFER"
	answer="$(copilot_lookup "$BUFFER")"
    BUFFER="$answer"
    zle end-of-line
    BUFFER="$BUFFER
#${question//$'\n'/#\n}"
    else
    	zle .accept-line
    fi
}

zle -N accept-line copilot-accept-line
