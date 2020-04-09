FROM ubuntu:latest

LABEL maintainer="themikelester@gmail.com"

# Install system-wide deps
RUN apt-get -yqq update
RUN apt-get -yqq install git cmake clang

# Install OpenSSL 1.0.2 (now deprecated)
RUN echo deb http://security.ubuntu.com/ubuntu xenial-security main >> /etc/apt/sources.list
RUN apt-get -yqq update
RUN apt-get -yqq --allow-downgrades install libssl1.0.0=1.0.2g-1ubuntu4.15 libssl-dev=1.0.2g-1ubuntu4.15

# Download and build webudp
RUN git clone https://github.com/themikelester/WebUDP.git /opt/webudp
RUN mkdir /opt/webudp/build
WORKDIR /opt/webudp/build
RUN cmake ..
RUN make

# Expose ports
EXPOSE 9555/tcp
EXPOSE 9555/udp

# Run the server
CMD ["./examples/EchoServer"]