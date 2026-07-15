#!/bin/bash

while IFS='=' read -r var value; do
    # Skip blank lines and comments
    [[ -z "$var" || "$var" =~ ^[[:space:]]*# ]] && continue

    dotted=$(echo -n "$value" | sed 's/./&./g;s/\.$//')
    echo "${var}=${dotted}"
done < ./app/.env.local
          

