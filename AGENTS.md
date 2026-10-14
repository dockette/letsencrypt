# AGENTS.md

## Project

Dockette LetsEncrypt builds `dockette/letsencrypt`, a legacy Debian Jessie image that runs nginx and the Let's Encrypt client to create certificates for configured domains.

## Images

- Default image: `dockette/letsencrypt:latest`.
- Build context: repository root `.` with `Dockerfile`, `generate.sh`, and `nginx.conf`.
- Runtime certificate output: `/var/www/certs`.
- ACME challenge webroot: `/var/www/acme-certs` served by nginx on port `80`.
- Exposed ports: `80` and `443`.
- This image is legacy because it depends on Debian Jessie and the historical `letsencrypt-auto` flow. Keep changes conservative unless the base image and client are intentionally modernized.

## Commands

- `make build` builds `${DOCKER_IMAGE}:${DOCKER_TAG}` from `.`.
- `make test` runs shell syntax, filesystem, and nginx configuration smoke checks against the built image.
- `make run` opens an interactive shell in the image so local inspection does not start a real ACME certificate request.

## Testing Notes

- Do not make real ACME or Let's Encrypt calls in tests or CI.
- Prefer `make test` after Dockerfile, `generate.sh`, or `nginx.conf` changes.
- Use `make -n build test run` to dry-run command wiring without requiring Docker.
- The smoke test requires Docker and a previously built `${DOCKER_IMAGE}:${DOCKER_TAG}` image.

## Guidelines

- Keep `Dockerfile`, `Makefile`, README, `generate.sh`, `nginx.conf`, and `.github/workflows/docker.yml` aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Keep README badges and maintenance sections consistent with other Dockette image repos.
- Do not introduce real certificate issuance into automated checks.
- Do not introduce unrelated formatting or structural changes.
