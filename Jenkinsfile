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

                withCredentials([
                    string(credentialsId: 'kube_ssh_key', variable: 'SSH_KEY_CONTENT'),
                    string(credentialsId: 'kube_username', variable: 'SSH_USER')
                ]) {
                    sh """
                        # Write the SSH key content to a temporary file
                        echo "$SSH_KEY_CONTENT" > /tmp/jenkins_ssh_key

                        # Execute SSH command
                        ssh -i /tmp/jenkins_ssh_key -o StrictHostKeyChecking=no ${SSH_USER}@192.168.1.137 'kubectl rollout restart deployment/django -n dj_kubernetes'

                    """
                }

            }
        }   
    }
}
