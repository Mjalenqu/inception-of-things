sudo systemctl disable --now firewalld
# echo "Running yum update"
# sudo yum update -y
# echo "Install net-tools"
# sudo yum install -y net-tools
echo "Copy ssh key"
mkdir -p /home/vagrant/.ssh
cat /tmp/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

echo "Installing kubectl"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum install -y kubectl

echo "Remove old docker version"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

echo "Install Docker dependencie"
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

echo "Add docker repository to yum"
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "Install Docker"
sudo yum install -y docker-ce

echo "Start Docker"
sudo systemctl start docker

echo "Add vagrant user to docker group"
sudo usermod -aG docker vagrant
# echo "Enable Docker"
# sudo systemctl enable docker

echo "Install K3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash




