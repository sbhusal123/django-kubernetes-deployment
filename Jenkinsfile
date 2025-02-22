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

        stage('Deploy To Kubernetes') {
            steps {
                    withCredentials([string(credentialsId: 'kubernetes-secret', variable: 'K8S_TOKEN')]) {
                        sh """
                            kubectl --token=$K8S_TOKEN get pods
                        """
                    }
            }
        }

        stage('Rollout Deployment') {
            steps {
                sh 'kubectl rollout restart deployment/django -n dj_kubernetes'
            }
        }
    }
}
