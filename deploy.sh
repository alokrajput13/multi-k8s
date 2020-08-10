docker build -t alokrajput13/multi-client:latest -t alokrajput13/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alokrajput13/multi-server:latest -t alokrajput13/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alokrajput13/multi-worker:latest -t alokrajput13/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alokrajput13/multi-client:latest
docker push alokrajput13/multi-server:latest
docker push alokrajput13/multi-worker:latest

docker push alokrajput13/multi-client:latest:$SHA
docker push alokrajput13/multi-server:latest:$SHA
docker push alokrajput13/multi-worker:latest:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alokrajput13/multi-server:$SHA
kubectl set image deployments/client-deployment client=alokrajput13/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alokrajput13/multi-worker:$SHA