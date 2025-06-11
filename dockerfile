FROM python:3.9
ADD .. /app
WORKDIR /app

 Run pip install -r requirements.txt
  Expose 80
  CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
