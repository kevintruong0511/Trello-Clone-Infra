.PHONY: local local-down dev prod down logs health

# Local coding: only postgres (5433) + redis (6380), run api/frontend with npm run dev
local:
	docker compose -f docker-compose.dev.yml up -d

local-down:
	docker compose -f docker-compose.dev.yml down

# Dev VPS: full stack, debug logs, HTTP
dev:
	NODE_ENV=development docker compose up -d --build

# Prod VPS: full stack (migrations run inside api container on boot)
prod:
	docker compose up -d --build

down:
	docker compose down

logs:
	docker compose logs -f --tail=100

health:
	@curl -fsS http://localhost:$${HTTP_PORT:-80}/health && echo " OK" || (echo "UNHEALTHY" && exit 1)
