#!/usr/bin/env bash
# Lager én ZIP per språk i dist/, klare til å legges ved en GitHub Release.
# Builds one zip per language in dist/, ready to attach to a GitHub Release.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist && mkdir -p dist/stage

build() { # <kildemappe> <mappenavn i ZIP> <zip-fil>
  rsync -a --exclude-from=.gitignore --exclude='journal/' --exclude='logg/' "$1/" "dist/stage/$2/"
  (cd dist/stage && zip -rq "../$3" "$2")
}
build english "Weekly notes" weekly-notes-english.zip
build norsk   "Ukenotater"   ukenotater-norsk.zip
rm -rf dist/stage
ls -lh dist
echo
echo "Publiser / publish:"
echo "  gh release create v1.0.0 dist/*.zip --title v1.0.0 --notes 'English + norsk'"
