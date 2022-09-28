sudo systemctl disable --now firewalld
# echo "Running yum update"
# sudo yum update -y
# echo "Install net-tools"
# sudo yum install -y net-tools
echo "Copy ssh key"
mkdir -p /home/vagrant/.ssh
cat /tmp/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
echo "Install k3s"
sudo curl -sfL https://get.k3s.io | sh -s - server \
	--write-kubeconfig-mode 644 \
	--node-ip 192.168.42.110 \
	--flannel-iface=eth1 \
	--tls-san 192.168.42.110


# echo "Installing kubectl"
# cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
# [kubernetes]
# name=Kubernetes
# baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
# enabled=1
# gpgcheck=1
# gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
# EOF
# sudo yum install -y kubectl
kubectl apply -f .
