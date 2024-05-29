"""Set up Chrome options and other configurations for the Chrome webdriver.
"""

from selenium.webdriver.chrome.options import Options


def set_chrome_options() -> Options:
    """Sets chrome options for Selenium.

    Chrome options for headless browser is enabled.
    """

    chrome_options = Options()

    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")

    chrome_prefs = {}
    chrome_options.experimental_options["prefs"] = chrome_prefs
    chrome_prefs["profile.default_content_settings"] = {"images": 2}

    return chrome_options
