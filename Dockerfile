FROM python:3.6
ADD pyhello.py requirements.txt  /
WORKDIR /
RUN pip install -r requirements.txt
EXPOSE 8080
CMD [ "python", "./pyhello.py"]
