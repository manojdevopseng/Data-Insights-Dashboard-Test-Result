# Use an official Python runtime as a parent image
FROM python:3.8

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Chrome and required dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libxrender1 \
    libxslt1.1 \
    libappindicator1 \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcairo2 \
    libgtk-3-0 \
    libxtst6 \
    xvfb

# Install Chrome WebDriver
RUN wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE -O /tmp/chromedriver_latest
RUN wget https://chromedriver.storage.googleapis.com/$(cat /tmp/chromedriver_latest)/chromedriver_linux64.zip -O /tmp/chromedriver.zip
RUN unzip /tmp/chromedriver.zip -d /usr/local/bin/
RUN chmod +x /usr/local/bin/chromedriver

# Install required Python packages
RUN pip install selenium pytz boto3

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME Test

# Run script.py when the container launches
CMD ["python", "latestscript.py"]
