pipeline {
    agent any
    
    stages {
        stage('Build') { 
            steps {
                sh "./mvnw clean package -DskipTests"
            }
        }

        stage('Unit tests') { 
            steps {
                sh "./mvnw test -Punit"
            }
        }

        stage('Create Docker Image') {
            steps {
                script{
                    docker.build("ohadisra/petclinic:latest")
                }
            }
        }
        stage ('Deploy'){
            steps{
                configFileProvider([configFile(fileId: 'mvn_settings', variable: 'SETTINGS')]) {
                    sh "./mvnw -s $SETTINGS deploy -DskipTests -Dartifactory_url=http://artifactory:8081/artifactory"
                }
            }
        }    
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            archiveArtifacts artifacts: 'target/**/*.xml'
            junit 'target/**/*.xml'
        }
    }
}