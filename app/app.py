"""
Boilerplate for Rest API that runs Selenium in headless mode
using FastAPI on a server (e.g. Koyeb Serverless Platform).

This module is the entrypoint to the FastAPI application.
"""

from fastapi import FastAPI
from selenium import webdriver
from selenium.webdriver.common.by import By
from fastapi.middleware.cors import CORSMiddleware
from utils.webdriver import set_chrome_options, set_firefox_options

# Initialize FastAPI application
app = FastAPI(
    title="Selenium and FastAPI Boilerplate",
    description="A boilerplate for running Selenium in headless mode using FastAPI on the Koyeb Serverless Platform",
)

# Define allowed origins for CORS
origins = [
    "*",
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:3001",
]

# Setup CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Setup root route (to test API health)
@app.get("/", tags=["Core"])
async def root():
    """The root route is used to test the API's health.

    Returns:
        dict: JSON object with simple message
    """

    # Send response to client
    return {
        "message": "Hello from the Selenium and Koyeb Serverless API!",
    }


# Route to scrape web and get response
@app.get("/scrape", tags=["Scraper"])
async def scrape_and_get_response():
    driver = webdriver.Chrome(options=set_chrome_options())

    # Do stuff with your driver
    driver.get("https://nander.cc/using-selenium-within-a-docker-container")
    title = driver.find_element(By.CLASS_NAME, "css-v7tbb5").text
    print(f"Page title: {title}")

    # Close the driver
    driver.close()

    # Send response to client
    return {
        "data": title,
    }
