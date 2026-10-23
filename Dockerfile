FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PORT=8080
ENV HOME=/home/ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    python3 \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/ubuntu/.local/bin /home/ubuntu/.gemini/antigravity-cli /app && \
    chown -R ubuntu:ubuntu /home/ubuntu /app

WORKDIR /app
USER ubuntu
ENV PATH="/home/ubuntu/.local/bin:${PATH}"

RUN curl -fsSL https://antigravity.google/cli/install.sh | bash || true

COPY --chown=ubuntu:ubuntu auth.vault /app/auth.vault
COPY --chown=ubuntu:ubuntu index.html /app/index.html
COPY --chown=ubuntu:ubuntu server.py /app/server.py
COPY --chown=ubuntu:ubuntu entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh /app/server.py

EXPOSE 8080
ENTRYPOINT ["/app/entrypoint.sh"]
