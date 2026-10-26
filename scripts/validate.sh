#!/usr/bin/env bash
set -euo pipefail
command -v docker >/dev/null || { echo 'Docker not installed'; exit 1; }
docker compose config -q
printf 'Compose configuration valid.\n'
docker run --rm --entrypoint /bin/promtool -v "$PWD/prometheus:/etc/prometheus:ro" prom/prometheus:v3.3.1 check config /etc/prometheus/prometheus.yml
printf 'Prometheus configuration valid.\n'
