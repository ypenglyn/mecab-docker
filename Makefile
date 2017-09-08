.PHONY:
	help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## build docker image
	@docker build -t test/mecab:20170908 .

push:   ## push docker image
	@echo push

clean:  ## clean package binary and remove old images
	@docker rm -f mecab-test
	@docker rmi -f test/mecab:20170908

run:   ## test docker image
	@docker run -itd --rm -p 80:80 --name mecab-test test/mecab:20170908

login: ## attach in docker
	@docker exec -it mecab-test bash
