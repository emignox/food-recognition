FROM python:3.9-slim

WORKDIR /app

# Installa solo le dipendenze essenziali
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libgomp1 \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copia e installa dipendenze
COPY requirements.txt .
COPY setup.py ./
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copia codice
COPY . .
RUN pip install -e .

# Cloud Run usa PORT environment variable
ENV PORT 8080
EXPOSE 8080
ENV PYTHONPATH=/app

CMD ["python", "app.py"]
