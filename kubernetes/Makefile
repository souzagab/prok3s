args = $(filter-out $@, $(MAKECMDGOALS))

list: # List all available targets for this Makefile
	@grep '^[^#[:space:]].*:' Makefile

add-repos: # Add necessary helm repos
	helm repo add traefik https://helm.traefik.io/traefik
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

install-longhorn: # Install Longhorn
	kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/deploy/longhorn.yaml

setup-cmanager: # Setup cert-manager
	kubectl create namespace cert-manager
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.crds.yaml
	helm install cert-manager jetstack/cert-manager \
		--namespace cert-manager \
		--version v1.10.0 \
		--values=./cert-manager/values.yml

check-cmanager: # Check cert-manager pods
	kubectl get pods -n cert-manager -o wide

tls-issuers:
	kubectl apply -f ./cert-manager/secrets \
		-f ./cert-manager/issuers \
		-f ./cert-manager/certificates

tls-reflector: # Clone certificates between namespaces
	kubectl -n kube-system apply -f https://github.com/emberstack/kubernetes-reflector/releases/latest/download/reflector.yaml

setup-traefik: # Setup Traefik
	kubectl create namespace traefik
	helm upgrade --namespace=traefik traefik traefik/traefik --values=./traefik/values.yml
	kubectl apply -f ./traefik/middleware.yml

traefik-middleware: # Traefik default middlewares
	kubectl apply -f ./traefik/middleware.yml

traefik-dashboard: # Traefik dashboard
	kubectl apply -f ./traefik/dashboard/secrets.yml \
		-f ./traefik/dashboard/middleware.yml \
		-f ./traefik/dashboard/ingress.yml

setup-monitoring: # Setup monitoring
	kubectl create namespace monitoring
	kubectl apply -f ./monitoring/secrets.yml
	kubectl apply -f ./monitoring/volume.yml
	helm upgrade -n monitoring prometheus prometheus-community/kube-prometheus-stack -f ./monitoring/values.yml
	kubectl apply -f ./monitoring/ingress.yml

setup-argo:
	kubectl create namespace argocd
	kubectl apply -n argocd \
		-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl patch -n argocd deployment/argocd-server --patch-file ./argo/patch.yml
	kubectl apply -f ./argo/ingress.yml

%:
	@:
