pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                retry(3) {
                    git branch: 'release', url: 'https://github.com/chamithchathurya/springboot-cicd'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t chamithchathurya/allianz-app:%BUILD_NUMBER% .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([file(credentialsId: '', variable: 'springboot-cicd-pass'), string(credentialsId: 'springboot-docker-pass', variable: 'springboot-cicd-password')]) {
                    script {
                        bat "docker login -u chamithchathurya -p ${springboot-cicd-password}"
                    }
                }
            }
        }
        stage('Push Image') {
            steps {
                bat 'docker push chamithchathurya/allianz-app:%BUILD_NUMBER%'
            }
        }
    }
    post {
        always {
            bat 'docker logout'
        }
    }
}
