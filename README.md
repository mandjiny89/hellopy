# Introduction 
This repo provides a simple hello world application using Python app loaded into Docker container.
Using Minikube load the application with 2 pod cluster using a LoadBalancer service to access the app. 

# Current application versions used during build
Python version - 3.6
Docker version 20.10.8
minikube version: v1.25.2

# Run below command to create a container with Hello World python app.
```
docker build -t pyhello:v1 Dockerfile
```

# Login to the Docker registry to push the new build image into dockerhub, below command ask for username and credentials of your dockerhub. 
```
docker login
```

# Tag & push the image to Docker Registry
```
docker tag pyhello:v1 mandjiny89/pyhello:v1

docker push mandjiny89/pyhello:v1
```

# Make sure Minikube is setup and started
```
minikube start --driver=virtualbox
```

# Execute below commands to run deployment.yml and service.yml definition files to setup the pods and services. 
```
kubectl create -f deployment.yml

kubectl create -f service.yml
```

# Once above services created in minikube, execute below command to get the URL to access the application. 
```
minikube service --url pyhello
````