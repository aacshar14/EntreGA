FROM python:3.11

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire app directory
COPY app/ ./app/

# Create an __init__.py file if it doesn't exist
RUN touch app/__init__.py

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
