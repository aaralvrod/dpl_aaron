#!/bin/bash

ssh dplprod_aaron@10.102.23.40 "
  cd /home/dplprod_aaron/dpl_aaron/ut4/a3/travelroad_laravel/travelroad
  git pull
  composer install
  php artisan migrate
"
