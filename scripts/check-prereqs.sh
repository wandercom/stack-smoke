#!/usr/bin/env bash
set -euo pipefail

root="${STACK_ROOT:-${HOME}/WanderRepos/repos}"
personal_root="${STACK_PERSONAL_ROOT:-${HOME}/Code}"
missing=0

require_path() {
  local relative="$1"
  local path="$root/$relative"
  # An explicit STACK_ROOT remains strict. The default layout supports tools
  # retained personally alongside the repositories migrated to Wander.
  if [[ -z "${STACK_ROOT:-}" && ! -e "$path" && -e "$personal_root/$relative" ]]; then
    path="$personal_root/$relative"
  fi
  if [[ ! -e "$path" ]]; then
    echo "missing: $path" >&2
    missing=1
  else
    echo "ok: $path"
  fi
}

require_path "reeve"
require_path "aegis"
require_path "covenant"
require_path "vigil"
require_path "scram"
require_path "witness"
require_path "baton"
require_path "sentinel"
require_path "tessera"
require_path "ledger"
require_path "arbiter"
require_path "chronicler"
require_path "stigmergy"
require_path "apprentice"
require_path "signet"
require_path "cartographer"
require_path "constrain"
require_path "pact"
require_path "reeve/ledger-schemas/reeve.yaml"
require_path "ledger/.ledger/registry/reeve_main.yaml"
require_path "baton/baton.yaml"
require_path "baton/configs/reeve-egress.yaml"
require_path "exemplar-stack/docs/code-inventory.md"
require_path "exemplar-stack/docs/infrastructure-handoff.md"

# Cartographer should have at least attempted to make Reeve legible to
# the broader stack. These drafts are inputs to declarative closeout, not
# proof that runtime enforcement is finished.
require_path "reeve/.cartographer/drafts/baton/baton_draft.yaml"
require_path "reeve/.cartographer/drafts/sentinel/manifest_draft.json"
require_path "reeve/.cartographer/drafts/constrain/component_map_draft.yaml"

if [[ "$missing" != "0" ]]; then
  echo "stack-smoke prerequisites are incomplete" >&2
  exit 1
fi

echo "stack-smoke prerequisites are present"
