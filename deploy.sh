docker build -t greddy0407/multi-client:latest -t greddy0407/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t greddy0407/multi-server:latest -t greddy0407/multi-server:$SHA -f ./ server/Dockerfile ./server
docker build -t greddy0407/multi-worker:latest -t greddy0407/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push greddy0407/multi-client:latest
docker push greddy0407/multi-server:latest
docker push greddy0407/multi-worker:latest

docker push greddy0407/multi-client:$SHA
docker push greddy0407/multi-server:$SHA
docker push greddy0407/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=greddy0407/multi-server$SHA
kubectl set image deployments/client-deployment client=greddy0407/multi-client$SHA
kubectl set image deployments/worker-deployment worker=greddy0407/multi-worker$SHA
