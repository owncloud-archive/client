FROM owncloud/alpine:edge

LABEL maintainer="ownCloud DevOps <devops@owncloud.com>" \
  org.label-schema.name="ownCloud Client" \
  org.label-schema.vendor="ownCloud GmbH" \
  org.label-schema.schema-version="1.0"

RUN apk update && \
  apk add build-base cmake qt5-qttools-dev qt5-qtwebkit-dev qt5-qtkeychain-dev@testing python2-dev python2 py2-pip texlive-full@testing xz zlib-dev jpeg-dev doxygen && \
  curl -sLo - ftp://ftp.tug.org/historic/systems/texlive/2016/texlive-20160523b-texmf.tar.xz | tar -Jxvf - --strip 1 -C /tmp && \
  cp -rf /tmp/texmf-dist/* /usr/share/texmf-dist/ && \
  rm -rf /tmp/texmf-dist && \
  apk fix texlive texlive-full && \
  pip install reportlab rst2pdf sphinxcontrib-phpdomain && \
  rm -rf /var/cache/apk/*

WORKDIR /
COPY rootfs /
