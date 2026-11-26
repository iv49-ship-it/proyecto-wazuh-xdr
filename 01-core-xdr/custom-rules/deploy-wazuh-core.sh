#!/bin/bash
# Script de despliegue reproducible - Wazuh Core (S3)
# Ecosistema: Wazuh 4.14 (v4.14.10) sobre Ubuntu Server

# 1. Configurar parámetro de kernel para OpenSearch / Wazuh Indexer
sudo sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf

# 2. Crear y activar 2 GB de memoria SWAP de respaldo
sudo fallocate -l 2G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# 3. Registrar repositorio oficial de Wazuh
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && sudo chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
sudo apt-get update

# 4. Pre-descargar paquetes (resistencia a fallos de red)
sudo apt-get install --download-only -y wazuh-indexer wazuh-manager wazuh-dashboard

# 5. Ejecutar instalador automatizado All-in-One
curl -sO https://packages.wazuh.com/4.10/wazuh-install.sh
sudo bash wazuh-install.sh -a

# 6. Habilitar inicio autónomo de servicios
sudo systemctl enable wazuh-indexer wazuh-manager wazuh-dashboard
📄 2. Actualizar el README.md Principal (Raíz del Repositorio)
Agrega o edita la sección del despliegue en el README.md principal:
## 🛠️ Despliegue de Wazuh Core (Semana 3)

### Declaración de Versión
- **Ecosistema:** Wazuh 4.14 (rama estable `current`), versión exacta verificada en el sistema: **v4.14.10**.
- **Plataforma:** Despliegue All-in-One sobre Ubuntu Server en Oracle VirtualBox.

### Prerrequisitos de Kernel y Memoria
- **Kernel Parameter:** `vm.max_map_count=262144` (requerido para la inicialización de JVM en `wazuh-indexer`).
- **Memoria SWAP:** Asignación de 2 GB en `/swapfile` para resiliencia en picos de consumo de memoria.

### Resiliencia de Instalación y Verificación
- **Pre-descarga local:** Uso de `apt-get install --download-only` para aislar la descarga ante fluctuaciones de red.
- **Arranque autónomo:** Habilitado mediante `systemctl enable` para `wazuh-indexer`, `wazuh-manager` y `wazuh-dashboard`.
- **Punto de Restauración:** Snapshot registrado en VirtualBox 

