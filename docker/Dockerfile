FROM python:3.6

RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential

COPY target/dist/hello_world_flask* /app
WORKDIR /app
RUN pip install /app

EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["/app/api/run.py"]

