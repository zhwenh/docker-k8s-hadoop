printf "Deploying K8S cluster...\n"
printf "Start spark-master...\n"
kubectl create -f hdfs-spark-master-service.yaml
kubectl create -f hdfs-spark-master-controller.yaml

kubectl get pods
while [ $(kubectl get pods | grep spark-master | grep Running | wc -l) -le 0 ]
do
  kubectl get pods
  sleep 1
done

sleep 3

printf "\nStart spark-worker...\n"
kubectl create -f spark-worker-controller.yaml
kubectl get pods
while [ $(kubectl get pods | grep spark-worker | grep Pending | wc -l) -gt 0 ]
do
  kubectl get pods
  sleep 1
done

printf "\nStart spark-ui-proxy...\n"
kubectl create -f spark-ui-controller.yaml
kubectl create -f spark-ui-proxy-service.yaml

kubectl get pods
printf "\nCluster deployed!\n"