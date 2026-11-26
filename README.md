# Laboratorio XDR - Iván Chacón

Repositorio de configuraciones, reglas y scripts para el laboratorio Wazuh (XDR).

## Convención de Ramas y Commits
- **Ramas:** `main` para versiones estables y `feature/nombre-tarea` para desarrollo.
- **Commits:** En español, usando corchetes para el contexto (ej: `[S2] Estructura inicial`, `[CU-01] Regla PHP`).

## Despliegue de Wazuh Core (Semana 3)

### Declaración de Versión
- **Ecosistema:** Wazuh 4.14 (rama estable `current`), versión exacta verificada en el sistema: **v4.14.10**.
- **Plataforma:** Despliegue All-in-One sobre Ubuntu Server (versión 26.04) en Oracle VirtualBox.

### Prerrequisitos de Kernel y Memoria
- **Kernel Parameter:** `vm.max_map_count=262144` (requerido para la inicialización de la JVM de `wazuh-indexer`).
- **Memoria SWAP:** Asignación de 2 GB en `/swapfile` para resiliencia en momentos de "peak" de consumo de memoria.

### Resiliencia de Instalación y Verificación
- **Pre-descarga local:** Uso de `apt-get install --download-only` para aislar la descarga ante fluctuaciones de red.
- **Arranque autónomo:** Habilitado mediante `systemctl enable` para `wazuh-indexer`, `wazuh-manager` y `wazuh-dashboard`.
- **Punto de Restauración:** Snapshot registrado en VirtualBox como **`S3-Wazuh-OK`**.
