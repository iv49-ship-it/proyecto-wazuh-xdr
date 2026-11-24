#!/bin/bash
# Script de despliegue base para Wazuh Core (All-in-one) - S3
# Requisitos: 
.Ubuntu Server 26.04.1 LTS
.Privilegios sudo

# 1. Ajuste obligatorio de memoria virtual para OpenSearch
sudo sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf

# 2. Descargar el asistente oficial de Wazuh 4.14.x
curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh

# 3. Ejecutar la instalación All-in-one
sudo bash wazuh-install.sh -a
