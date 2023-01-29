.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: test
test: ## Run unit-tests
	@cd src && go test

.PHONY: run
run: ## Run code locally
	@go run src/math.go

.PHONY: rund
rund: ## Run code via container
	@docker run aleroxac/fullcycle:desafio-ci

.PHONY: build
build: ## Build container image
	@[ -d .build ] && rm -rf .build || true
	@mkdir .build && cp src/{math.go,go.mod} docker/Dockerfile .build
	@docker build -t aleroxac/fullcycle:desafio-ci .build
	@rm -rf .build

.PHONY: push
push: ## Push container image to dockerhub
	@docker push aleroxac/fullcycle:desafio-ci
