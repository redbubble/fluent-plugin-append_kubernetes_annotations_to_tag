.PHONY: all help trigger-deploy clean publish

export VERSION = 0.3.0

help:
	@printf "\n\033[32mEnvironment Variables\033[0m\n"
	@cat $(MAKEFILE_LIST) | egrep -o "\\$$\{[a-zA-Z0-9_]*\}" | sort | uniq | \
		sed -E 's/^[\$$\{]*|\}$$//g' | xargs -I % echo % % | \
		xargs printf "echo \"\033[93m%-30s\033[0m \$$(printenv %s)\n\"" | bash | sed "s/echo //"
	@printf "\n\033[32mMake Targets\033[0m\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""

build: ## Create the docker image.
	@echo "--- :wind_chime: Building :wind_chime:"
	docker run --rm --workdir=/app -v `pwd`:/app -e VERSION ruby:2.5 gem build fluent-plugin-append-kubernetes-annotations-to-tag.gemspec

test: ## Run the app tests.
	@echo "--- :fire: Testing :fire:"
	docker run --rm --workdir=/app -v `pwd`:/app -e VERSION -e BUNDLE_PATH=/app/gems ruby:2.5 script/docker-rspec.sh

push: ## Publish the gem
	@echo "--- :fire: Pushing! :fire:"
	docker run --rm --workdir=/app -v `pwd`:/app -e VERSION -e BUNDLE_PATH=/app/gems -it ruby:2.5 gem push fluent-plugin-append-kubernetes-annotations-to-tag-${VERSION}.gem

clean: ## Cleanup artifacts generated by build.
	@echo "--- :shower: Cleaning up :shower:"
	-rm *.gem

all: build test push
