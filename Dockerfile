
# Base image
FROM python:3.11-slim as base

ARG SERVER_PORT=8000
ENV SERVER_PORT=$SERVER_PORT

WORKDIR /backend

# Install poetry
COPY install-poetry.py .
ENV POETRY_HOME=/opt/poetry
RUN python install-poetry.py --version 1.5.1

# Install python packages
COPY pyproject.toml poetry.lock .
RUN $POETRY_HOME/bin/poetry config virtualenvs.create false
RUN $POETRY_HOME/bin/poetry install -n --no-cache --no-root

EXPOSE $SERVER_PORT

# Add entrypoint script
ENTRYPOINT [ "bash", "-c", "$POETRY_HOME/bin/poetry run uvicorn app.main:app --port $SERVER_PORT --host 0.0.0.0 $@", "docker-entrypoint.sh" ]


# Run image
FROM base as run

COPY app/ app/
