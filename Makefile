TARGETS := validate up status destroy deploy
.PHONY: $(TARGETS)

export ACTION ?= deploy
export STATE ?= highstate

validate:
	@vagrant validate

up: validate
	@vagrant up --provision

status: validate
	@vagrant status

destroy:
	@vagrant destroy --force

# Copy files to local machine + run highstate
# Can override state to run with:
#	$ STATE=[ highstate | <state> ] make deploy
deploy:
	@sudo -E ./scripts/run.sh

# Simply copy files but don't execute a highstate
rsync:
	@ACTION=rsync sudo -E ./scripts/run.sh
