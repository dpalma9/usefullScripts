FROM python:3.8

#COPY requirements.txt /app
#COPY main.py /app
COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

# For develop
RUN apt update && apt install -y curl vim

CMD ["/bin/sleep", "infinity"]
#ENTRYPOINT ["uvicorn --host 0.0.0.0 main:app"]