# Use an official Python runtime as the base image
FROM python:3.13-slim

# Set environment variables (optional)
# Prevents Python from writing pyc files to disk and buffering stdout/stderr
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt update && apt install -y gcc python3-setuptools

# Copy the dependency file first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip setuptools && pip install -r requirements.txt

# Copy the rest of your application code
COPY . .

# Run installer script
RUN python setup.py install

# Define the command to run your app (adjust as needed)
ENTRYPOINT ["pyxamstore"]
