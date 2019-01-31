pipeline {
    agent {
        node { label 'agent1' }
    }

    stages {
       
        stage('Setup VEnv'){
            steps {
                sh '''echo 'Installing app...'
                        which python
                        whoami
                        pwd
                        python3.5 -m venv venv
                        . venv/bin/activate
                        pwd
                        pip install -e .
                    '''
            }
        } 
        stage('Python test'){
            steps {
                sh '''echo 'Testing app...'
                      pip install -e '.[test]'
                      coverage run -m pytest
                      coverage report
                    '''
            }
        }
        stage('Docker image build'){
            steps {
                script {
                    def customImage = docker.build("agent:${env.BUILD_ID}")
                    customImage.push()
                }
//                bash '''echo 'Building...'
//                      sudo docker build -t agent\:\${BUILD_TAG}.
//                      sudo docker images | grep agent:${BUILD_TAG}
//                    '''
            }
        }
        stage('Docker hub authentication'){
            environment {
                LOG = credentials('dockerhub')
            }
            steps {
                sh '''echo 'Authenticating...'
                      sudo docker login -u ${LOG_USR} -p ${LOG_PSW}'
                    '''
            }
        }
        stage('Push docker image'){
            steps {
                sh '''echo 'Building...'
                      sudo docker tag agent:${BUILD_TAG} ${LOG_USR}{/}monavaft:agent:${BUILD_TAG}
                      sudo docker push ${LOG_USR}/monavaft
                    '''
            }
        }
    }
    post {
        success {
            echo 'this will run only if succesfull'
        }
        failure {
            echo 'whis will run only if failed'
        }
    }
}
