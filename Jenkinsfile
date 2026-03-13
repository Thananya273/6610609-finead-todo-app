pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'thananya273'
        IMAGE_NAME = 'finead-todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-credentials'
        DOCKER_PATH = '/usr/local/bin/docker'
    }

    stages {
        stage('Containerise') {
            steps {
                echo 'Building Docker image with Frontend and Backend...'
                // This line fixes the "docker-credential-desktop" error
                sh "mkdir -p .docker && echo '{\"credsStore\":\"\"}' > .docker/config.json"
                
                sh "export DOCKER_CONFIG=\$(pwd)/.docker && ${DOCKER_PATH} build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push') {
            steps {
                echo 'Pushing to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "export DOCKER_CONFIG=\$(pwd)/.docker && echo \$DOCKER_PASS | ${DOCKER_PATH} login -u \$DOCKER_USER --password-stdin"
                    sh "export DOCKER_CONFIG=\$(pwd)/.docker && ${DOCKER_PATH} push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}