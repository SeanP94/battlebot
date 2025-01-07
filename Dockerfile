# Use Ubuntu as the base image for better compatibility
FROM ubuntu:22.04

# Install OpenJDK and utilities
# Update the package repository and install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    git \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add the OpenJDK PPA for the latest versions
RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update

# Install OpenJDK 21
RUN apt-get install -y --no-install-recommends openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"


RUN yes | unminimize

# Set the working directory in the container
WORKDIR /home/battlebot

# Create the battlebot directory
RUN mkdir -p /home/battlebot && \
    chown -R root:root /home/battlebot

# Set /home/battlebot as the default home directory
ENV HOME=/home/battlebot

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
CMD ["sh", "-c", "while true; do sleep 1000; done"]