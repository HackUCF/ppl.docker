#!/bin/bash

./manage.py migrate
gunicorn --workers 3 ppl.wsgi --bind :8000
