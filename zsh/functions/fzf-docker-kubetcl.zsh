# Sh on a container
dsh() {
  docker ps | awk 'NR>1' | fzf | awk '{print $1}' | xargs -o -J {} docker exec -it {} sh
}
# Remove container
drmc() {
  docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker rm
}
# Restart container
drsc() {
  docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker restart
}
# Stop container
dstopc() {
  docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker stop
}

# Sh on a kubernetes container
ksh() {
  kubectl get pods | awk 'NR>1' | fzf | awk '{print $1}' | xargs -o -J {} kubectl exec -it {} sh
}
# Delete a pod
kdel() {
  kubectl get pods | awk 'NR>1' | fzf | awk '{print $1}' | xargs kubectl delete po
}
# Port forward read
kpfdb() {
  kubectl get pods | grep "pgsql-read*" |  awk '{print $1}' | xargs -o -J {} kubectl port-forward {} 5433:5432 &
  kubectl get pods | grep "pgsql-eventstore*" |  awk '{print $1}' | xargs -o -J {} kubectl port-forward {} 5434:5432
}
# Port forward microservice
kpfms() {
  kubectl get pods | awk 'NR>1' | fzf | awk '{print $1}' | xargs -o -J {} kubectl port-forward {} 54334:50051
}
# Get last 25 logs for a deployments (associated pods)
klog() {
  kubectl get deployments | awk 'NR>1' | fzf | awk '{print $1}' | xargs -o -I {} stern {} -c {} -o=raw | jq '.'
}
# Get last 25 logs for api gtw
kloggtw() {
  kubectl get deployments | grep "api-gateway*"| awk '{print $1}' | xargs -o -I {} stern {} -c {} -o=raw | jq '.'
}
# Get last 25 logs for ms user
kloguser() {
  kubectl get deployments | grep "microservice-user*" | awk '{print $1}' | xargs -o -I {} stern {} -c {} -o=raw | jq '.'
}
