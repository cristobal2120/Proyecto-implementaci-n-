#!/bin/bash
# Ejecutar EN LA VM Oracle (Ubuntu) tras el primer SSH. Parte 4–6 de DEPLOY_GRATIS.md
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/cristobal2120/Proyecto-implementaci-n-.git}"
APP_DIR="${APP_DIR:-$HOME/cobros-residenciales}"

echo "==> Instalando Docker..."
sudo apt-get update -qq
sudo apt-get install -y git docker.io docker-compose-v2
sudo usermod -aG docker "$USER"
echo "    Cierra SSH, vuelve a entrar, y ejecuta de nuevo este script si 'docker' falla sin sudo."

if ! docker info &>/dev/null; then
  echo "    (Reconecta SSH y vuelve a correr: bash oracle-vm-bootstrap.sh)"
  exit 0
fi

echo "==> Clonando repo..."
if [ ! -d "$APP_DIR/.git" ]; then
  git clone "$REPO_URL" "$APP_DIR"
fi
cd "$APP_DIR"

if [ ! -f .env ]; then
  if [ -f .env.produccion-vm ]; then
    cp .env.produccion-vm .env
  else
    cp .env.production.example .env
    echo "    Edita .env: MONGODB_URI y JWT_SECRET antes de levantar Docker."
  fi
fi

echo "==> Levantando stack producción (primera vez tarda varios minutos)..."
docker compose -f docker-compose.prod.yml --env-file .env up --build -d

echo "==> Estado:"
docker compose -f docker-compose.prod.yml ps
echo ""
echo "Prueba: curl -s http://localhost:8000/health"
echo "Frontend (si puerto 80 abierto): http://$(curl -s ifconfig.me 2>/dev/null || echo IP_PUBLICA)"
