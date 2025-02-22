pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sbhusal123/django-app .'
            }
        }
    }
}