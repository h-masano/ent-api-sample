.PHONY: tidy
tidy:
	go mod tidy

.PHONY: generate
generate:
	go generate ./database/ent
	go generate ./database/ent/schema

.PHONY: migrate-create
migrate-create:
	go run -mod=mod database/migrate/main.go ${name}
	atlas migrate hash --dir="file://database/migrate/migrations"

MIGRATE := go run -tags="postgres" github.com/golang-migrate/migrate/v4/cmd/migrate
DB_URL := postgresql://ent-api-sample-db-1:5432/sampledb?user=root&password=password&sslmode=disable
MIGRATE_OPTS := -source file://database/migrate/migrations -database "$(DB_URL)"

.PHONY: migrate-up
migrate-up:
	$(MIGRATE) $(MIGRATE_OPTS) up $(n)

.PHONY: migrate-drop
migrate-drop:
	$(MIGRATE) $(MIGRATE_OPTS) drop $(FORCE)

.PHONY: migrate-reset
migrate-reset: migrate-drop migrate-up