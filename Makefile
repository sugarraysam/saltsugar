TARGETS := help vagrant packer deploy rsync clean
.PHONY: $(TARGETS)

# Salt/vagrant default env
export ACTION ?= deploy
export STATE ?= highstate

# Packer/bootstrap default env
export BOOTSTRAP_DISK ?= /dev/sda
export BOOTSTRAP_LUKS ?= saltsugar

help:
	@echo "make [ vagrant | packer | deploy | rsync | clean | help ]"
	@echo "    vagrant:     Test & develop salt using archsugar vagrant box and sync directories."
	@echo "    packer:      Test & develop bootstrap + chroot bash scripts using packer and virtualbox."
	@echo "    bootstrap:   Bootstrap a new installation from the ArchLinux ISO."
	@echo "    deploy:      Rsync and apply salt state to system. Override state with STATE=<state>."
	@echo "    rsync:       Rsync salt files to /srv/salt and /srv/pillar. Does not apply any state."
	@echo "    clean:       Destroy VM and build files from packer."
	@echo "    help:        Show this help menu."

vagrant:
	@vagrant validate
	@vagrant up --provision

packer:
	@packer validate packer/
	@packer build -force packer/

bootstrap:
	@./scripts/bootstrap.sh

# Copy files to local machine + run highstate
# Can override state to run with:
#	$ STATE=[ highstate | <state> ] make deploy
deploy:
	@sudo -E ./scripts/run.sh

# Simply copy files but don't execute a highstate
rsync:
	@ACTION=rsync sudo -E ./scripts/run.sh

FILES_TO_REMOVE := $(shell find _build -type f 2>/dev/null)
clean:
	@echo "Removing $(FILES_TO_REMOVE)..."
	@if [ -d "_build" ]; then rm -fr _build; fi
	@vagrant destroy --force

# TODO - also create from iso, script to download arch.iso (latest) + create vm
# TODO - sharedfolder only works if guest additions are installed
setup_arch_testing_vm:
	@vboxmanage modifyvm $(BOOTSTRAP_DEBUG_VM) --firmware EFI
	#@vboxmanage sharedfolder add $(BOOTSTRAP_DEBUG_VM) --name saltsugar --hostpath $(PWD) --automount --auto-mount-point=/mnt/saltsugar
