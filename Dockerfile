# Loki container built on the official Grafana Loki image.
FROM grafana/loki:2.9.4

# Use root for file setup, then drop back to Loki's non-root user.
USER root

# Copy the Loki configuration into place and ensure ownership of data/config paths.
COPY config/loki-config.yaml /etc/loki/local-config.yaml
RUN mkdir -p /loki \
    && chown -R 10001:10001 /loki /etc/loki

USER 10001
EXPOSE 3100

ENTRYPOINT ["/usr/bin/loki", "-config.file=/etc/loki/local-config.yaml"]
