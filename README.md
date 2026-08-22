<div style="text-align: center;">
  <img style="width: 128px;" src="assets/img/omdb-512x512.png" alt="OMDB logo">
</div>

# OMDB

- PHP version: 8.1
- [Docker](https://docs.docker.com/get-docker/) with Docker Compose is the recommended local runtime
- [Composer](https://getcomposer.org/) is required for linting
- Recommended to join the [Discord](https://discord.gg/PWVGrQRq2w) if you're contributing

## Local Development

Create the local environment file and start the application:

```shell
cp .env.sample .env
docker compose up --build
```

Open [http://localhost:8400](http://localhost:8400). MySQL is available to host tools at `127.0.0.1:3306` with database `omdb` and local-only credentials `root` / `root`.

Set different host ports if `8400` or `3306` are already in use:

```shell
APP_PORT=8401 MYSQL_PORT=3307 docker compose up --build
```

Compose creates the schema from `init.sql`, then waits for the development fixtures to be available before starting the website. The fixture includes users, mapsets, ratings, descriptors, comments, reviews, lists, news, forums, tournaments, and homepage caches. Existing fixture data is detected with a version marker, so normal restarts do not reinsert it.

### Resetting The Database

To discard all local database contents and initialize a fresh schema and fixtures:

```shell
docker compose down -v
docker compose up --build
```

`docker compose down -v` permanently deletes this Compose project's database volume. Do not use it if the volume contains work you need to keep.

### Local Authentication

The fixture contains a development session for the local moderator user `moonpoint`. Click **log in** in the navigation bar to use it without configuring osu! OAuth. This shortcut is enabled only by the local Compose environment and refuses non-local URLs or databases.

To test the real login flow instead, create an osu! OAuth application with the callback URL `http://localhost:8400/callback.php`, then set `OSU_CLIENT_ID`, `OSU_CLIENT_SECRET`, and `OSU_API_V1_KEY` in `.env`.

## Format/Linting

`.editorconfig` for any editor with [EditorConfig](https://editorconfig.org/) support

**VS Code users:** `.vscode/extensions.json` and `.vscode/settings.json` are available

Setup once after cloning:
```shell
composer install
```

- `composer lint` for linting
- `composer fix-changed` to format the files your branch changed
