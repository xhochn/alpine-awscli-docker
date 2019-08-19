FROM alpine:3.10
RUN apk -v --no-cache add \
        python \
        py-pip \
        groff \
        less \
        zip \
        sed \
        jq==1.6_rc1-r0 \
        mailcap \
        docker \
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic==0.4.15 && \
    apk -v --purge del py-pip
VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
