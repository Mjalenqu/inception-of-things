echo "Create cluster"
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer

echo "Get cluster info"
kubectl cluster-info

echo "create namespaces"
kubectl create namespace argocd
kubectl create namespace dev

echo "get manifest to install argocd"
curl https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/install.yaml > install-argo.yaml

echo "Install ArgoCD in namespace argocd"
kubectl apply -n argocd -f install-argo.yaml

#Set argocd server as loadbalancer to access to UI on External ip described in 'kubectl get all -n argocd'
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

echo "Get acrgocd UI password in clear text"
echo "--------admin--------"
kubectl -n argocd get secret argocd-inital-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo "---------------------"

kubectl apply -f -n argocd will-app.yaml

