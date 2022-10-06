autoload -Uz add-zsh-hook

function update_vars() {
    vars="$(~/bazel_fast_metadata)"
    if [ -n "$vars" ]; then
      export BAZEL_IN_REPO=0
      while IFS= read -r line ; do 
        eval "export $line"
      done <<< "$vars"

    else
      export BAZEL_IN_REPO=1
    fi
}

add-zsh-hook precmd update_vars

if ! typeset -f prompt_dir_backup >/dev/null; then
    if typeset -f prompt_dir > /dev/null; then
        functions[prompt_dir_backup]=$functions[prompt_dir]
        function prompt_dir() {
            if [ "$BAZEL_IN_REPO" = "0" ]; then
                return 0
            fi
            prompt_dir_backup
        }
    fi
fi


function prompt_bazel_name() {
    if [ "$BAZEL_IN_REPO" = "0" ]; then
        p10k segment -b 022 -f 015 -t "%B$BAZEL_REPO_DIR"
    fi    
}

function prompt_bazel_dir() {
    if [ "$BAZEL_IN_REPO" = "0" ]; then
        p10k segment -b 237 -f 015 -t "${BAZEL_SUBDIR%/}"
    fi    
}

