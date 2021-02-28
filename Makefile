docker=podman

build:
	$(docker) build -t marcoparrone/fetch-emails-from-s3-bucket-cli .

test: 
	$(docker) run --rm -it marcoparrone/fetch-emails-from-s3-bucket-cli check-s3-emails.sh

clean:
	$(docker) rmi localhost/marcoparrone/fetch-emails-from-s3-bucket-cli

all: build
