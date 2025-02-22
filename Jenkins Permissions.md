# Managing Permissions For Jenkins

[Jenkinsfile](./Jenkinsfile) requires access to docker and kubectl commands.

- check if `jenkins` user has access to docker.

```sh
# switch to jenkins user
sudo su jenkins -

# check runing containers
docker ps
# this returns permission denied

# check runing pods
kubectl get pods
# permission issue
```


To fix issue with docker:

```sh
# add user jenkins to docker group
sudo usermod -aG docker jenkins

# restart jenkins
sudo systemctl restart jenkins
```

To fix issue with kubectl:

```sh
# check kubectl path
which kubectl
# /usr/local/bin/kubectl

ls -ltra /usr/local/bin/
# -rwxrwxr-x  1 surya surya  56381592 Dec 20 18:51 kubectl

# since other user dont have execute access
sudo chmod o+x /usr/local/bin/kubectl
```

Now, test the work with:

```sh
# switch to jenkins user
sudo su jenkins -

# check runing containers
docker ps

# check runing pods
kubectl get pods
```