docker=podman

build:
	$(docker) build -t marcoparrone/fetch-emails-from-s3-bucket .

test: 
	$(docker) run --rm -it marcoparrone/fetch-emails-from-s3-bucket check-s3-emails.sh

clean:
	$(docker) rmi localhost/marcoparrone/fetch-emails-from-s3-bucket

all: build
