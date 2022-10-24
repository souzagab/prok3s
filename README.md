# prok3s
My kubernetes configuration for my homelab on proxmox

https://github.com/BaldFabi/proxmox-terraform-k3s-ansible-cluster
https://austinsnerdythings.com/2021/09/23/deploying-kubernetes-vms-in-proxmox-with-terraform/

https://pawa.lt/posts/2019/07/automating-k3s-deployment-on-proxmox/
https://greg.jeanmart.me/2020/04/13/install-and-configure-a-kubernetes-cluster-w/


export PM_USER="terraform-prov@pve"
export PM_PASS="Script00"


SERVER=10.0.0.51
USER=gab
SSH=$HOME/.ssh/id_ed25519.pub

k3sup install --ip $SERVER --user $USER --ssh-key $SSH

k3sup join --ip 10.0.0.61 --server-ip $SERVER --user $USER --ssh-key $SSH
k3sup join --ip 10.0.0.62 --server-ip $SERVER --user $USER --ssh-key $SSH
k3sup join --ip 10.0.0.71 --server-ip $SERVER --user $USER --ssh-key $SSH



## Disable K3S LB (klipper) and Traefik

curl -sfL https://get.k3s.io | sh -s - server --node-taint CriticalAddonsOnly=true:NoExecute --tls-san $SERVER --write-kubeconfig-mode 644 --disable traefik --disable servicelb

## Install MetalLB


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

kubectl apply -f ./metallb/config.yml


## Ingress-nginx

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/baremetal/deploy.yaml


## Cert-manager

### With helmm

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.10.0 \
  --set installCRDs=true


### Deploy cluster issuers

kubectl apply -f ./cert-manager/


## Rancher

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.kenobi \
  --set replicas=3