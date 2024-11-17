# Versioned PostgreSQL Formulae

This repo combines a few Homebrew formulae of versioned PostgreSQL extensions.

## PostGIS

The official PostGIS formula supports PostgreSQL 14 and 17. Here's  how to install this combo for one of the versions in between using the formulae by [@ozeias](https://github.com/ozeias/homebrew-postgresql).

Make sure you have not currently installed PostgreSQL:

```
brew rm postgresql
brew rm postgresql@15
brew rm postgresql@16
```

Select the PostgreSQL version, either 15 or 16:

```
pgversion=16
```

Now use this tap to install PostgreSQL and PostGIS:

```
brew tap svoop/postgresql
brew install postgresql@${pgversion}
brew install postgis@${pgversion}
```

And once installed, run the server:

```
brew services start svoop/postgresql/postgresql@${pgversion}
```

And then install the extension:

```
CREATE EXTENSION IF NOT EXISTS postgis;
```

## UUIDv7

UUIDv7 is a recent `INDEX`-friendly UUID standard and can therefore be used as primary key. See [my short article](https://dev.to/svoop/shrink-uuids-with-postgresql-or-ruby-4i0m) for some background and how to shrink the UUID to only 22 characters e.g. for use in URLs.

There is a [patch in the works](https://www.postgresql.org/message-id/flat/CAAhFRxitJv=yoGnXUgeLB_O+M7J2BJAmb5jqAT9gZ3bij3uLDA@mail.gmail.com) to add support to PostgreSQL, however, it won't be ready before PostgreSQL 18 at the earliest.

Meanwhile, the [pg_uuidv7 extension by @fboulnois](https://github.com/fboulnois/pg_uuidv7) implements support for UUIDv7.

Select the installed PostgreSQL version, either 15, 16 or 17:

```
psql --version
pgversion=17
```

Now use this tap to install pg_uuidv7:

```
brew tap svoop/postgresql
brew install pg_uuidv7@${pgversion}
```

And then install the extension:

```
CREATE EXTENSION IF NOT EXISTS pg_uuidv7;
```

You can now generate UUIDv7:

```
SELECT uuid_generate_v7();
```
