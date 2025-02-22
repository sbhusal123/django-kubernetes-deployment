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
                withCredentials([usernamePassword(credentials,
                    id: 'dockerhub-credentials',
                    usernameVariable: 'DOCKERHUB_USERNAME',
                    passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'docker push sbhusal123/django-app:latest'
                }
            }
        }

        stage('Deploy To Kubernetes') {
            steps {
                sh 'make run'
            }
        }

        stage('Rollout Deployment'){
            steps {
                sh 'make rollout_deployment'
            }
        }
    }
}