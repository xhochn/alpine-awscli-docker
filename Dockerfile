FROM alpine:3.6

LABEL name="alpine-awscli-docker"
LABEL team="TechOps"
LABEL version="1.0"
LABEL alpine="3.6"

# hadolint ignore=DL3018
RUN apk -v --no-cache add \
        python \
        py-pip \
        groff \
        less \
        zip \
        tar \
        curl \
        jq \
        sed \
        mailcap \
        docker \
        && \
    pip install --upgrade awscli==1.16 awsebcli==3.15 s3cmd==2.0.1 python-magic==0.4.15 && \
    apk -v --purge del py-pip

ENV PROMETHEUS_VERSION=2.12.0
ENV ALERTMANAGER_VERSION=0.18.0

ENV PROMETHEUS_DOWNLOAD_URL https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
ENV ALERTMANAGER_DOWNLOAD_URL https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN curl -L -s $PROMETHEUS_DOWNLOAD_URL \
		| tar -xz -C /usr/local/bin --strip-components=1 prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool;
RUN curl -L -s $ALERTMANAGER_DOWNLOAD_URL \
		| tar -xz -C /usr/local/bin --strip-components=1 alertmanager-${ALERTMANAGER_VERSION}.linux-amd64/amtool;

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
