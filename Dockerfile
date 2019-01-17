FROM python:3.6.4-jessie

WORKDIR /app

COPY requirements.txt requirements.dev.txt requirements.prod.txt ./

RUN pip install --no-cache-dir -r requirements.txt && \
    mkdir -p .git/hooks

COPY . ./


