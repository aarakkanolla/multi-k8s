docker build -t aarakkanolla/multi-client:latest -t aarakkanolla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aarakkanolla/multi-server:latest -t aarakkanolla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aarakkanolla/multi-worker:latest -t aarakkanolla/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aarakkanolla/multi-client:latest
docker push aarakkanolla/multi-server:latest
docker push aarakkanolla/multi-worker:latest

docker push aarakkanolla/multi-client:$SHA
docker push aarakkanolla/multi-server:$SHA
docker push aarakkanolla/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aarakkanolla/multi-server:$SHA
kubectl set image deployments/client-deployment client=aarakkanolla/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aarakkanolla/multi-worker:$SHA
