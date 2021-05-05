HY2PY ?= hy2py
PYTHON ?= python
PIP ?= pip

HYSRCS := $(eval HYSRCS := $(shell find hyls -type f -regex ".*\.hy"))$(HYSRCS)
PYSRCS = $(HYSRCS:%.hy=%.py)

.PHONY: clean
clean:
	rm -f $(PYSRCS) dist build
	$(PYTHON) setup.py clean --all

.PHONY: build
build: \
	$(PYSRCS)

.PHONY: dev-install
dev-install: \
	build
	$(PIP) install -e .

$(PYSRCS): $(HYSRCS)
	$(HY2PY) $(patsubst %.py,%.hy,$@) > $@

.PHONY: prepare-dist
prepare-dist: \
	build
	$(PIP) install --upgrade pip setuptools wheel twine
	$(PYTHON) setup.py sdist
	$(PYTHON) setup.py bdist_wheel

.PHONY: publish
publish:
	twine upload --repository pypi dist/*
