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
	    dduportal/bats:1.1.0 tests/*.bats
