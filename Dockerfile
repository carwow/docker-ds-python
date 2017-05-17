# Inherit from Heroku's Ubuntu 16ish stack
FROM heroku/heroku:16

# Install the requirements for installing psycopg2
RUN apt-get update && \
  apt-get install -y libpq-dev python-dev gcc && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt/archives/*.deb

# Install Pip & Setuptools
RUN curl -s https://bootstrap.pypa.io/get-pip.py | /usr/bin/python

# Make python read modules from /app/
ENV PYTHONPATH=/app/
WORKDIR /app

# Make locally-built containers run as not-root
RUN useradd -m notroot
USER notroot

# Install requirements, and add the app on build
ONBUILD ADD requirements.txt /app/
ONBUILD RUN sudo /usr/local/bin/pip install -r requirements.txt
ONBUILD ADD . /app

CMD ["python"]