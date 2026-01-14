#!/bin/bash

ssh dplprod_aaron@10.102.23.40 "
  cd /home/dplprod_aaron/dpl_aaron/ut4/a3/travelroad_django
  git pull

  source .venv/bin/activate
  #pip install -r requirements.txt

  #./manage.py migrate
  #./manage.py collectstatic --no-input

  supervisorctl restart travelroad
  ./manage.py runserver
"
