pipeline {
    agent any
    stages {
        stage("Build") {
            environment {
                DB_HOST = credentials("laravel-host")
                DB_DATABASE = credentials("laravel-database")
                DB_USERNAME = credentials("laravel-user")
                DB_PASSWORD = credentials("laravel-password")
            }
            steps {
                sh 'php --version'
                sh 'composer install'
                sh 'composer --version'
                sh 'cp .env.example .env'
                sh 'php artisan key:generate'
                sh 'cp .env .env.testing'
            }
        }
        stage("Docker build") {
            steps {
                sh "docker build -t tjhirani/laravel-docker:latest ."
            }
        }
        stage("Docker") {
            environment {
                DOCKERHUB_CREDENTIALS = credentials('docker-hub')
            }
            steps {
                sh "docker login --username $DOCKERHUB_CREDENTIALS_USR --password-stdin "
                sh "docker push tjhirani/laravel-docker:latest"
            }
        }
    }
    post{
        always{
            sh 'sudo docker logout'
        }
    }
}
