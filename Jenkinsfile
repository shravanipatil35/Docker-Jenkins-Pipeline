pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shravanipatil30/helloworldpython'
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
    }

    stages {

        stage('Docker Build') {
            steps {
                sh """
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest .
                """
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds', 
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh """
                    echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                sh """
                docker run -d -p 5000:5000 ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }

    post {
        success {
            echo 'Build and Push Successful'
        }
        failure {
            echo 'Pipeline Failed'
        }
    }
}