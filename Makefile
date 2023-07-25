postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb --username=root --owner=root simple_bank

# migrateup:
# 	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
# migratedown:
# 	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1
sqlc:
	docker run --rm -v "E:\goproject\db:/src" -w /src kjconroy/sqlc generate
test:
	go test -v -cover ./...	
.PHONY:postgres createdb dropdb	migrateup migratedown sqlc test migrateup1 migratedown1