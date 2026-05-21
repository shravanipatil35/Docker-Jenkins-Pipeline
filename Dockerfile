FROM python:3.10-slim    
WORKDIR /app
COPY helloworld.py .
CMD ["python", "helloworld.py"] 