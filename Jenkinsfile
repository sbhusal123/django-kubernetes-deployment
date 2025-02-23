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
                    string(credentialsId: 'ssh_user', variable: 'SSH_USER'),
                    string(credentialsId: 'ssh_host', variable: 'SSH_HOST'),
                    string(credentialsId: 'git_repo_url', variable: 'REPO_URL')
                ]) {
                    sshagent(['kube_ssh_key']) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} << 'EOF'
                             'kubectl rollout restart deployment/django -n dj_kubernetes'
                             git clone ${REPO_URL}
                             ls -ltra  
                            EOF
                        """
                    }
                }
            }
        }
    }
}
