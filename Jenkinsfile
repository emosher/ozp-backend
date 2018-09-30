pipeline {
    agent { dockerfile true }
    stages {
        stage('Build ozp-backend') {
            steps {
                sh '''
                    sh ./jenkins/build.sh
                '''
            }
        }
        stage('Test OZP') {
            steps {
                sh '''
                    sh ./jenkins/test.sh
                '''
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'backend*.tar.gz'
            }
        }
    }
    post {
        always {
            junit 'junit-resutls.xml'
        }
    }
}