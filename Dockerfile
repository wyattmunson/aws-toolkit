# FROM ubuntu:latest
FROM munsonwf/pipeline-toolkit:0.1.5

# build args
ARG ARCH

# debug
RUN echo $PATH
RUN whoami

# install packages
# RUN apt update -y
RUN apt install unzip -y
# RUN apt install curl -y

# x86
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# ARM
RUN if [ "$ARCH" = "amd64" ] ; then \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ; else \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" ; \
    fi
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ls -lah
RUN ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

RUN echo $(whoami)
