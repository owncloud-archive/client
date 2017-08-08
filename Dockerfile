FROM owncloud/alpine:edge
MAINTAINER ownCloud DevOps <devops@owncloud.com>

RUN apk update && \
  apk add build-base cmake qt5-qttools-dev qt5-qtwebkit-dev qt5-qtkeychain-dev@testing && \
  curl -sLo - https://github.com/owncloud/client/archive/v2.3.2.tar.gz | tar xzf - -C /tmp && \
  cd /tmp/client-2.3.2 && \
  cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_SYSCONFDIR=/etc/owncloud-client && \
  make all install && \
  cd && \
  rm -rf /tmp/client-2.3.2 && \
  apk del build-base cmake && \
  rm -rf /var/cache/apk/* /tmp/*

WORKDIR /
COPY rootfs /

LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/owncloud-docker/client.git"
LABEL org.label-schema.name="ownCloud Client"
LABEL org.label-schema.vendor="ownCloud GmbH"
LABEL org.label-schema.schema-version="1.0"
