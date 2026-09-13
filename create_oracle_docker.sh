#!/usr/bin/env bash

# Hentikan eksekusi jika terjadi error
set -e

echo "=== [1/4] Membuat container Docker Oracle DB ==="
docker create -it \
  --name OrclDB \
  --restart unless-stopped \
  -p 8521:1521 \
  -p 8500:5500 \
  -p 8023:8080 \
  -p 9043:8443 \
  -p 9922:22 \
  -e ORACLE_PWD=admin123 \
  container-registry.oracle.com/database/free:23.26.3.0

echo "=== [2/4] Mengirimkan file ke dalam container ==="
docker cp unattended_apex_install.sh OrclDB:/home/oracle
docker cp 00_start_apex_ords_installer.sh OrclDB:/opt/oracle/scripts/startup
sleep 5

echo "=== [3/4] Menjalankan container OrclDB ==="
docker start OrclDB

echo "=== [4/4] Selesai! Container berhasil dijalankan. ==="