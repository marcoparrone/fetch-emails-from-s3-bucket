#!/bin/sh
usage() {
	echo "Usage: check-s3-emails.sh s3://bucketname/prefix/ --region=region"
}

if [ $# -eq 0 ]; then
	echo "check-s3-emails.sh: ERROR: missing argument." >&2
	usage
	exit 1
fi

aws s3 ls $@
