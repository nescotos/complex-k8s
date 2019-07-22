#Building Images
docker build -t nestor94/multi-client:latest -t nestor94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nestor94/multi-server:latest -t nestor94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nestor94/multi-worker:latest -t nestor94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#Pushing Images to Docker Hub
docker push nestor94/multi-client:latest
docker push nestor94/multi-client:$SHA
docker push nestor94/multi-server:latest
docker push nestor94/multi-server:$SHA
docker push nestor94/multi-worker:latest
docker push nestor94/multi-worker:$SHA

#Apply Kubernetes Configuration
kubectl apply -f k8s

#Updating tag on Cluster
kubectl set image deployments/server-deployment server=nestor94/multi-server:$SHA
kubectl set image deployments/client-deployment client=nestor94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nestor94/multi-worker:$SHA