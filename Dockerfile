# Stage 1: Build Python from source
FROM ubuntu:22.04 AS builder
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# Download and compile Python
RUN wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz && \
    tar -xvf Python-3.9.5.tgz && \
    cd Python-3.9.5 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall

# Stage 2: Setup the application
FROM ubuntu:22.04

# Copy Python binaries from builder stage
COPY --from=builder /usr/local/bin/python3.9 /usr/local/bin/python3
COPY --from=builder /usr/local/lib/python3.9 /usr/local/lib/python3

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py

# Install necessary Python packages
RUN pip install flask flask_sqlalchemy flask_marshmallow redis
RUN python3 initdb.py

# Copy your application code to the container
WORKDIR /app
COPY . /app

# Expose port for the Flask app to run on
EXPOSE 80
RUN mkdir -p /opt/flask/log

# Run the application and redirect logs
CMD ["python3", "app.py", ">", "/opt/flask/log/application.log", "2>&1"]


