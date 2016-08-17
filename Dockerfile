FROM python:3
MAINTAINER Mark Ignacio <mignacio@hackucf.org>
ENV PYTHONUNBUFFERED 1
RUN mkdir -p /srv/http/ppl/code
RUN mkdir -p /srv/http/ppl/static
WORKDIR /srv/ppl/code
ADD ppl/requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install psycopg2
RUN pip install gunicorn

WORKDIR /srv/ppl
ADD ppl code
ADD conf/client_secret.json code
ADD conf/local_settings.py code/ppl/

WORKDIR /srv/ppl/code
ADD run.sh .

RUN useradd -m django
RUN chown -R django:django /srv/ppl
USER django
CMD sh run.sh