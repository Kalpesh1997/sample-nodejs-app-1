pipeline {
    agent any
    stages {
        stage("build image") {
            steps {
               script {
                    withCredentials([UsernamePassword(credentialsId: 'ecr', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t sample-nodejs-app-1:2.0 .'
                        sh 'echo $PASS | docker login --username $USER --password-stdin 246167819468.dkr.ecr.us-east-1.amazonaws.com'
                        sh 'docker tag sample-nodejs-app-1:2.0 246167819468.dkr.ecr.us-east-1.amazonaws.com/sample-nodejs-app-1:2.0'
                        sh 'docker push 246167819468.dkr.ecr.us-east-1.amazonaws.com/sample-nodejs-app-1:2.0'
                    }
               }
            }
        }
        stage("deploy image") {
            steps {
                echo 'Hello World'
            }
        }
    }
}