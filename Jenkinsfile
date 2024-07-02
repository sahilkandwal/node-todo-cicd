pipeline {
    agent { label "dev-server"}
    
    stages {
        
        stage("code"){
            steps{
                git url: "https://github.com/pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'node-app-todo'
        CONTAINER_NAME = 'node-app-container'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/sahilkandwal/node-todo-cicd.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    sh """
                    if [ \$(docker ps -aq -f name=${CONTAINER_NAME}) ]; then
                        docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME}
                    fi
                    """
                    
                    // Run the new container
                    dockerImage.run("-d --name ${CONTAINER_NAME} -p 8000:8000")
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}

            }
        }
        stage("build and test"){
            steps{
                sh "docker build -t node-app-test-new ."
                echo 'code build bhi ho gaya'
            }
        }
        stage("scan image"){
            steps{
                echo 'image scanning ho gayi'
            }
        }
        stage("push"){
            steps{
                withCredentials([usernamePassword(credentialsId:"dockerHub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker tag node-app-test-new:latest ${env.dockerHubUser}/node-app-test-new:latest"
                sh "docker push ${env.dockerHubUser}/node-app-test-new:latest"
                echo 'image push ho gaya'
                }
            }
        }
        stage("deploy"){
            steps{
                sh "docker-compose down && docker-compose up -d"
                echo 'deployment ho gayi'
            }
        }
    }
}


pipeline {
    agent any

    environment {
        GIT_REPO_URL = 'https://github.com/sahilkandwal/node-todo-cicd.git'
        GIT_BRANCH = 'master'
        SSH_CREDENTIALS_ID = 'ec2-ssh-key' // The ID of your SSH credentials in Jenkins
        EC2_IP = 'your-ec2-ip' // Replace with your EC2 instance IP
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "${env.GIT_BRANCH}", url: "${env.GIT_REPO_URL}", credentials: 'techh'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Building project..."'
                // Add your build commands here, e.g., npm install
                sh 'npm install'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    sh '''
                        [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
                        ssh-keyscan -H ${EC2_IP} >> ~/.ssh/known_hosts
                        scp -o StrictHostKeyChecking=no -r * ubuntu@${EC2_IP}:/home/ubuntu/deploy/
                        ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} 'bash -s' < /home/ubuntu/deploy/deploy_script.sh
                    '''
                }
            }
        }
    }
}

