pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                sh 'php --version'
                sh 'cp .env.example .env'
                sh 'docker'
            }
        }
        stage("Docker build") {
            steps {
                sh "docker build -t tjhirani/laravel-docker:latest ."
            }
        }
        stage("Docker") {
            environment {
                DOCKERHUB_CREDENTIALS=credentials('docker-hub')
            }
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push tjhirani/laravel-docker:latest"
            }
        }
    }
}
