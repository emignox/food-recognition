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
COPY requirements.txt setup.py ./
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copia codice
COPY . .
RUN pip install -e .

EXPOSE 5000
ENV PYTHONPATH=/app

CMD ["python", "app.py"]
