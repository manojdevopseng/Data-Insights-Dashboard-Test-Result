from selenium import webdriver
from selenium.webdriver.chrome.service import Service


driver=webdriver.Chrome()
print(type(driver))
driver.get("http://www.google.com")
myPageTitle=driver.title
print(myPageTitle)
assert "Google" in myPageTitle
# Get browser logs
browser_logs = driver.get_log("browser")

# Open a text file for writing the logs
with open("browser_logs.txt", "w") as log_file:
    for log_entry in browser_logs:
        log_file.write(f"{log_entry}\n")  # Write each log entry to the file

# Take Screenshot of test results
driver.get_screenshot_as_file("Selenium.png")
print(driver.quit)
driver.quit()