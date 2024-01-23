pipeline {
    agent any
    stages {
        stage("build image") {
            steps {
               script {
                sh 'docker build -t sample-nodejs-app-1:5.0 .'
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 246167819468.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker tag sample-nodejs-app-1:5.0 246167819468.dkr.ecr.us-east-1.amazonaws.com/sample-nodejs-app-1:5.0'
                sh 'docker push 246167819468.dkr.ecr.us-east-1.amazonaws.com/sample-nodejs-app-1:5.0'
               }
            }
        }
        stage("Provision server") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }
        stage("Deploy application") {
            steps {
                script {
                    dir('ansible') {
                        sh "ansible-playbook deploy-app.yaml"
                    }
                }
            }
        }
    }
}
