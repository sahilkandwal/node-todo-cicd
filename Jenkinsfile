pipeline {
    agent any
    
    stages {
        stage('Pull Code') {
            steps {
                checkout scm
            }
        }
        
        stage('Deploy to develop Server') {
            steps {
                script {
                    sshagent(['52.66.238.98']) {
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.66.238.98 "cd /home/test_project && sh tech.sh"'
                    }
                }
            }
        }
    }
}
