# DevOps / SRE Observability Lab

A reproducible, security-conscious **single-host monitoring and logging portfolio lab** showcasing infrastructure metrics, container telemetry, synthetic HTTP checks, log ingestion, alerts and operational runbooks.

**Stack:** Prometheus · Grafana · Alertmanager · Loki · Grafana Alloy · Blackbox Exporter · Node Exporter · cAdvisor · Docker Compose

> Portfolio demonstration inspired by hands-on observability work. No employer infrastructure, private endpoints, internal screenshots, customer records, credentials or real incident details are included. The repository itself does not claim a production deployment or benchmark results.

## Architecture
See [architecture diagram](docs/architecture.md).

## Quick start
Requires Docker Engine and Docker Compose v2, with sufficient memory and disk space for the complete stack. Use a disposable local or lab host, not the live production VPS.

```bash
cp .env.example .env
# Edit .env and replace the example Grafana password
docker compose config -q
docker compose up -d
docker compose ps
```

Open Grafana at http://localhost:3000 (localhost-only bind), Prometheus at http://localhost:9090, and Alertmanager at http://localhost:9093. Grafana data sources are provisioned automatically. Explore `up`, `probe_success`, `node_cpu_seconds_total` and `container_cpu_usage_seconds_total`, and Docker container logs through Loki. Replace `https://example.com` in `prometheus/prometheus.yml` with a **public endpoint you are authorised to probe**.

## Verify
```bash
./scripts/validate.sh
docker compose logs --tail=100 prometheus grafana loki alloy
curl -fsS http://127.0.0.1:9090/-/ready
curl -fsS http://127.0.0.1:3000/api/health
```

The validation script checks Compose and Prometheus configuration only; it is not a full end-to-end test. Review `docker compose ps` and Prometheus targets after starting.

## Demonstrated SRE practices
- Metrics scraping, infrastructure visibility and service-level synthetic probing
- Alerting rules with `for` delays to reduce transient-noise alerts
- Centralized Docker logs through Alloy and Loki
- IaC-like reproducibility and documented incident response
- Localhost web access rather than internet-exposed admin UIs

## Incident drill
Read the [runbook](docs/incident-runbook.md). In an isolated lab, stop the `blackbox` container and observe `up{job="blackbox_http"}` / failed probe behaviour; restart it using `docker compose up -d blackbox` and record recovery. Avoid impacting unrelated services.

## Limitations and security notes
- This is a **lab**, not HA production, and has no TLS, SSO, backups, retention tuning for real workloads or durable notification integration.
- Alertmanager's placeholder receiver deliberately sends **no external notifications**.
- Access to the Docker socket has security implications; isolate this lab and review collector privileges before using it on a shared host.
- Node exporter and cAdvisor observe the Docker host; do not deploy on an employer system without authorization.
- Never publish Grafana/Loki/Prometheus endpoints or screenshots with private hostnames, target IPs or logs.
- Container images are version-pinned for reproducibility; review security advisories and refresh these versions before production use.

## Portfolio evidence to add after testing
- Sanitized screenshots of Grafana targets, infrastructure metrics, probe success and Loki queries
- A short incident drill timeline showing detection, investigation, recovery and postmortem
- Test output and host prerequisites

## Clean up
```bash
docker compose down
# To delete lab data too, explicitly use: docker compose down -v
```

Maintainer: [Femi-Muyiwa Jethro Olufemi](https://github.com/007femijethro)
