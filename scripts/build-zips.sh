#!/usr/bin/env bash
# Lager én ZIP per språk i dist/ fra det som er committet, klare til en GitHub Release.
# Builds one zip per language in dist/ from what is committed, ready for a GitHub Release.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist && mkdir -p dist/stage

build() { # <kildemappe> <mappenavn i ZIP> <zip-fil>
  mkdir -p "dist/stage/$2"
  git archive HEAD "$1" | tar -x -C "dist/stage/$2" --strip-components=1
  find "dist/stage/$2" -name .gitkeep -delete   # Obsidian trenger mappene, ikke filene
  (cd dist/stage && zip -rq "../$3" "$2")
}
build english "Weekly notes" weekly-notes-english.zip
build norsk   "Ukenotater"   ukenotater-norsk.zip
rm -rf dist/stage
ls -lh dist
echo
echo "Publiser / publish:"
echo "  gh release create v1.0.0 dist/*.zip --title v1.0.0 --notes 'English + norsk'"
