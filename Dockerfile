# ------------------------------------------------------
#     PULLING THE IMAGE AND SETTING UP GOOGLE CHROME
# ------------------------------------------------------


FROM python:3.8

# Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# Adding Google Chrome to the repositories
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Update the package list
RUN apt-get -y update

# Install Google Chrome
RUN apt-get install -y google-chrome-stable


# ------------------------------------------------------
#               INSTALLING CHROME DRIVER
# ------------------------------------------------------


# Installing Unzip
RUN apt-get install -yqq unzip

# Download the Chrome Driver
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`
# curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE
# `/chromedriver_linux64.zip
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/125.0.6422.141/chromedriver_linux64.zip

# Unzip the Chrome Driver into /usr/local/bin directory
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# Set display port as an environment variable
ENV DISPLAY=:99


# ------------------------------------------------------
#        RUNNING PYTHON APPLICATION WITH DOCKER
# ------------------------------------------------------


COPY . /app
WORKDIR /app

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

CMD ["uvicorn", "app.app:app", "--host", "0.0.0.0", "--port", "8000"]