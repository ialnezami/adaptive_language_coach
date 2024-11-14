# Base image for Python
FROM python:3.9-slim

# Set working directory in the container
WORKDIR /app

# Copy the requirements.txt file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app files into the container
COPY . .

# Expose Flask app port
EXPOSE 5000

# Command to run Flask
CMD ["flask", "run", "--host=0.0.0.0"]



# docker build -t my-flask-app .