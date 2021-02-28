FROM fedora

RUN dnf install -y awscli procmail spamassassin dos2unix mutt lynx

WORKDIR /root

COPY config/.??* ./

COPY scripts/* /usr/local/bin/

CMD [ "check-s3-emails.sh" ]
