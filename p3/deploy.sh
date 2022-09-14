echo "Create cluster"
k3d cluster create my-cluster

echo "Get cluster info"
kubectl cluster-info

echo "create namespaces"
kubectl create namespace argocd
kubectl create namespace dev

echo "get manifest to install argocd"
curl https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/namespace-install.yaml > /home/vagrant/install-argo.yaml
sleep 5

echo "Install ArgoCD in namespace argocd"
kubectl apply -n argocd -f /home/vagrant/install-argo.yaml