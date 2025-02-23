pipeline {
    agent any

    stages {
        // stage('Build Docker Image') {
        //     steps {
        //         sh 'docker build -t sbhusal123/django-app:latest .'
        //     }
        // }
        
        // stage('Push Docker Image To Registry') {
        //     steps {
        //         // username and password secret to be set
        //         // credentialsId: dockerhub_credentials
        //         withCredentials(
        //             [usernamePassword(
        //                 credentialsId: 'dockerhub_credentials', 
        //                 usernameVariable: 'DOCKERHUB_USERNAME', 
        //                 passwordVariable: 'DOCKERHUB_PASSWORD'
        //             )]
        //         ) {
        //             sh 'echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin'
        //             sh 'docker push sbhusal123/django-app:latest'
        //         }
        //     }
        // }

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
// EOF delimiter must be at the beginning of the line
EOF
                            """
                        }
                }

                }
            }
        }
    }
}
