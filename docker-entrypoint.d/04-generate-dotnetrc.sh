#!/bin/bash
set -e

# allow to set alternative github api url
# for enterprise github installs
GITHUB_HOST="${GITHUB_HOST:-api.github.com}"
GITHUB_URL="${GITHUB_URL:-https://${GITHUB_HOST}}"

# Retrieve GITHUB_USER from GITHUB_TOKEN
GITHUB_USER=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" ${GITHUB_URL}/user | sed -n '/ *"login": "\(.*\)",$/ s//\1/p')

if test -n "${GITHUB_USER}" && test -n "${GITHUB_TOKEN}"; then
  cat << EOF > /root/.netrc
machine github.com
login ${GITHUB_USER}
password ${GITHUB_TOKEN}

machine ${GITHUB_HOST}
login ${GITHUB_USER}
password ${GITHUB_TOKEN}
EOF
fi
