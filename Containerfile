FROM debian:latest

VOLUME /repo

RUN apt update && \
    apt install -y apksigner openjdk-17-jdk-headless python3 pipx && \
    rm -rf /var/lib/apt/lists/*

COPY apkrepotool /src/apkrepotool
COPY README.md setup.py /src/

RUN pipx install /src

COPY container/entrypoint.sh /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
