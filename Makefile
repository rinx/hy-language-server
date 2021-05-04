PIP ?= pip
PYTHON ?= python

.PHONY: clean
clean:
	$(PYTHON) setup.py clean --all

.PHONY: dev-install
dev-install:
	$(PIP) install -e .

.PHONY: prepare-dist
prepare-dist:
	$(PIP) install --upgrade pip setuptools wheel twine
	$(PYTHON) setup.py sdist
	$(PYTHON) setup.py bdist_wheel
