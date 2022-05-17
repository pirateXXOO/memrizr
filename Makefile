.PHONY: create-keypair

PWD = $(shell pwd)
ACCTPATH = $(PWD)/account
MPATH = $(ACCTPATH)/migrations
PORT = 5432

# Default number of migrations to execute up or down
N = 1

create-keypair:
	@echo "Creating an rsa 256 key pair"
	openssl genpkey -algorithm RSA -out $(ACCTPATH)/rsa_private_$(ENV).pem -pkeyopt rsa_keygen_bits:2048
	openssl rsa -in $(ACCTPATH)/rsa_private_$(ENV).pem -pubout -out $(ACCTPATH)/rsa_public_$(ENV).pem

migrate-create:
	@echo  "---Creating migration files---"
	docker run -v $(MPATH):/migrations  migrate/migrate  create -ext sql -dir /migrations/ -seq -digits 5 $(NAME)

migrate-up:
	docker run -v $(MPATH):/migrations  --network host migrate/migrate -path /migrations -source file:///migrations -database postgres://postfres:password@localhost:$(PORT)/postgres?sslmode=disable up $(N)

migrate-down:
	docker run -v $(MPATH):/migrations  --network host migrate/migrate -path /migrations -source file:///migrations -database postgres://postfres:password@localhost:$(PORT)/postgres?sslmode=disable down $(N)

migrate-force:
	docker run -v $(MPATH):/migrations  --network host migrate/migrate -path /migrations -source file:///migrations -database postgres://postfres:password@localhost:$(PORT)/postgres?sslmode=disable force $(VERSION)
