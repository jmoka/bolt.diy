#!/bin/bash

ENV_FILE=".env.local"
if [ ! -f "$ENV_FILE" ]; then
  ENV_FILE=".env"
fi

bindings=""

while IFS= read -r line || [ -n "$line" ]; do
  if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
    name=$(echo "$line" | cut -d '=' -f 1)
    value=$(echo "$line" | cut -d '=' -f 2-)
    value=$(echo $value | sed 's/^"\(.*\)"$/\1/')
    bindings+="--binding ${name}=${value} "
  fi
done < "$ENV_FILE"

bindings=$(echo $bindings | sed 's/[[:space:]]*$//')

echo $bindings
