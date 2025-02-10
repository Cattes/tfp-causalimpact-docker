# create a full dockerfile that installs the python poetry package into the environment
# and then installs the dependencies from the pyproject.toml file
# and then runs the poetry run command to start the application
# Use python:3.10.16 as python kernel.
# The pyhon container has a 3.10.16 version of python installed with all the packages
# I also saw that the default python env of the container is Python 3.11.2, I think from the
# debian 11 image that is used as the base image for the python image.
# so when running the container you need to make sure that you are using the correct python version
# create a full dockerfile that installs the python poetry package into the environment
# and then installs the dependencies from the pyproject.toml file
# and then runs the poetry run command to start the application

# Use the python:3.10-slim image as the base image
FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    pkg-config \
    software-properties-common \
    unzip \
    libatlas-base-dev \
    libopenblas-dev \
    liblapack-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install poetry

RUN poetry config virtualenvs.create false

COPY pyproject.toml .
COPY poetry.lock .
COPY causalimpact_simulation.ipynb .

RUN poetry install --no-root
