FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE=rapid.settings

ENV SECRET_KEY=docker-build-secret-key-not-for-production

ENV SOCIAL_AUTH_GOOGLE_OAUTH2_KEY=dummy-google-oauth-key
ENV SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET=dummy-google-oauth-secret

ENV STRIPE_PUBLIC_KEY=dummy-stripe-public-key
ENV STRIPE_SECRET_KEY=dummy-stripe-secret-key

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY .env /app/.env
COPY . /app/

RUN mkdir -p /app/media
RUN mkdir -p /app/staticfiles

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "rapid.wsgi:application"]
