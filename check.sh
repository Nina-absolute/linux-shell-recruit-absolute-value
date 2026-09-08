#!/usr/bin/env bash

set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

pass() { echo "[PASS] $1"; }
fail() { echo "[FAIL] $1"; return 1; }

check01() {
    [[ -f output/01_project_id.txt ]] || return 1
    [[ "$(tr -d '\r\n' < output/01_project_id.txt)" == "LSR-2026-0831" ]] || return 1
    [[ -f output/01_relative_path.txt ]] || return 1
    [[ "$(tr -d '\r\n' < output/01_relative_path.txt)" == "../../.project/metadata" ]] || return 1
}

check02() {
    [[ -x tools/recruit-info ]] || return 1
    [[ -f answers/02.md ]] || return 1
    ! grep -q '请在这里回答题目中的两个问题' answers/02.md || return 1
    [[ "$(grep -cv '^[[:space:]]*$' answers/02.md)" -ge 3 ]]
}

check03() {
    [[ -f output/03_code_search.txt ]] || return 1
    expected=$'workspace/project/main.py\nworkspace/project/utils/helper.py'
    actual="$(sed '/^[[:space:]]*$/d' output/03_code_search.txt | sort)"
    [[ "$actual" == "$expected" ]]
}

check04() {
    [[ "$(tr -d '[:space:]' < output/04_error_count.txt 2>/dev/null)" == "7" ]] || return 1
    expected_users=$'alice\nbob\ncarol\ndave'
    actual_users="$(sed '/^[[:space:]]*$/d' output/04_error_users.txt 2>/dev/null | sort -u)"
    [[ "$actual_users" == "$expected_users" ]] || return 1
    [[ "$(tr -d '[:space:]' < output/04_top_code.txt 2>/dev/null)" == "500" ]]
}

check05() {
    [[ -f output/05_top_ip.txt ]] || return 1
    [[ "$(tr -d '[:space:]' < output/05_top_ip.txt)" == "192.168.1.2" ]]
}

check06() {
    [[ -f output/06_stdout.txt && -f output/06_stderr.txt && -f output/06_tee.txt ]] || return 1
    expected_out=$'Checking config...\nChecking data...\nChecking scripts...\nDone'
    expected_err=$'ERROR: missing cache file\nERROR: invalid permission'
    [[ "$(cat output/06_stdout.txt)" == "$expected_out" ]] || return 1
    [[ "$(cat output/06_stderr.txt)" == "$expected_err" ]] || return 1
    [[ "$(cat output/06_tee.txt)" == "$expected_out" ]]
}

check07() {
    out="$(bash scripts/analyze.sh logs/server.log 2>/dev/null)" || return 1
    [[ "$out" == $'Total ERROR: 7\nTop Code: 500' ]] || return 1
    bash scripts/analyze.sh >/dev/null 2>&1 && return 1
    bash scripts/analyze.sh not-exist.log >/dev/null 2>&1 && return 1
    return 0
}

check08() {
    tmp="$(mktemp -d)"
    bash scripts/batch-copy.sh "$tmp" "data/files/report.txt" "data/files/My Report.txt" >/dev/null 2>&1 || { rm -rf "$tmp"; return 1; }
    [[ -f "$tmp/report.txt" && -f "$tmp/My Report.txt" ]] || { rm -rf "$tmp"; return 1; }
    rm -rf "$tmp"
    [[ -f answers/08.md ]] || return 1
    ! grep -q '请在这里简短回答' answers/08.md || return 1
    [[ "$(grep -cv '^[[:space:]]*$' answers/08.md)" -ge 2 ]]
}

check09() {
    [[ -f .runtime/worker-alpha.pid && -f .runtime/worker-beta.pid && -f .runtime/worker-gamma.pid ]] || return 1
    alpha="$(cat .runtime/worker-alpha.pid)"
    beta="$(cat .runtime/worker-beta.pid)"
    gamma="$(cat .runtime/worker-gamma.pid)"
    kill -0 "$alpha" 2>/dev/null || return 1
    kill -0 "$gamma" 2>/dev/null || return 1
    if kill -0 "$beta" 2>/dev/null; then
        return 1
    fi
}

run_one() {
    n="$1"
    case "$n" in
        01) check01 && pass "01 Project Hunt" || fail "01 Project Hunt" ;;
        02) check02 && pass "02 Missing Command" || fail "02 Missing Command" ;;
        03) check03 && pass "03 Code Search" || fail "03 Code Search" ;;
        04) check04 && pass "04 Log Statistics" || fail "04 Log Statistics" ;;
        05) check05 && pass "05 Pipeline Challenge" || fail "05 Pipeline Challenge" ;;
        06) check06 && pass "06 Streams & Redirection" || fail "06 Streams & Redirection" ;;
        07) check07 && pass "07 Analyze Script" || fail "07 Analyze Script" ;;
        08) check08 && pass "08 Script Debug" || fail "08 Script Debug" ;;
        09) check09 && pass "09 Process Hunter (Extra)" || fail "09 Process Hunter (Extra)" ;;
        *) echo "Usage: ./check.sh [01-09]"; return 2 ;;
    esac
}

if [[ $# -eq 1 ]]; then
    run_one "$1"
    exit $?
fi

passed=0
for n in 01 02 03 04 05 06 07 08; do
    if run_one "$n"; then
        passed=$((passed + 1))
    fi
done

echo
echo "Main progress: $passed / 8"
echo "Extra task 09 is not included in the main progress."
[[ $passed -eq 8 ]]
