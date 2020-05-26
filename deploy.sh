git clean -f
docker build -t smurahy/docker-fib-client:latest -t smurahy/docker-fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t smurahy/docker-fib-server:latest -t smurahy/docker-fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t smurahy/docker-fib-worker:latest -t smurahy/docker-fib-worker:$SHA -f ./worker/Dockerfile ./worker
docker push smurahy/docker-fib-client:latest
docker push smurahy/docker-fib-server:latest
docker push smurahy/docker-fib-worker:latest

docker push smurahy/docker-fib-client:$SHA
docker push smurahy/docker-fib-server:$SHA
docker push smurahy/docker-fib-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=smurahy/docker-fib-server:$SHA
kubectl set image deployment/client-deployment client=smurahy/docker-fib-client:$SHA
kubectl set image deployment/worker-deployment worker=smurahy/docker-fib-worker:$SHA
