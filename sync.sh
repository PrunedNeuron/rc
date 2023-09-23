#!/usr/bin/env sh

BASEDIR="$(dirname $(realpath "$0"))"

synchronize() {
	cd "${BASEDIR}" || exit

	git add "$(git rev-parse --show-toplevel)"
	git commit -am "$(date +%F_%T)"
	git pull --rebase -q origin "$(git rev-parse --abbrev-ref HEAD)"
	git push -q origin "$(git rev-parse --abbrev-ref HEAD)"
}

synchronize
