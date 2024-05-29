# Selenium and FastAPI Boilerplate

This repository contains a boilerplate for running a FastAPI application with Selenium running in headless mode. This project can be easily deployed to the [Koyeb Serverless Platform](https://www.koyeb.com) using Docker.

This boilerplate can be used to build Rest APIs where a Selenium headless browser must be configured to run on a server environment.

## Setup

### Manual Setup

To set up this project on your local environment manually, the following prerequisites must be installed:

1. [Git](https://git-scm.com/)
2. [Python](https://www.python.org/) with [Pip](https://pypi.org/project/pip/)

First, clone the project to your local environment:

```shell
git clone "https://github.com/ravi-aratchige/selenium-fastapi-boilerplate.git"
```

Move into the project folder:

```shell
cd selenium-fastapi-boilerplate
```

Create a virtual environment to isolate the project's dependencies:

```shell
python -m venv env

# or

python3 -m venv env
```

Activate the virtual environment:

```shell
# on Windows:
.\env\Scripts\activate

# on MacOS or Linux
source env/bin/activate
```

Install the project's dependencies:

```shell
pip install -r requirements.txt
```

Start the FastAPI application:

```shell
python main.py
```

FastAPI will serve the application on [localhost:8000](http://localhost:8000). To view the API docs (Swagger), go to [localhost:8000/docs](http://localhost:8000/docs).

### Setup with Docker

If you have Docker installed, you can follow these steps to set up the project locally.

First, clone the project to your local environment:

```shell
git clone "https://github.com/ravi-aratchige/selenium-fastapi-boilerplate.git"
```

Move into the project folder:

```shell
cd selenium-fastapi-boilerplate
```

Build the Docker image:

```shell
docker build -t selenium-fastapi-boilerplate .
```

Run a container from the image:

```shell
docker run -p 8000:8000 selenium-fastapi-boilerplate
```

FastAPI will serve the application on [localhost:8000](http://localhost:8000). To view the API docs (Swagger), go to [localhost:8000/docs](http://localhost:8000/docs).

---

Made with ❤️ by Ravindu Aratchige. Licensed under the [Apache License](https://github.com/ravi-aratchige/selenium-fastapi-boilerplate/blob/main/LICENSE).