# fetch-emails-from-s3-bucket

This container image packages awscli, procmail, spamassassin, dos2unix, mutt and lynx, plus some configuration files and a pair of scripts.

The purpose of this package is to provide a convenient way to read emails from an S3 bucket.

## Prerequisites

First of all you need to setup Amazon SES (Simple Email Service) to receive emails into an S3 bucket.

Then podman or docker are needed.

I tested these scripts on CentOS Stream release 8 with podman.

If you use docker, replace docker=podman with docker=docker in the Makefile.

## Installation

```sh
git clone git@github.com:marcoparrone/fetch-emails-from-s3-bucket.git
cd fetch-emails-from-s3-bucket
ls -la config
# ... check in the config folder if there is some seetting that you want to customize ...
make
```

## Usage

Add the following lines in your ~/.bash_aliases or in your ~/.bashrc, replacing BUCKET and PREFIX with the s3 bucket and the prefix where the emails are delivered, and replacing REGION with the region of the bucket (for example, eu-west-1):

```sh
alias check-s3-emails='podman run --rm -it -v ~/.aws:/root/.aws -v ~/Mail:/root/Mail -w /root marcoparrone/fetch-emails-from-s3-bucket check-s3-emails.sh --region=REGION s3://BUCKET/PREFIX/'
alias fetch-s3-emails='podman run --rm -it -v ~/.aws:/root/.aws -v ~/Mail:/root/Mail -v ~/.spamassassin:/root/.spamassassin -w /root marcoparrone/fetch-emails-from-s3-bucket fetch-s3-emails.sh --region=REGION s3://BUCKET/PREFIX/'
alias mutt='podman run --rm -it --network none -v ~/.aws:/root/.aws -v ~/Mail:/root/Mail -w /root marcoparrone/fetch-emails-from-s3-bucket mutt'
alias spamisspam='podman run --rm -it --network none -v ~/.aws:/root/.aws -v ~/Mail:/root/Mail -v ~/.spamassassin:/root/.spamassassin -w /root marcoparrone/fetch-emails-from-s3-bucket sa-learn --spam /root/Mail/spam/'
alias hamisham='podman run --rm -it --network none -v ~/.aws:/root/.aws -v ~/Mail:/root/Mail -v ~/.spamassassin:/root/.spamassassin -w /root marcoparrone/fetch-emails-from-s3-bucket sa-learn --ham /root/Mail/inbox/'
```

then, after reloading the file, you can run the following commands:

```sh
check-s3-emails # Just for checking if there are some emails, by using the "aws s3 ls" command.
fetch-s3-emails # To download the emails, removing them from the bucket. ATTENTION!: the script will remove EVERYTHING under s3://BUCKET/PREFIX/.
mutt # For reading the emails.
spamisspam # If you are sure that the emails in the spam folder are really spam, with this command you can train spamassassin the recognize them as spam.
hamisham # If you are sure that the emails in the inbox folder aren't spam, with this command you can train spamassassin to recognize them as ham (not spam).
```
