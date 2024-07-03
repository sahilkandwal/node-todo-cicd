pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                script {
                    echo 'Pulling code from Git repository'
                    checkout scm
                }
            }
        }
        
        stage('Deploy to develop Server') {
            steps {
                script {
                    echo 'Deploying to develop server'
                    sshagent(['my-ssh-credentials']) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@52.66.238.98 << EOF
                            cd /home/ubuntu/test_project
                            sh tech.sh
                            EOF
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution completed'
        }
        success {
            echo 'Pipeline succeeded'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
