# Incident Runbook: ExporterDown / SyntheticProbeFailed

## Detect
- Identify alert labels, failing job and last successful scrape.
- Verify `up` and `probe_success` in Prometheus.

## Triage
- `docker compose ps`
- `docker compose logs --tail=100 prometheus blackbox node-exporter cadvisor`
- For synthetic failure, check DNS, TLS, routing, target maintenance and upstream health.
- Distinguish exporter outage from actual host/application outage.

## Recover
- Follow the documented safe rollback or service-restart process after identifying cause.
- Do not restart unrelated production workloads.
- Check alert returns to OK and target metrics recover.

## Follow-up
- Record detection time, impact, timeline, root cause, recovery and prevention action.
- Record MTTD/MTTR only when measured, not estimated.
