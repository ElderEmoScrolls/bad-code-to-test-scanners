# Intentionally outdated and vulnerable base image
FROM ubuntu:14.04

# Hardcoded secrets (DO NOT DO THIS IN REAL LIFE)
ENV AWS_ACCESS_KEY_ID="AKIAFAKEKEY123456"
ENV AWS_SECRET_ACCESS_KEY="fakeSecretKeyDontUseThis"
ENV DB_PASSWORD="SuperSecretPassword123"
ENV JWT_SECRET="hardcoded-jwt-secret"

# Run as root (default) and create world-writable directory
RUN mkdir /app && chmod 777 /app

# Install packages without cleaning cache (bloated image)
RUN apt-get update && \
    apt-get install -y curl wget netcat openssh-server python && \
    apt-get upgrade -y

# Add SSH with default credentials (insecure practice)
RUN useradd -m admin && \
    echo "admin:admin123" | chpasswd

# Copy entire repo including potential .env files and secrets
COPY . /app

WORKDIR /app

# Pull and execute remote script (classic red flag)
RUN curl -s http://example.com/install.sh | bash

# Expose unnecessary ports
EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 3306

# Disable SSL verification globally (bad practice)
ENV NODE_TLS_REJECT_UNAUTHORIZED=0

# Make everything executable
RUN chmod -R 777 /app

# Run as root
CMD ["bash"]
