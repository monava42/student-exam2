pipeline {
    environment {
       LOG = credentials('dockerhub') 
    }
    agent {
        node { label 'agent1' }
    }
    stages {
        stage('Python test'){
            steps {
                sh '''echo 'Testing app...'
                      python3.5 -m venv venv
                      . venv/bin/activate
                      pip install -e '.[test]'
                      coverage run -m pytest
                      coverage report
                    '''
            }
        }
        stage('Docker image build'){
            steps {
                sh '''echo 'Building...'
                    '''
                script {
                    env.myImg = docker.build("agent:$BUILD_ID")
                }
            }
        }
        stage('Docker hub authentication'){
            environment {
                LOG = credentials('dockerhub')
            }
            steps {
                sh '''echo 'Authenticating...'
                      docker login -u ${LOG_USR} -p ${LOG_PSW}
                    '''
            }
        }
        stage('Push docker image'){
            steps {
                sh '''echo 'Building...'
                      docker tag agent:${BUILD_ID} hopenohype/monavaft:agent:${BUILD_ID}
                      docker push hopenohype/monavaft
                    '''
            }
        }
    }
    post {
        success {
            echo 'this will run only if succesfull'
        }
        failure {
            echo 'this will run only if failed'
        }
    }
}
