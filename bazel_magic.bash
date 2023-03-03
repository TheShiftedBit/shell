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

export PROMPT_COMMAND="update_vars; $PROMPT_COMMAND"