# Versioned PostgreSQL Formulae

This repo combines a few Homebrew formulae of versioned PostgreSQL extensions.

Why? In its current form, [homebrew-core offers different major versions of PostgreSQL](https://github.com/Homebrew/homebrew-core/tree/master/Formula/p) , but all PostgreSQL extensions featured by homebrew-core are built against **exactly only one of those** major versions. In other words: You can't freely chose your version of PostgreSQL anymore as soon as your work requires the use of PostgreSQL extensions. See [this discussion](https://github.com/orgs/Homebrew/discussions/5157) for more.

As a workaround, this repo contains the [tailored `postgresql@15` and `postgresql@16` formulae by @ozeias](https://github.com/ozeias/homebrew-postgresql) as well as the extensions I need for my projects. **The extensions are versioned according to the PostgreSQL they will be used with.**

## Installation

Make sure you have not currently installed PostgreSQL:

```
brew rm postgresql@15
brew rm postgresql@16
```

Now use this tap:

```
brew tap svoop/postgresql

brew install postgresql@15
# or
brew install postgresql@16
```

And once installed, run the server:

```
brew services start svoop/postgresql/postgresql@15
# or
brew services start svoop/postgresql/postgresql@16
```

## PostGIS

[PostGIS](https://postgis.net) is the de-facto standard for GIS on PostgreSQL:

```
brew install postgis@15
# or
brew install postgis@16
```

And then install the extension:

```
CREATE EXTENSION IF NOT EXISTS postgis;
```

## UUIDv7

The [`pg_uuidv7` extension by @fboulnois](https://github.com/fboulnois/pg_uuidv7) adds support for UUIDv7 which are `INDEX`-friendly and therefore can be used as primary key. See [my short article](https://dev.to/svoop/shrink-uuids-with-postgresql-or-ruby-4i0m) for some background and how to shrink the UUID to only 22 characters e.g. for use in URLs.

```
brew install pg_uuidv7@15
# or
brew install pg_uuidv7@16
```

And then install the extension:

```
CREATE EXTENSION IF NOT EXISTS pg_uuidv7;
```

You can now generate UUIDv7:

```
SELECT uuid_generate_v7();
```

