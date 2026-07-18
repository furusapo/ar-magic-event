#!/bin/bash
set -e

PROJECT="$HOME/Projects/02_開発中/ar-magic-event"
mkdir -p "$PROJECT"
cp -R ./* "$PROJECT"/
cd "$PROJECT"

if ! command -v gh >/dev/null 2>&1; then
  echo "❌ GitHub CLI(gh)が必要です"
  exit 1
fi

git init
git add .
git commit -m "魔法石ARイベント初版" || true
git branch -M main

if gh repo view furusapo/ar-magic-event >/dev/null 2>&1; then
  git remote remove origin 2>/dev/null || true
  git remote add origin https://github.com/furusapo/ar-magic-event.git
else
  gh repo create furusapo/ar-magic-event --public --source=. --remote=origin
fi

git push -u origin main --force
gh api -X POST repos/furusapo/ar-magic-event/pages -f source[branch]=main -f source[path]=/ 2>/dev/null || true

echo ""
echo "✅ 公開URL:"
echo "https://furusapo.github.io/ar-magic-event/"
echo ""
echo "🖨 マーカー:"
echo "https://furusapo.github.io/ar-magic-event/marker.html"
open "https://furusapo.github.io/ar-magic-event/"
