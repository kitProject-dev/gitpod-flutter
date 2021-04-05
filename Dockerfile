FROM gitpod/workspace-full

ENV FLUTTER_HOME=/home/gitpod/flutter \
    FLUTTER_CHANNEL=stable \
    FLUTTER_VERSION=2.0.4

# Install dart
USER root

RUN apt-get update && apt-get upgrade -y

USER gitpod

# Install Flutter sdk
RUN cd /home/gitpod && \
    git clone https://github.com/flutter/flutter.git && \
    cd $FLUTTER_HOME/examples/hello_world && \
    $FLUTTER_HOME/bin/flutter channel ${FLUTTER_CHANNEL} && \
    cd $FLUTTER_HOME/ && \
    git checkout ${FLUTTER_VERSION}

# Change the PUB_CACHE to /workspace so dependencies are preserved.
ENV PUB_CACHE=/workspace/.pub_cache

# add executables to PATH
RUN echo 'export PATH=${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PUB_CACHE}/bin:${FLUTTER_HOME}/.pub-cache/bin:$PATH' >>~/.bashrc
