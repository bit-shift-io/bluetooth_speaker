FROM alpine:latest

MAINTAINER David-Tillmann Schaefer "codingdave@gmail.com"

COPY speaker-agent.py /opt/speaker-agent/speaker-agent.py

RUN apk add \
    dbus \
    py3-dbus \
    py3-gobject3

# -u: unbuffered, to see python output in docker logs
ENTRYPOINT ["python3", "-u", "/opt/speaker-agent/speaker-agent.py"]
