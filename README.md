# Loki with Docker

This repo builds a self-contained Loki image using the official Grafana base image plus a local config.

## Files
- `Dockerfile` builds the Loki image and copies `config/loki-config.yaml` into the container.
- `config/loki-config.yaml` local, single-node config storing data on the filesystem.
- `docker-compose.yml` helper to build and run Loki with data persisted to `./data`.
- `.dockerignore` keeps local data/logs out of the build context.

## Usage
1. Build the image:
   ```bash
   docker compose build
   # or: docker build -t local/loki .
   ```
2. Run Loki (detached):
   ```bash
   docker compose up -d
   # or: docker run -d --name loki \
   #     -p 3100:3100 \
   #     -v "$(pwd)/config/loki-config.yaml:/etc/loki/local-config.yaml:ro" \
   #     -v "$(pwd)/data:/loki" \
   #     local/loki
   ```
3. Verify:
   ```bash
   curl http://localhost:3100/ready
   curl http://localhost:3100/metrics | head
   ```

Logs and indexes are written to `./data`. Stop with `docker compose down` (data kept) or `docker compose down -v` (data removed). If using plain Docker, stop with `docker stop loki && docker rm loki`; add `-v` to also remove volumes.
   ```bash
   docker build -t local/loki .
   ```
2. Run Loki (detached):
   ```bash
   docker run -d --name loki \
     -p 3100:3100 \
     -v "$(pwd)/config/loki-config.yaml:/etc/loki/local-config.yaml:ro" \
     -v "$(pwd)/data:/loki" \
     local/loki
   ```
3. Verify:
   ```bash
   curl http://localhost:3100/ready
   curl http://localhost:3100/metrics | head
   ```

Logs and indexes are written to `./data`. Stop with `docker stop loki && docker rm loki` (data kept). Use `docker rm -v` if you want to delete the container volumes too.
# devops-tools
