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
                sshagent(['kube_ssh_key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no surya@192.168.1.137 'kubectl rollout restart deployment/django -n dj_kubernetes'
                    """
                }
            }
        }   
    }
}
