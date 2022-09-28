# sudo systemctl disable --now firewalld
# # echo "Running yum update"
# # sudo yum update -y
# # echo "Install net-tools"
# # sudo yum install -y net-tools
# echo "Copy ssh key"
# mkdir -p /home/vagrant/.ssh
# cat /tmp/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

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

echo "Remove old docker version"
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo service docker start

# echo "Install Docker dependencie"
# sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# echo "Add docker repository to yum"
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# echo "Install Docker"
# sudo yum install -y docker-ce

# echo "Start Docker"
# sudo systemctl start docker

echo "Add vagrant user to docker group"
sudo usermod -aG docker vagrant
# echo "Enable Docker"
# sudo systemctl enable docker

echo "Install K3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

sleep 5


