FROM ubuntu:latest
LABEL version="1.0"

COPY factorial.deb /
COPY install.sh /
RUN chmod +x /install.sh
CMD ["/install.sh"]
