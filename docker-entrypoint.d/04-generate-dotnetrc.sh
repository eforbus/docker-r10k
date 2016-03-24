#!/bin/bash
set -e

if test -n "${GITHUB_USER}" && test -n "${GITHUB_TOKEN}"; then
  cat << EOF > /root/.netrc
machine github.com
login ${GITHUB_USER}
password ${GITHUB_TOKEN}

machine api.github.com
login ${GITHUB_USER}
password ${GITHUB_TOKEN}
EOF
fi
