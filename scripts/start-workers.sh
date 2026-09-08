#!/usr/bin/env bash

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RUNTIME="$ROOT/.runtime"
mkdir -p "$RUNTIME"

for name in worker-alpha worker-beta worker-gamma; do
    if [[ -f "$RUNTIME/$name.pid" ]] && kill -0 "$(cat "$RUNTIME/$name.pid")" 2>/dev/null; then
        continue
    fi
    "$ROOT/scripts/worker.sh" "$name" >/dev/null 2>&1 &
    echo $! > "$RUNTIME/$name.pid"
done

echo "Workers started. Try: pgrep -af worker-"
