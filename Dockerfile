FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 


RUN apt-get update && apt-get install -y \
    libpq-dev gcc build-essential libpq-dev python3-dev \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt


WORKDIR /app
COPY ./app /app

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
