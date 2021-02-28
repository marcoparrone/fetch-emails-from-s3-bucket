#!/bin/sh
usage() {
	echo "Usage: fetch-s3-emails.sh --region=region s3://bucketname/prefix/"
}

if [ $# -eq 0 ]; then
	echo "check-s3-emails.sh: ERROR: missing argument." >&2
	usage
	exit 1
fi

mytmpdir=$(mktemp -d)
cd "$mytmpdir"
aws s3 sync $@ .
dos2unix *
for mail in *; do formail < $mail | procmail; done
cd -
rm -rf "$mytmpdir"
aws s3 rm  --recursive $@
