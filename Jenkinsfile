pipeline {
    agent {
        label 'app-machine'  // Application machine is the Jenkins worker
    }

    environment {
        IMAGE_NAME = 'voteapp'
        IMAGE_TAG = 'latest'
        DOCKERHUB_USERNAME = 'suru98'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/dockersamples/example-voting-app.git' // Replace with your repo
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker stop voteapp || true
                    docker rm voteapp || true
                    docker run -d --name voteapp -p 80:80 $DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline execution finished"
        }
    }
}
