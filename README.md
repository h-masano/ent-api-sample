# ent-api-sample

This is a sample project of gin API Server with ent DB migrations on Docker container.
The migrations based on golang-migrate/migrate (the old migrate engine for atlas).

## How to run

``` sh
docker-compose build
docker-compose up -d
```

## How to create new migration

1. fix or add schema in `database/ent/schema` directory

1. generate ent files

    ``` sh
    make generate
    ```

1. go into the container

    ``` sh
    docker exec -it ent-api-sample-api-1 sh
    ```

1. create migration file

    ``` sh
    make migrate-create <migration name e.g. create_users>
    ```

1. apply migration

    ``` sh
    make migrate-up
    ```

## references

- <https://entgo.io/ja/docs/getting-started>
- <https://entgo.io/ja/docs/data-migrations/>
- <https://entgo.io/ja/docs/versioned-migrations/>
- <https://zenn.dev/dmorita00/scraps/9d7ecf8925064e>
