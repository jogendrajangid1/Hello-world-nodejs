# Set the base image to Ubuntu
FROM ubuntu:14.04

MAINTAINER Jogendra Kumar <jogendra.jangid@gmail.com>

RUN mkdir -p /opt/node_space-api/
# Define working directory
WORKDIR /opt/node_space-api/

ADD ${{CODEBUILD_SRC_DIR}} /opt/node_space-api/Hello-world-nodejs

# Install Node.js and other dependencies
RUN apt-get update && apt-get -y install curl wget vim

#Install nodejs
RUN mkdir /opt/nodejs && curl http://nodejs.org/dist/v8.9.1/node-v8.9.1-linux-x64.tar.gz | tar xzf - -C /opt/nodejs --strip-components=1

ENV PATH $PATH:/opt/nodejs/bin

# Install PM2
RUN npm install pm2@2.4.2 -global

# Expose port
EXPOSE 80
# Run app
CMD pm2-docker start /opt/node_space-api/Hello-world-nodejs/app.js --auto-exit
