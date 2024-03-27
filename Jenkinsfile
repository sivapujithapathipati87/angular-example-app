pipeline {
    agent any
    environment {
        SONAR_SCANNER='/opt/sonar-scanner' // Corrected variable name
        DOCKER_CREDS = credentials('docker123')
        DOCKER_IMAGE = 'sivapujitha'
    }
           // sonar code quality check
        stage('Sonar Analysis') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonarqube', installationName: 'sonarqube') {
                    sh """
                    \${SONAR_SCANNER}/bin/sonar-scanner \
                    -Dsonar.projectKey=angular \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://localhost:9000 \
                    -Dsonar.login=sqp_5ecda522e2bfd890796bbe764381d30dae231b99
                    """
                }
            }
        }
        // docker image build using dockerfile 
        stage('Docker Build') {
            steps {
                sh 'docker image build -t angular .'
            }
        }
        // push docker image to dockerhub
         stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker123', usernameVariable: 'DOCKER_CREDS_USR', passwordVariable: 'DOCKER_CREDS_PSW')]) {
                        sh 'docker login -u $DOCKER_CREDS_USR -p $DOCKER_CREDS_PSW'
                    }
                    sh 'docker tag react $DOCKER_IMAGE/angular:latest'
                    sh 'docker push $DOCKER_IMAGE/angular:latest'

                }
            }
        }
        // run the container using docker image
        stage('Run') {
            steps {
                sh 'docker run -d -p 4200:4200 --name angular angular'
            }
        }
        //trivy image scanner
        stage('Trivy image scan') {
            steps {
                sh 'trivy image angular'
            }
        }
    }
    // email notification
         post {
           success {
                    mail subject: 'build stage succeded',
                          to: 'pujisiri2008@gmail.com',
                          body: "Refer to $BUILD_URL for more details"
            }
           failure {
                    mail subject: 'build stage failed',
                         to: 'pujisiri2008@gmail.com',
                         body: "Refer to $BUILD_URL for more details"
                }
        }
}
