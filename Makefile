DOCKER_IMAGE=dockette/letsencrypt
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

.PHONY: test
test:
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} bash -n /generate.sh
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} sh -lc 'test -x /generate.sh && test -d /var/www/acme-certs && test -d /var/www/certs'
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} sh -lc 'sed -i '\''s/$$DOMAINS/example.test/g'\'' /etc/nginx/nginx.conf && nginx -t'

.PHONY: run
run:
	docker run --rm -it --entrypoint /bin/bash ${DOCKER_IMAGE}:${DOCKER_TAG}
