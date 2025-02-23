# Managing Permissions For Jenkins

[Jenkinsfile](./Jenkinsfile) requires access to docker and kubectl commands.

- check if `jenkins` user has access to docker.

```sh
# switch to jenkins user
sudo su jenkins -

# check runing containers
docker ps
# this returns permission denied
```


To fix issue with docker:

```sh
# add user jenkins to docker group
sudo usermod -aG docker jenkins

# restart jenkins
sudo systemctl restart jenkins
```
