from selenium import webdriver
from selenium.webdriver.common.by import By

# Initialize a WebDriver instance (e.g., ChromeDriver)
driver = webdriver.Chrome()

# Navigate to a web page
driver.get('https://opensource-demo.orangehrmlive.com/')

try:
    # Find an element using a By strategy and locator (replace 'myElementId' with your element's ID)
    element = driver.find_element(By.NAME, 'username')

    # Retrieve the text of the element
    element_text = element.text

    # Print the text to the console
    print(f"Element Text: {element_text}")
except Exception as e:
    print(f"An error occurred: {e}")

# Close the WebDriver session when you're done
driver.quit()
