FROM alpine:3.8
RUN apk -v --no-cache add \
        python \
        py-pip \
        groff \
        less \
        zip \
        jq \
        sed \
        mailcap \
        docker \
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic==0.4.15 && \
    apk -v --purge del py-pip
VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
