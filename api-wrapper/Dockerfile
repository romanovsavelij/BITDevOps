FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install curl
COPY api-wrapper/main.py .
EXPOSE 8080
CMD ["python", "main.py"]