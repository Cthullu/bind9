# Set base base image for following commands
FROM alpine:3.18.2

# Set environment variables
ENV LC_ALL C.UTF-8

# Update all packages
# Install BIND 9
RUN apk -U --no-cache upgrade                                                   \
    && apk add --no-cache bind bind-tools                                       \
    && rm -rf /var/cache/apk/*

# Create a system group and user named bind
RUN addgroup -S bind                                                            \
    && adduser -S -D -G bin bind

# Create folder structure and adapt permissions
RUN mkdir -p /etc/bind                                                          \
    && mkdir -p /var/cache/bind                                                 \
    && mkdir -p /var/lib/bind                                                   \
    && mkdir -p /var/log/bind                                                   \
    && mkdir -p /run/named                                                      \
    && chown root:bind /etc/bind/                                               \
    && chown bind:bind /var/cache/bind                                          \
    && chown bind:bind /var/lib/bind                                            \
    && chown bind:bind /var/log/bind                                            \
    && chown bind:bind /run/named                                               \
    && chmod 755 /etc/bind                                                      \
    && chmod 755 /var/cache/bind                                                \
    && chmod 755 /var/lib/bind                                                  \
    && chmod 755 /var/log/bind                                                  \
    && chmod 755 /run/named

# Create mount points with the specified names and mark them as holding externally mounted volumes
VOLUME ["/etc/bind", "/var/cache/bind", "/var/lib/bind", "/var/log"]

# Documentation purpose: Ports the container listens on
EXPOSE 53/udp 53/tcp 953/tcp

# Specify a entrypoint. CMD parsed will be apended
ENTRYPOINT [ "/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind" ]
