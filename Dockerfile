# Inherit from Heroku's Ubuntu 16ish stack
FROM heroku/heroku:16

# Install the requirements for installing psycopg2
RUN apt-get update && \
  apt-get install -y libpq-dev python-dev gcc && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt/archives/*.deb


# Make locally-built containers run as not-root
RUN useradd -m notroot && \
  chmod -R 0777 /usr/local/lib/python2.7/* && \
  chmod -R 0777 /usr/local/bin && \
  mkdir -p /app && \
  chmod -R 0777 /app
USER notroot

# Install Pip & Setuptools
RUN curl -s https://bootstrap.pypa.io/get-pip.py | /usr/bin/python

# Make python read modules from /app/
ENV PYTHONPATH=/app/
ENV PYTHONUNBUFFERED=true
WORKDIR /app

CMD ["python"]
