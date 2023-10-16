from selenium import webdriver
import csv
import pytz
from datetime import datetime
import boto3
from botocore.exceptions import NoCredentialsError
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# Create a timestamp in the format: YYYYMMDD_HHMMSS
timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')

# Initialize the AWS CloudWatch Logs client
cloudwatch_logs_client = boto3.client('logs', region_name='ap-south-1')

# Define the CloudWatch Log Group and Stream names
log_group_name = 'selenium_grid'
log_stream_name = 'Selenium_Log_Stream'

# Initialize the AWS S3 client
s3_client = boto3.client('s3', region_name='ap-south-1')

# Specify the S3 bucket and object key
s3_bucket = 'selenium-8527387747'
s3_object_key = f"screenshots/Selenium_{timestamp}.png"

# Initialize the AWS SES client
ses_client = boto3.client('ses', region_name='ap-south-1')

# Sender and recipient email addresses
sender_email = 'assistantprofessor689@gmail.com'
recipient_email = 'kumar.manoj8527387747@gmail.com'

# Email subject and body
subject = 'Selenium Testing Logs'
body = 'Please find the log attached'

# Create a MIME Multipart message
msg = MIMEMultipart()
msg['Subject'] = subject
msg['From'] = sender_email
msg['To'] = recipient_email
msg.attach(MIMEText(body, 'plain'))

# Create a WebDriver instance
driver = webdriver.Chrome()
print(type(driver))

# Navigate to a web page
driver.get("http://www.instagram.com")
myPageTitle = driver.title
print(myPageTitle)
assert "Instagram" in myPageTitle

# Get browser logs
browser_logs = driver.get_log("browser")

# Save logs to a CSV file with timestamp
csv_file_path = f"browser_logs_{timestamp}.csv"
with open(csv_file_path, mode='w', newline='') as csv_file:
    fieldnames = ['level', 'message', 'source', 'timestamp (CDT)']
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
    writer.writeheader()

    # Convert timestamp to CDT timezone
    cdt_timezone = pytz.timezone('America/Chicago')
    for log_entry in browser_logs:
        timestamp_utc = datetime.utcfromtimestamp(log_entry['timestamp'] / 1000)
        timestamp_cdt = timestamp_utc.replace(tzinfo=pytz.utc).astimezone(cdt_timezone)
        log_data = {
            'level': log_entry['level'],
            'message': log_entry['message'],
            'source': log_entry['source'],
            'timestamp (CDT)': timestamp_cdt.strftime('%Y-%m-%d %H:%M:%S %Z%z')
        }
        writer.writerow(log_data)

print(f"Browser logs saved to {csv_file_path}")

# Save a screenshot
screenshot_file_path = f"Selenium_{timestamp}.png"
driver.get_screenshot_as_file(screenshot_file_path)

# Upload the screenshot to S3
with open(screenshot_file_path, 'rb') as screenshot_file:
    s3_client.upload_fileobj(screenshot_file, s3_bucket, s3_object_key)

print(f"Screenshot saved to S3: s3://{s3_bucket}/{s3_object_key}")

# Send the email with attachments
with open(csv_file_path, 'rb') as logs_file:
    logs_attach = MIMEApplication(logs_file.read(), _subtype="csv")
    logs_attach.add_header('Content-Disposition', 'attachment', filename=csv_file_path)
    msg.attach(logs_attach)

with open(screenshot_file_path, 'rb') as screenshot_file:
    screenshot_attach = MIMEApplication(screenshot_file.read(), _subtype="png")
    screenshot_attach.add_header('Content-Disposition', 'attachment', filename=screenshot_file_path)
    msg.attach(screenshot_attach)

try:
    response = ses_client.send_raw_email(RawMessage={'Data': msg.as_string()})
    print(f"Email sent successfully with Message ID: {response['MessageId']}")
except NoCredentialsError:
    print("AWS credentials not found. Unable to send email.")

# Quit the driver to clean up resources
driver.quit()
