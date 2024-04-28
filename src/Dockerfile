FROM amazonlinux:2023

# Update the system and install necessary packages
RUN yum update -y && \
    yum install -y findutils openssl zip

# Prepare the directory structure in the layer
RUN mkdir -p /tmp/layer/bin /tmp/layer/lib

# Copy the OpenSSL binary
RUN cp /usr/bin/openssl /tmp/layer/bin/

# Find and copy the latest OpenSSL libraries
RUN cp $(find /usr/lib64/ -name 'libssl.so.*' | head -n 1) /tmp/layer/lib/libssl.so.3 && \
    cp $(find /usr/lib64/ -name 'libcrypto.so.*' | head -n 1) /tmp/layer/lib/libcrypto.so.3

# Zip everything in the /tmp/layer directory
WORKDIR /tmp/layer
RUN zip -r layer.zip ./* && \
    echo "Zip file created. Contents of /tmp/layer:" && ls -l /tmp/layer
