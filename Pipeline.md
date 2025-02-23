# Jenkins Pipeline:

```groovy
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sbhusal123/django-app:latest .'
            }
        }
        
        stage('Push Docker Image To Registry') {
            steps {
                // username and password secret to be set
                // credentialsId: dockerhub_credentials
                withCredentials(
                    [usernamePassword(
                        credentialsId: 'dockerhub_credentials', 
                        usernameVariable: 'DOCKERHUB_USERNAME', 
                        passwordVariable: 'DOCKERHUB_PASSWORD'
                    )]
                ) {
                    sh 'echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin'
                    sh 'docker push sbhusal123/django-app:latest'
                }
            }
        }

        stage('Rollout Deployment') {
            steps {
                
                // secret text credentials to be set
                withCredentials([
                    string(credentialsId: 'ssh_user', variable: 'SSH_USER'),
                    string(credentialsId: 'ssh_host', variable: 'SSH_HOST'),
                    string(credentialsId: 'git_repo_url', variable: 'REPO_URL')
                ]) {
                sshagent(['kube_ssh_key']) {
                        sshagent(['kube_ssh_key']) {
                            // note the indentation must be as below for EOF delimiter
                            sh """
        ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} <<EOF
if [ -d django-kubernetes-deployment ]; then
    cd django-kubernetes-deployment
    git pull
else
    git clone ${REPO_URL} django-kubernetes-deployment
    cd django-kubernetes-deployment
fi
make run
make rollout_deployment
EOF
                            """
                        }
                }

                }
            }
        }
    }
}

```

![Jenkins Credentials](./Jenkins%20Credentials.png)

In the very first step:

1. Builds a docker image and tags it.

2. Pushes docker image to registry.

> Note that this steps requires ``Username and Password`` credentials setup with docker username and token as password. Credentials id must be ``dockerhub_credentials``

3. In this step.

    **3.1.** Jenkins ssh into a kubernetes server. This requires a ``sshagent`` plugin and ``SSH Username with private key`` credential with credentials id ``kube_ssh_key``.


    **3.2.** Also requires a three ``Secret text`` Credentials with id: ``ssh_user`` ``ssh_host`` ``git_repo_url``

Then pipeline ssh's into the kubernetes server using ``kube_ssh_key, ssh_host, ssh_user`` credentials and clones the repo using ``git_repo_url`` credentials.


```bash
                // secret text credentials to be set
                withCredentials([
                    string(credentialsId: 'ssh_user', variable: 'SSH_USER'),
                    string(credentialsId: 'ssh_host', variable: 'SSH_HOST'),
                    string(credentialsId: 'git_repo_url', variable: 'REPO_URL')
                ]) {
                sshagent(['kube_ssh_key']) {
                        sshagent(['kube_ssh_key']) {
                            // note the indentation must be as below for EOF delimiter
                            sh """
        ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} <<EOF
if [ -d django-kubernetes-deployment ]; then
    cd django-kubernetes-deployment
    git pull
else
    git clone ${REPO_URL} django-kubernetes-deployment
    cd django-kubernetes-deployment
fi
make run
make rollout_deployment
EOF
                            """
                        }
                }

                }
```