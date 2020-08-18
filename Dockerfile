FROM alpine:3.9

ARG USERNAME=prowler
ARG USERID=34000

WORKDIR /prowler

COPY . ./

RUN addgroup -g ${USERID} ${USERNAME} && \
    adduser -s /bin/sh -G ${USERNAME} -D -u ${USERID} ${USERNAME} && \
    apk --update --no-cache add python3 bash curl jq file && \
    pip3 install --upgrade pip && \
    pip install awscli boto3 detect-secrets && \
    chown -R prowler . && \
    mv entrypoint.sh /usr/local/bin/entrypoint.sh

USER ${USERNAME}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]