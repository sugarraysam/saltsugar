TARGETS := validate up status destroy deploy
.PHONY: $(TARGETS)

validate:
	@vagrant validate

up: validate
	@vagrant up --provision

status: validate
	@vagrant status

destroy:
	@vagrant destroy --force

# Copy files to current machine + run highstate
deploy:
	@sudo ./scripts/run.sh prod highstate
