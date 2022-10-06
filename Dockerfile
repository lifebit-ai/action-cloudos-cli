# Base image
FROM quay.io/lifebitaiorg/cloudos-cli:v1.1.0

# installes required packages for our script
RUN	apt install -y \
  bash \
  ca-certificates \
  curl \
  jq

# Copies your code file  repository to the filesystem
COPY entrypoint.sh /entrypoint.sh

# change permission to execute the script and
RUN chmod +x /entrypoint.sh

# file to execute when the docker container starts up
ENTRYPOINT ["/entrypoint.sh"]
