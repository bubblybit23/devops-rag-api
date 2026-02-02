FROM python:3.11-slim

WORKDIR /app

# 1. Install system dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 2. Copy the requirements file first (Best Practice for Caching)
COPY requirements.txt .

# 3. Install the python dependencies and if will be rebuild if there are no changes in the requirements it wil skip
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy the rest of your application code
COPY app.py embed.py k8s.txt ./

# 5. Run your embedding script
RUN python embed.py

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]