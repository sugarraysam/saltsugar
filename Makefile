TARGETS := help salt-sandbox salt bootstrap-test bootstrap rsync clean
.PHONY: $(TARGETS)

# Salt/vagrant default env
export ACTION ?= deploy
export STATE ?= highstate

# Packer/bootstrap default env
export BOOTSTRAP_DISK ?= /dev/sda
export BOOTSTRAP_LUKS ?= saltsugar
export BOOTSTRAP_TZ ?= America/Chicago
export BOOTSTRAP_HOSTNAME ?= htp
export BOOTSTRAP_SWAP_SIZE_MB ?= 16384
export BOOOTSTRAP_USER ?= sugar
export BOOOTSTRAP_USER_PASSWD ?= sugar
export BOOOTSTRAP_ROOT_PASSWD ?= root

help:
	@echo "make [ salt-sandbox | salt | bootstrap-test | bootstrap | rsync | clean | help ]"
	@echo "    salt-sandbox:     Create salt sandbox using vagrant."
	@echo "    salt:             Rsync and apply salt state to system. [ STATE=<state> ] make salt"
	@echo "    rsync:            Rsync salt files to /srv/salt and /srv/pillar. Does not apply any state."
	@echo "    bootstrap-test:   Test bootstrap + chroot scripts using packer."
	@echo "    bootstrap:        Bootstrap a new installation from the ArchLinux ISO."
	@echo "    clean:            Destroy VM and build files from packer."
	@echo "    help:             Show this help menu."

salt-sandbox:
	@vagrant validate
	@vagrant up --provision

salt:
	@sudo -E ./scripts/salt.sh

rsync:
	@ACTION=rsync sudo -E ./scripts/salt.sh

bootstrap-test:
	@packer validate packer/
	@packer build -force packer/

bootstrap:
	@./scripts/bootstrap.sh

FILES_TO_REMOVE := $(shell find _build -type f 2>/dev/null)
clean:
	@echo "Removing $(FILES_TO_REMOVE)..."
	@if [ -d "_build" ]; then rm -fr _build; fi
	@vagrant destroy --force
