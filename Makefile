TARGETS := help vagrant packer deploy rsync clean
.PHONY: $(TARGETS)

# Salt/vagrant default env
export ACTION ?= deploy
export STATE ?= highstate

# Packer/bootstrap default env
export BOOTSTRAP_DISK ?= /dev/sda

help:
	@echo "make [ vagrant | packer | deploy | rsync | clean | help ]"
	@echo "    vagrant:     Test & develop salt using archsugar vagrant box and sync directories."
	@echo "    packer:      Test & develop bootstrap + chroot bash scripts using packer and virtualbox."
	@echo "    bootstrap:   TODO - not implemented"
	@echo "    deploy:      Rsync and apply salt state to system. Override state with STATE=<state>."
	@echo "    rsync:       Rsync salt files to /srv/salt and /srv/pillar. Does not apply any state."
	@echo "    clean:       Destroy VM and build files from packer."
	@echo "    help:        Show this help menu."

_validate-vagrant:
	@vagrant validate

vagrant: _validate-vagrant
	@vagrant up --provision

_validate-packer:
	@packer validate packer/

packer: _validate-packer
	@packer build -force packer/

bootstrap:
	@echo "TODO - not implemented"

# Copy files to local machine + run highstate
# Can override state to run with:
#	$ STATE=[ highstate | <state> ] make deploy

deploy:
	@sudo -E ./scripts/run.sh

# Simply copy files but don't execute a highstate
rsync:
	@ACTION=rsync sudo -E ./scripts/run.sh

clean:
	@if [ -d "_build" ]; then rm -fr _build; fi
	@vagrant destroy --force
