#!/usr/bin/env sh
set -eu

PLUGIN_NAME="codex-onboarding-skill"
MARKETPLACE_NAME="codex-onboarding"
DEFAULT_SOURCE="ivorywanj/codex-onboarding-skill"
DEFAULT_REF="main"
CODEX_BIN="${CODEX_BIN:-codex}"

SOURCE="$DEFAULT_SOURCE"
REF="$DEFAULT_REF"

usage() {
  cat <<'USAGE'
Usage:
  sh scripts/install-codex-onboarding.sh [SOURCE] [--ref REF]

SOURCE may be:
  - omitted, to install ivorywanj/codex-onboarding-skill
  - owner/repo
  - https://github.com/owner/repo
  - a local extracted plugin repository folder
  - a .zip file path

After installation, the script prints the exact next step for Codex to initialize
the current or selected project. It does not copy plugin files into your project.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --ref)
      if [ "$#" -lt 2 ]; then
        echo "Missing value after --ref" >&2
        exit 2
      fi
      REF="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      SOURCE="$1"
      shift
      ;;
  esac
done

find_marketplace_root() {
  search_root="$1"

  if [ -f "$search_root/.agents/plugins/marketplace.json" ] || [ -f "$search_root/.codex-plugin/marketplace.json" ]; then
    printf '%s\n' "$search_root"
    return 0
  fi

  found_agents="$(find "$search_root" -path '*/.agents/plugins/marketplace.json' -type f -print | head -n 1 || true)"
  if [ -n "$found_agents" ]; then
    dirname "$(dirname "$(dirname "$found_agents")")"
    return 0
  fi

  found_codex="$(find "$search_root" -path '*/.codex-plugin/marketplace.json' -type f -print | head -n 1 || true)"
  if [ -n "$found_codex" ]; then
    dirname "$(dirname "$found_codex")"
    return 0
  fi

  return 1
}

install_source="$SOURCE"
cleanup_note=""

case "$SOURCE" in
  *.zip)
    if [ ! -f "$SOURCE" ]; then
      echo "Zip file not found: $SOURCE" >&2
      exit 1
    fi
    tmp_dir="$(mktemp -d /tmp/codex-onboarding-install-XXXXXX)"
    unzip -q "$SOURCE" -d "$tmp_dir"
    install_source="$(find_marketplace_root "$tmp_dir")"
    cleanup_note="Temporary unzip folder: $tmp_dir"
    ;;
  *)
    if [ -d "$SOURCE" ]; then
      install_source="$(find_marketplace_root "$SOURCE")"
    fi
    ;;
esac

if [ -z "$install_source" ]; then
  echo "Could not find a Codex marketplace manifest in: $SOURCE" >&2
  exit 1
fi

if [ -d "$install_source" ]; then
  "$CODEX_BIN" plugin marketplace add "$install_source"
else
  "$CODEX_BIN" plugin marketplace add "$install_source" --ref "$REF"
fi

"$CODEX_BIN" plugin add "$PLUGIN_NAME@$MARKETPLACE_NAME"

if ! "$CODEX_BIN" plugin list | grep -q "$PLUGIN_NAME@$MARKETPLACE_NAME"; then
  echo "Install verification failed: plugin is not listed as installed." >&2
  exit 1
fi

cat <<'NEXT'

Codex Onboarding is installed.

要现在帮你把这个项目初始化成 Codex Starter Pack 吗？
默认我会初始化当前项目；也可以告诉我另一个项目路径，或者说“先不初始化”。
NEXT

if [ -n "$cleanup_note" ]; then
  printf '%s\n' "$cleanup_note"
fi
