// Use a tag based on the current build number for versioning
def imageTag = "latest"

pipeline {
    // 💡 CHANGE 1: Use a simple agent to check out the code onto the executor's workspace
    agent any

    environment {
        // ... (environment variables remain the same)
    }

    stages {
        // The Build, Deploy, and Health Check stages will now run on the 'agent any' executor,
        // which has the Git-checked-out files (Jenkinsfile, healthcheck.sh, etc.)

        // --- 1. Build Stage ---
        stage('Build Application') {
            // ... (steps remain the same)
        }

        // --- 2. Unit Test Stage ---
        stage('Unit Tests') {
            // This stage still runs in its isolated python:3.12-slim container
            // and the files (like requirements.txt) are mounted automatically by Jenkins.
            agent {
                docker {
                    image 'python:3.12-slim'
                }
            }
            // ... (steps remain the same)
        }

        // --- 3. Package (Docker) Stage ---
        stage('Package Docker Image') {
            // ... (steps remain the same)
        }

        // --- 4. Deploy Stage ---
        stage('Deploy with Docker Compose') {
            // ... (steps remain the same)
        }

        // --- 5. Health Check Stage ---
        stage('Verify Health Status') {
            steps {
                script {
                    echo "Running health check script..."
                    // 💡 FIX 2: Ensure script is executable before running
                    sh "chmod +x ./healthcheck.sh"
                    sh "./healthcheck.sh" // This now runs on the executor with the files.
                }
            }
        }
    }

    // ... (post block remains the same)
}
