pipeline {
    agent any
    environment {
        IMAGE_NAME = 'shravanipatil30/helloworldpython'
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest .'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                    sh 'docker push ${IMAGE_NAME}:latest'
                }
            }
        }
        stage('Container Run') {
            steps {
                sh 'docker run -d ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
    }
    post {
        success {
            echo 'Docker image built and pushed successfully!'
        }
        failure {
            echo 'Docker build or push failed.'
        }
    }
}

