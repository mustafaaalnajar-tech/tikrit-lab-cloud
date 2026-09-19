FROM node:22-bookworm-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends unzip ca-certificates && rm -rf /var/lib/apt/lists/*
COPY tikrit-lab-cloud-fixed.zip /tmp/project.zip
RUN unzip -q /tmp/project.zip -d /tmp/project && cp -a /tmp/project/tikrit-lab-cloud/. /app/ && rm -rf /tmp/project /tmp/project.zip
RUN corepack enable && pnpm install --frozen-lockfile && pnpm build
ENV NODE_ENV=production
CMD ["node", "dist/index.js"]
