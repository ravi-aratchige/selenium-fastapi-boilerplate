# ------------------------------------------------------
#     PULLING THE IMAGE AND SETTING UP GOOGLE CHROME
# ------------------------------------------------------

FROM python:3.8

# Set Chrome and Chromedriver versions
ENV CHROMEDRIVER_VERSION 114.0.5735.90
ENV CHROME_VERSION 114.0.5735.90-1

# Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# Adding Google Chrome to the repositories
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Update the package list
RUN apt-get -y update

# Install Google Chrome
RUN wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb \
  && apt install -y /tmp/chrome.deb \
  && rm /tmp/chrome.deb

# ------------------------------------------------------
#               INSTALLING CHROME DRIVER
# ------------------------------------------------------

# Set Chromedriver path environment variable
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Install Unzip
RUN apt-get install -yqq unzip

# Download the Chrome Driver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"

# Unzip the Chrome Driver into path directory
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

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
