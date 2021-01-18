.PHONY: default
default: | help

.PHONY: install
install: ## Install local required utils
	npm install

.PHONY: serve-dev
serve-dev: ## Serve the site locally, redering drafts and trigger re-render (dev mode)
	hugo serve --verbose --buildDrafts --disableFastRender serve --destination public

.PHONY: serve
serve: ## Serve the site locally
	hugo serve --destination public

.PHONY: open-local
open-local: ## Open locally served site in your browser
	open http://localhost:1313/dapla-docs

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
