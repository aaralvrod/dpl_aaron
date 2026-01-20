#!/bin/bash

ssh dplprod_aaron@10.102.23.40 "
  cd /home/dplprod_aaron/dpl_aaron/ut4/a3/travelroad_django
  git pull

  source .venv/bin/activate
  #pip install -r requirements.txt

  # python manage.py migrate
  # python manage.py collectstatic --no-input

  #supervisorctl restart travelroad
  ./manage.py runserver 0.0.0.0:8000
"
