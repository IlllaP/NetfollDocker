FROM python:3.8-slim as python-base

# Set environment variables
ENV DOCKER=true \
    GIT_PYTHON_REFRESH=quiet \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libcairo2 \
        git \
        build-essential \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Clone the repository
WORKDIR /Netfoll
RUN git clone https://github.com/MXRRI/Netfoll/tree/0.3.7 .

# Install Python dependencies
RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 8080

# Create data directory
RUN mkdir /data

# Define the command to run the application
CMD python -m hikka
