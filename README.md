# prok3s
My kubernetes configuration for my homelab on proxmox






## Steps

### Provision machines
```bash
  export PM_USER="terraform-prov@pve"
  export PM_PASS="password"
```
### Populate hosts.ini with machine ips
###  Run ansible

### Install Longhorn
### Install Traefik
### Install Traefik dashboard
### Install cert-manager
### Install Kubernetes reflector

### Install monitoring
### Install ArgoCD




Specs:

https://github.com/BaldFabi/proxmox-terraform-k3s-ansible-cluster
https://austinsnerdythings.com/2021/09/23/deploying-kubernetes-vms-in-proxmox-with-terraform/

https://pawa.lt/posts/2019/07/automating-k3s-deployment-on-proxmox/
https://greg.jeanmart.me/2020/04/13/install-and-configure-a-kubernetes-cluster-w/
https://docs.technotim.live/posts/k3s-traefik-rancher/
https://docs.technotim.live/posts/traefik-portainer-ssl/