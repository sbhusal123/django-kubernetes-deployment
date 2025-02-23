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
                    def user = "${DOCKERHUB_USERNAME}"
                    def pass = "${DOCKER_PASSWORD}"
                    sh """
                        echo ${DOCKERHUB_USERNAME} | docker login -u ${DOCKER_PASSWORD} --password-stdin
                    """
                    sh """
                        docker push sbhusal123/django-app:latest
                    """
                }
            }
        }

        stage('Rollout Deployment') {
            steps {

                withCredentials([
                        usernamePassword(
                                credentialsId: 'kube-server-cred', 
                                usernameVariable: 'USER', 
                                passwordVariable: 'PASS'
                )]) {
                    // prevents secret exposing
                    def user = "${USER}"
                    def pass = "${PASS}"
                    sh """
                        sshpass -p "${PASS}" ssh -o StrictHostKeyChecking=no ${USER}@192.168.1.137 'kubectl rollout restart deployment/django -n dj_kubernetes'
                    """
                }
            }
        }
    }
}
