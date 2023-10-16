from selenium import webdriver
from webdriver_manager import ChromDriverManager

driver=webdriver.Chrome(ChromDriverManager().install())
driver.get()
driver.quit()