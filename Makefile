SHELL = /bin/bash

DOCKER_WC_NAME = web
DOCKER_WCL_NAME = weblegacy

.PHONY: all
all:
	make build

.PHONY: config
config:
	cp docker-compose.yml.EXAMPLE docker-compose.yml

.PHONY: build
build:
	docker-compose up -d --build

.PHONY: run
run:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose down

.PHONY: bash
bash:
	docker-compose exec -w /var/www ${DOCKER_WC_NAME} bash

.PHONY: lebash
lebash:
	docker-compose exec -w /var/www ${DOCKER_WCL_NAME} bash

# $ make enter EC={{containerName}}
.PHONY: enter
enter:
	docker-compose exec ${EC} bash
