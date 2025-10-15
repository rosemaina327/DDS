
REQUIREMENTS=$(DOCSV1_HOME)/mkdocs/requirements.txt $(wildcard requirements.txt)
PYTHON ?= /usr/bin/python3


serve: setup
	@.venv/bin/python3 -m mkdocs serve

generate: setup
	@echo "Generate"
	@.venv/bin/python3 -m mkdocs build

setup: .venv/bin/mkdocs .venv/bin/icf_updated

.venv/bin/mkdocs:
	@echo "Creating venv with python: $(shell $(PYTHON) --version)"
	@$(PYTHON)  -m venv .venv

.venv/bin/icf_updated: $(REQUIREMENTS)
	@echo "Installing requirements"
	@.venv/bin/python3 -m pip install --upgrade pip
	@for f in $(REQUIREMENTS); do .venv/bin/pip3 install --upgrade -r $$f; done
	@touch .venv/bin/icf_updated