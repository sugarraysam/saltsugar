TARGETS := help salt-sandbox salt bootstrap-test bootstrap rsync clean
.PHONY: $(TARGETS)

# Salt/vagrant default env
export ACTION ?= deploy
export STATE ?= highstate

###
### Bootstrap/Packer default env
###
# Vbox VM name
export BOOTSTRAP_VM_NAME ?= archsugar_$(shell date +%Y.%m.%d)
# Disk to be partitioned
export BOOTSTRAP_DISK ?= /dev/sda
# Encrypted root partition password
export BOOTSTRAP_LUKS ?= saltsugar
# Device mapper name for root partition /dev/mapper/<dmname>
export BOOTSTRAP_DMNAME ?= sugarcrypt
# Timezone of system
export BOOTSTRAP_TZ ?= America/Chicago
# Hostname of system
export BOOTSTRAP_HOSTNAME ?= htp
# Size of /swapfile in MB
export BOOTSTRAP_SWAP_SIZE_MB ?= 16384
# Username for unprivileged user
export BOOTSTRAP_USER ?= sugar
# Password for unprivileged user
export BOOTSTRAP_USER_PASSWD ?= sugar
# Password for root
export BOOTSTRAP_ROOT_PASSWD ?= root

##@ General

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development

init: ## Create venv /w pipenv
	@pip install --upgrade pip
	@pip install --user --upgrade pipenv
	@pipenv install --dev

salt-sandbox: ## Create salt sandbox using vagrant
	@vagrant validate
	@vagrant up --provision

test: init ## Test saltsugar helper python package
	@pipenv run pytest -v tests/

clean: ## Destroy VM and build files from packer.
	-@sudo rm -fr _build build .venv *.egg-info
	-@vagrant destroy --force > /dev/null 2>&1
	-@vboxmanage unregistervm $(BOOTSTRAP_VM_NAME) --delete > /dev/null 2>&1 || true

##@ Deploy

ls-states: ## List all available salt states.
	@ls $(PWD)/salt/roots | grep -E -v '^_.*|top.sls' | sort

salt: ## Rsync and apply salt state to system. [ STATE=<state> ] make salt
	@sudo -E ./scripts/salt.sh

rsync: ## Rsync salt files to /srv/salt and /srv/pillar. Does not apply any state.
	@ACTION=rsync sudo -E ./scripts/salt.sh

##@ New Arch installation

bootstrap-test: ## Test bootstrap + chroot scripts using packer.
	@packer validate packer/
	@packer build -force packer/

bootstrap: ## Bootstrap a new installation from the ArchLinux ISO.
	@./scripts/bootstrap.sh
