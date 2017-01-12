printf "Shutdown cluster...\n"
kubectl delete -f hdfs-spark-master-controller.yaml 
kubectl delete -f spark-worker-controller.yaml 
kubectl delete -f hdfs-spark-master-service.yaml 
kubectl delete -f spark-ui-proxy-controller.yaml
kubectl delete -f spark-ui-proxy-service.yaml
kubectl delete -f zeppelin-controller.yaml
kubectl delete -f zeppelin-service.yaml
kubectl delete rc spark-driver

kubectl get pods
while [ $(kubectl get pods | grep -E 'spark-master|spark-worker|spark-driver' | grep Terminating | wc -l) -gt 0 ]
do
  kubectl get pods
  sleep 1
done

kubectl get pods
printf "\nFinished!!\n"