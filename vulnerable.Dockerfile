FROM ubuntu:latest

# Running as root
USER root

# Hardcoded credentials in image
ENV DB_PASSWORD="mysql_root_pass_123"
ENV API_KEY="sk-test-key-12345"
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

# Installing packages without specifying versions (uncontrolled dependencies)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    wget \
    git

# Installing from pip without version pinning
RUN pip3 install flask django requests

# Copying entire directory without .dockerignore
COPY . /app

# Using ADD instead of COPY for remote files (security risk)
ADD https://example.com/script.sh /app/script.sh

# Running arbitrary script
RUN /app/script.sh

# Exposing debug port
EXPOSE 5000 8000 22

# Running application as root
WORKDIR /app
CMD ["python3", "app.py"]

# No health checks
# No security scanning
# No minimal base image

trigger the scanner
#now!
FROM ubuntu:latest

# Running as root
USER root

# Hardcoded credentials in image
ENV DB_PASSWORD="mysql_root_pass_123"
ENV API_KEY="sk-test-key-12345"
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

# Installing packages without specifying versions (uncontrolled dependencies)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    wget \
    git

# Installing from pip without version pinning
RUN pip3 install flask django requests

# Copying entire directory without .dockerignore
COPY . /app

# Using ADD instead of COPY for remote files (security risk)
ADD https://example.com/script.sh /app/script.sh

# Running arbitrary script
RUN /app/script.sh

# Exposing debug port
EXPOSE 5000 8000 22

# Running application as root
WORKDIR /app
CMD ["python3", "app.py"]

# No health checks
# No security scanning
# No minimal base image

trigger the scanner
#now!
