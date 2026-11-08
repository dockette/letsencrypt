<h1 align=center>Dockette / LetsEncrypt</h1>

<p align=center>
   <a href="https://hub.docker.com/r/dockette/letsencrypt"><img src="https://img.shields.io/docker/pulls/dockette/letsencrypt.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   🎁 Let's Encrypt certificates via a temporary Nginx in Docker
</p>

-----

> [!WARNING]
> **Deprecated.** This image is no longer maintained or rebuilt, and the repository is archived. The last image on
> Docker Hub was built in 2020 on Debian `jessie`, which is end-of-life. Use [`certbot/certbot`](https://hub.docker.com/r/certbot/certbot) instead.

Issues 90-day SSL certificates for the given domains, on Debian `jessie`.

## How it works

The container starts a simple Nginx server on port 80 and waits for Let's Encrypt validation. It serves only
requests to `mydomain.com/.well-known`, all other requests are forbidden.

```nginx
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

Add `-it` for an interactive shell. Copies of the certificates end up in `/srv/certs/mydomain.com/`.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
