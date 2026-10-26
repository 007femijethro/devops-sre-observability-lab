# Architecture

```mermaid
flowchart LR
  Host[Linux host] --> Node[Node exporter]
  Containers[Docker workloads] --> Cadvisor[cAdvisor]
  Endpoint[Public demo endpoint] --> Blackbox[Blackbox exporter]
  Node --> Prometheus
  Cadvisor --> Prometheus
  Blackbox --> Prometheus
  Prometheus --> Grafana
  Prometheus --> Alertmanager
  Containers --> Alloy[Grafana Alloy]
  Alloy --> Loki
  Loki --> Grafana
```

All published web interfaces bind to localhost. This is a single-host demonstration architecture, not a highly-available production design. Loki has authentication disabled internally and must not be exposed publicly.
