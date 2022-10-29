
list: # List all available targets for this Makefile
	@grep '^[^#[:space:]].*:' Makefile

install-deps: # Install dependencies
	ansible-galaxy install -r ./collections/requirements.yml

install: # Install
	ansible-playbook ./site.yml -i ./inventory/cluster/hosts.ini

reset: # Reset
	ansible-playbook ./reset.yml -i ./inventory/cluster/hosts.ini
