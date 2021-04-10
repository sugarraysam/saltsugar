TARGETS := validate up clean
.PHONY: $(TARGETS)

validate:
	@vagrant validate

up: validate
	@vagrant up --provision

clean:
	@vagrant destroy --force
