FROM alpine

ENV DDNSS_KEYAUTH="somekey"
ENV DDNSS_HOSTNAME="somehostname.ddnss.eu"

COPY ddnss-update.sh /usr/local/bin
RUN chmod +x /usr/local/bin/ddnss-update.sh
RUN addgroup -g 1000 ddnss_update && adduser -u 1000 -G ddnss_update -D -H ddnss_update
RUN mkdir /config && chown ddnss_update:ddnss_update /config

USER ddnss_update

VOLUME [ "/config" ]

CMD [ "/usr/local/bin/ddnss-update.sh" ]
