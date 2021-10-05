# Task MINIKUBE

Write a simple hello world application in any one of these languages: Python, Ruby, Go. Build the application within a Docker container and then load balance the application within Minikube. You are not required to automate the installation of Minikube on the host machine.
The above Minikube task involves mutiple steps that needs to be achived which are listed below in details. 

For source code please refer: https://github.com/singuvenkatesh/Task-EqualExpert

**1. simple hello world application using python language**

**Python version - 3.X

**helloworld.py**
```
from flask import Flask, request
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class Greeting (Resource):
    def get(self):
        return 'Hello World!'

api.add_resource(Greeting, '/') # Route_1

if __name__ == '__main__':
    app.run('0.0.0.0','8080')

```
**2. Create a Docker file**

**Dockerfile**

```
FROM python:3
ADD helloworld.py /
RUN pip install flask
RUN pip install flask_restful
EXPOSE 8080
CMD [ "python", "./helloworld.py"]

```

**3. Build the application**
```
docker build -t helloworld:v1 Dockerfile

```

**4. Login to the Docker Registry**
```
docker login hub.docker.com -u username -p password

```

**5. Tag & push the image to Docker Registry**

```
docker tag helloworld:v1 hub.docker.com/deployanywhere/helloworld:v1

docker push hub.docker.com/deployanywhere/helloworld:v1

```

**6. Load the application within minikube**

Created two files deployment.yml and service.yml

**deployment.yml**

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pythonapp
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
  selector:
    matchLabels:
      app: pythonapp
  template:
    metadata:
      labels:
        app: pythonapp
    spec:
      containers:
      - image: hub.docker.com/deployanywhere/helloworld:v1
        name: pythonapp
        ports:
        - containerPort: 8080
	
```
		
**service.yml**

```

kind: Service
apiVersion: v1
metadata:
  name: pythonapp
spec:
  selector:
    app: pythonapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
    nodePort: 30000
  type: LoadBalancer
  
  ```

**Next steps to create deployment and service definition files**
```

kubectl create -f deployment.yml

kubectl create -f service.yml

```
**Advantages of this soultion is easy to scale and maintain. This soultion is always highly avaiable as we have provided the load balancer as a service. We have used 3 relications to ensure that POD  are available at all the time**
