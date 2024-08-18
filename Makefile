.PHONY: tidy
tidy:
	go mod tidy

.PHONY: generate
generate:
	go generate ./database/ent
	go generate ./database/ent/schema
