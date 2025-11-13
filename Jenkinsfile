// Use a tag based on the current build number for versioning
def imageTag = "latest"

pipeline {
    agent {
        dockerContainer {
            image 'docker:dind'
            args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
        }
    }

    environment {
        // Use a consistent service name
        SERVICE_NAME = 'cicd-demo-app'
        IMAGE_NAME = "${SERVICE_NAME}"
    }

    stages {
        // --- 1. Build Stage ---
        stage('Build Application') {
            steps {
                script {
                    imageTag = "${env.BUILD_NUMBER}"
                    echo "Building application for version: ${imageTag}"
                    sh 'echo "Source code build simulated successfully."'
                }
            }
        }

        // --- 2. Unit Test Stage ---
        stage('Unit Tests') {
            steps {
                sh 'echo "Running mock unit tests..."'
                sh '''
                    # A true unit test would use a framework like pytest or unittest
                    TEST_RESULT=$(python -c "from app.app import add_two_numbers; print(add_two_numbers(5, 7))")
                    if [ "$TEST_RESULT" -ne "12" ]; then
                        echo "Mock Test Failed!"
                        exit 1
                    fi
                    echo "Mock Unit Tests Passed. Result: $TEST_RESULT"
                '''
            }
        }

        // --- 3. Package (Docker) Stage ---
        stage('Package Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${IMAGE_NAME}:${imageTag}"
                    // Build the Docker image using the Dockerfile
                    docker.build("${IMAGE_NAME}:${imageTag}", "-f Dockerfile .")
                    echo "Docker image built and tagged successfully."
                }
            }
        }

        // --- 4. Deploy Stage ---
        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Stop and remove any previous running container
                    sh "docker-compose down || true"

                    echo "Deploying container with Docker Compose and image tag: ${imageTag}"
                    // Deploy using docker-compose, passing the image tag as an environment variable
                    sh "TAG=${imageTag} docker-compose up -d"

                    echo "Deployment initiated."
                }
            }
        }

        // --- 5. Health Check Stage ---
        stage('Verify Health Status') {
            steps {
                script {
                    echo "Running health check script..."

                    sh "./healthcheck.sh"
                }
            }
        }
    }

    // --- Post-Build Cleanup ---
    post {
        always {
            echo 'Cleaning up deployment...'
            sh 'docker-compose down || true'
        }
    }
}
