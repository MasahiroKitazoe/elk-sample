FROM nginx:latest

RUN apt-get update && \
    apt-get install -y logrotate && \
    service cron start
