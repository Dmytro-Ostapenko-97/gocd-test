pipeline {
	agent any

	stages {
		stage('Test_1') {
			steps {
				script {
					sh '''pwd'''
				}
			}
		}
		stage('Test_2') {
			steps {
				script {
					sh '''echo "Alert"'''
				}
			}
		}
	}

	post {
	    success {
	      slackSend (color: '#00BB00', message: "SUCCESS: Job name: '${env.JOB_NAME}' build number: ${env.BUILD_NUMBER}.\n More info at: ${env.BUILD_URL}")
	    }

	    failure {
	      slackSend (color: '#FF0000', message: "FAILED: Job name: '${env.JOB_NAME}' build number: ${env.BUILD_NUMBER}.\n More info at: ${env.BUILD_URL}")
	    }
  	}
}