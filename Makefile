postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb --username=root --owner=root simple_bank

migrateup:
	cd .\db\ && migrate -path migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	 migrate -path migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	docker run --rm -v "E:\goproject\db:/src" -w /src kjconroy/sqlc generate
test:
	cd .\db\ && go test -v -cover ./...	
.PHONY:postgres createdb dropdb	migrateup migratedown sqlc test