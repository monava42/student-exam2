FROM python:3-alpine

#test

RUN pip install virtualenv
#copy app files in container
COPY . /app
WORKDIR /app
#installing app
CMD ["python -m venv venv"]
ENV FLASK_APP /app/js_example
ENV PATH=/app/venv/bin:$PATH
RUN pip install -e .
#running app
CMD flask run --host=0.0.0.0
