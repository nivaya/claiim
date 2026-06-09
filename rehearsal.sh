#!/usr/bin/env bash
# rehearsal.sh -- smoke-test a running CLAIIM Evaluation Preview install.
# Run after "docker compose up -d" to verify the stack is healthy.
set -euo pipefail

API_BASE="${CLAIIM_API_BASE:-http://localhost:8181}"
UI_BASE="${CLAIIM_UI_BASE:-http://localhost:3001}"

pass() { echo "  PASS  $*"; }
fail() { echo "  FAIL  $*"; exit 1; }

echo ""
echo "CLAIIM rehearsal -- $(date)"
echo "API: $API_BASE"
echo "UI:  $UI_BASE"
echo ""

# 1. API health
status=$(curl -sf -o /dev/null -w "%{http_code}" "$API_BASE/health" || echo "000")
[[ "$status" == "200" ]] && pass "API /health" || fail "API /health returned $status"

# 2. UI reachable
status=$(curl -sf -o /dev/null -w "%{http_code}" "$UI_BASE/" || echo "000")
[[ "$status" == "200" ]] && pass "UI /" || fail "UI / returned $status"

# 3. Gate endpoint present (expects 401 without token, not 404)
status=$(curl -sf -o /dev/null -w "%{http_code}" "$API_BASE/v" || echo "000")
[[ "$status" == "401" || "$status" == "400" ]] && pass "Gate /v (unauthenticated 40x)" || fail "Gate /v returned $status (expected 401/400)"

echo ""
echo "Rehearsal passed. CLAIIM is running."
echo "Open $UI_BASE to access the admin UI."
echo ""
