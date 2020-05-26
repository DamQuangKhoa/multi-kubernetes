docker build -t 0971493296/multi-client:latest -t 0971493296/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 0971493296/multi-server:latest -t 0971493296/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 0971493296/multi-worker:latest -t 0971493296/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push 0971493296/multi-client:latest
docker push 0971493296/multi-server:latest
docker push 0971493296/multi-worker:latest

docker push 0971493296/multi-client:$SHA
docker push 0971493296/multi-server:$SHA
docker push 0971493296/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=0971493296/multi-server:$SHA
kubectl set image deployments/client-deployment server=0971493296/multi-client:$SHA
kubectl set image deployments/worker-deployment server=0971493296/multi-worker:$SHA