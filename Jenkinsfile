pipeline {
    agent any
    stages {
        stage("build image") {
            steps {
               script {
                    withCredentials([usernamePassword(credentialsId: 'ecr', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t sample-nodejs-app-1:2.0 .'
                        sh 'echo $PASS | docker login --username $USER --password-stdin 246167819468.dkr.ecr.us-east-1.amazonaws.com'
                        sh 'docker tag sample-nodejs-app-1:2.0 246167819468.dkr.ecr.us-east-1.amazonaws.com/sample-nodejs-app-1:2.0'
                        sh 'docker push 246167819468.dkr.ecr.us-east-1.amazonaws.com/sample-nodejs-app-1:2.0'
                    }
               }
            }
        }
        stage("Provision server") {
            environment {
                AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }
    }
}
