# Homelab

My Homelab setup running as a [K3S](https://k3s.io/) cluster.

## Goals

- GitOps: everything should be deployed and reproducible with Flux
- Secrets should be safely stored in the repository
- SSL certificates for all services
- Monitoring stack with Prometheus and Grafana
- GPU pass-through for hardware acceleration
- Expose services to the outside world
- Monitor all deployed applications
- Reliable storage
- Monitoring alerts

## Repository structure

The repository structure follows the Flux recommendations, but I've
also added an extra layer to provide a better separation of concerns.
The idea is to have the following dependency graph

```
              ┌───►Apps
Infrastructure│
              └───►Core Services
```

Infrastructure contains controllers and its configurations that do not
expose any external services. They provide the fundamental resources to
other services such as SSL certificates, secrets management, storage and
so on.

Core services are composed of the administrative services exposed from
the cluster. This includes any administrative dashboards and monitoring
stacks.

Apps are the user-facing services provided by the cluster.

## TODO 

### General infrastructure

#### Flux

- [x] GitOps setup with Flux
- [x] Manifests validation in CI
- [x] Ensure bootstrap order is correct
- [x] Flux UI

#### Secrets

- [x] Secrets management

#### SSL Certificates

- [x] SSL certificates
- [x] Secrets replication for certificates
- [x] SSL certificate prod
- [x] Monitoring stack
- [x] Structure the repository
- [x] Persist Prometheus data

#### Expose cluster

- [X] Research Cloudflare tunnel vs VPN
- [X] Implement solution with Tailscale

#### Storage

- [x] Figure out how to do storage
- [ ] Longhorn basic setup
- [ ] Longhorn UI
- [ ] Multiple disks on longhorn
- [ ] Monitor longhorn with prometheus

[How to migrate data to longhorn volumes](https://github.com/longhorn/longhorn/issues/265)

#### General

- [ ] Use [Recommended labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)

https://www.youtube.com/watch?v=0CV__VnbYCc&t=205s

### Monitoring

- [x] kube-prometheus-stack deploy
- [ ] Alertmanager setup
- [ ] Provision strava datasource
- [ ] Provision strava dashboard
- [ ] Multiple users on strava dashboard
- [ ] Provision custom Kubernetes dashboard
- [X] Loki setup
- [X] Monitor loki and promtail

### Services

#### Jellyfin

- [x] Deploy
- [x] Gpu acceleration
- [x] Media folder on dedicated drive

#### Homepage

- [X] Deploy
- [X] Settings
- [X] Annotations

#### Prowlarr

- [X] Deploy
- [ ] Monitoring

https://github.com/onedr0p/exportarr

#### QbitTorrent

- [X] Deploy
- [ ] Monitoring: https://github.com/esanchezm/prometheus-qbittorrent-exporter

#### Radarr

- [X] Deploy
- [ ] Monitoring

#### Sonarr

- [X] Deploy
- [ ] Monitoring

#### Bazarr

- [X] Deploy
- [ ] Monitoring

#### Readarr

- [X] Deploy
- [ ] Monitoring

#### Mealie

- [X] Deploy
- [ ] Monitoring

#### Authentik

- [ ] Deploy
- [ ] Monitoring

#### NextCloud

- [ ] Deploy
- [ ] Monitoring

#### Immich

- [X] Deploy
- [ ] Monitoring
