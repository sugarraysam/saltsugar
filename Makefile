TARGETS := validate up status destroy deploy
.PHONY: $(TARGETS)

export TARGET ?= prod
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
#	$ TARGET=[prod|sandbox] STATE=<state> make deploy
deploy:
	@sudo -E ./scripts/run.sh
