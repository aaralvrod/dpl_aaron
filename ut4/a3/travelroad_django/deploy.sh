#!/bin/bash

SERVER="dplprod_aaron@100.102.23.40"
PROJECT_DIR="/home/dplprod_aaron/dpl_aaron/ut4/a3/travelroad_django"

echo "=== Despliegue Django en producción ==="
echo "Servidor: ${SERVER}"
echo "Directorio: ${PROJECT_DIR}"
echo

ssh -t ${SERVER} << 'ENDSSH'
  set -e  # Detener script en caso de error
  
  echo "1. 📂 Accediendo al directorio del proyecto..."
  cd ${PROJECT_DIR} || { echo "Error: Directorio no encontrado"; exit 1; }
  
  echo "2. 🐍 Activando entorno virtual..."
  source .venv/bin/activate || { echo "Error: No se pudo activar el venv"; exit 1; }
  
  echo "3. 📦 Actualizando dependencias..."
  pip install -r requirements.txt
  
  echo "4. 🗃️ Aplicando migraciones..."
  python3 manage.py migrate
  
  echo "5. 📁 Recopilando archivos estáticos..."
  python3 manage.py collectstatic --noinput --clear
  
  echo "6. 🔄 Reiniciando Gunicorn..."
  sudo systemctl restart gunicorn
  echo
  python3 manage.py runserver 0.0.0.0:8000
  echo "🎉 Despliegue completado exitosamente!"
ENDSSH