all: lint test

lint:
	docker run --rm \
	    -v $(PWD):/src \
	    -w /src \
	    koalaman/shellcheck:v0.7.0 tap2xunit

test:
	docker run --rm \
	    -v $(PWD):/src \
	    -w /src \
	    bats/bats:1.11.1 tests/*.bats
