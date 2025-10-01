HOST ?= whoami.local.ollu.test
HTTP_NODEPORT ?= 30080
HTTPS_NODEPORT ?= 30443

.PHONY: check reconcile

check:
	@HOST=$(HOST) HTTP_NODEPORT=$(HTTP_NODEPORT) HTTPS_NODEPORT=$(HTTPS_NODEPORT) \
	/opt/ollu-dev/scripts/golden-check.sh

reconcile:
	@kubectl annotate -n flux-system gitrepository/flux-system reconcile.fluxcd.io/requestedAt=$1759336323 --overwrite
	@kubectl annotate -n flux-system kustomization/flux-system reconcile.fluxcd.io/requestedAt=$1759336323 --overwrite
	@kubectl annotate -n flux-system kustomization/infra-ingress-nginx reconcile.fluxcd.io/requestedAt=$1759336323 --overwrite || true
	@kubectl annotate -n flux-system kustomization/apps              reconcile.fluxcd.io/requestedAt=$1759336323 --overwrite || true
	@echo "→ reconcile solicitado"
