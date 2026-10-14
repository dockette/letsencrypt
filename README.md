<h1 align=center>Dockette / LetsEncrypt</h1>

<p align=center>
   <a href="https://github.com/dockette/letsencrypt/actions"><img src="https://github.com/dockette/letsencrypt/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/letsencrypt"><img src="https://img.shields.io/docker/pulls/dockette/letsencrypt.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

Create 90 days SSL certificates for given domains.

## How it works

Container creates simple Nginx server listening on port 80 and waiting for letsencrypt validation.

It handles only requests to `mydomain.com/.well-known`, all other requests are forbidden. 

```
server {
    listen 80;
    server_name $DOMAINS;

    location ^~ /.well-known/ {
        root /var/www/acme-certs;
    }

    location / {
        return 403;
    }
}
```

## Usage

```sh
docker run \
    -p 80:80 \
    -v /srv/certs/mydomain.com:/var/www/certs \
    --name le \
    -e DOMAINS='mydomain.com www.mydomain.com' \
    -e EMAIL='my@email.tld' \
    dockette/letsencrypt:latest
```

For local inspection, use `make run` or override the entrypoint with `--entrypoint /bin/bash` so the container opens a shell instead of running `generate.sh` and requesting a real certificate.

After that you will have copies of certificates in your `/srv/certs/mydomain.com/` folder.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
